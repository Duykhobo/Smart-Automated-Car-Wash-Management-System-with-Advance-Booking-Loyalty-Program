package service;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.BookingDAO;
import dao.CarDao;
import dao.CustomerDAO;
import dao.MemberTierDAO;
import dao.ServiceDAO;
import dao.SystemConfigDAO;
import dto.Cars;
import dto.Customer;
import dto.MemberTier;
import dto.Service;

public class BookingService {

    private final CarDao carDao = new CarDao();
    private final ServiceDAO serviceDao = new ServiceDAO();
    private final MemberTierDAO tierDao = new MemberTierDAO();
    private final SystemConfigDAO configDao = new SystemConfigDAO();
    private final BookingDAO bookingDao = new BookingDAO();

    public Map<String, Object> prepareBookingPageData(Customer customer) throws Exception {
        Map<String, Object> data = new HashMap<>();

        // Fetch cars
        List<Cars> vehicles = carDao.getAllCars(customer.getCustomerId());
        data.put("vehicles", vehicles);

        // Fetch services and dynamic prices
        List<Service> services = serviceDao.getAllActiveServices();
        data.put("services", services);
        
        String servicePricesJson = serviceDao.getServicePricesJson();
        data.put("servicePricesJson", servicePricesJson);

        // Determine Tier Name and Max Booking Days
        String tierStatus = customer.getTierStatus();
        String cleanTier = (tierStatus != null) ? tierStatus.trim() : "";
        MemberTier memberTier = tierDao.getTierByName(cleanTier);

        int maxBookingDays = memberTier != null ? memberTier.getMaxBookingDays() : 7;
        data.put("tierName", memberTier != null ? memberTier.getTierName() : "Member");
        data.put("maxBookingDays", maxBookingDays);
        data.put("badgeClass", memberTier != null ? memberTier.getBadgeClass() : "badge-member");
        data.put("bannerBorder", memberTier != null ? memberTier.getBannerBorder() : "border-slate-500");
        data.put("bannerBg", memberTier != null ? memberTier.getBannerBg() : "bg-slate-500/20");
        data.put("bannerIcon", memberTier != null ? memberTier.getBannerIcon() : "text-slate-500");
        data.put("bannerText", memberTier != null ? memberTier.getBannerText() : "text-slate-400");

        // Generate dynamic days
        List<LocalDate> dynamicDays = new ArrayList<>();
        LocalDate today = LocalDate.now();
        for (int i = 0; i < maxBookingDays; i++) {
            dynamicDays.add(today.plusDays(i));
        }
        data.put("dynamicDays", dynamicDays);

        // Fetch System Config for Opening/Closing hours
        int openingHour = configDao.getOpeningHour();
        int closingHour = configDao.getClosingHour();

        // Generate time slots
        List<String> timeSlots = new ArrayList<>();
        for (int i = openingHour; i <= closingHour; i++) {
            timeSlots.add(String.format("%02d:00", i));
        }
        data.put("timeSlots", timeSlots);

        return data;
    }

    public void validateTravelTime(Date bookingDate, Time scheduledTime) throws Exception {
        int minAdvanceBookingMinutes = configDao.getMinAdvanceBookingMinutes();
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        java.time.LocalDateTime scheduledDateTime = java.time.LocalDateTime.of(bookingDate.toLocalDate(), scheduledTime.toLocalTime());
        
        if (scheduledDateTime.isBefore(now.plusMinutes(minAdvanceBookingMinutes))) {
            throw new Exception("Vui lòng đặt lịch trước giờ đến ít nhất " + minAdvanceBookingMinutes + " phút để chúng tôi chuẩn bị.");
        }
    }

    public void validateWorkingHours(Time scheduledTime, int totalDurationMinutes) throws Exception {
        int closingHour = configDao.getClosingHour();
        java.time.LocalTime startTime = scheduledTime.toLocalTime();
        java.time.LocalTime endTime = startTime.plusMinutes(totalDurationMinutes);
        java.time.LocalTime closingTime = java.time.LocalTime.of(closingHour, 0);
        
        // If endTime is before startTime, it means it crossed midnight.
        // Or if endTime is after closing time.
        if (endTime.isBefore(startTime) || endTime.isAfter(closingTime)) {
            throw new Exception("Lỗi: Tổng thời gian làm dịch vụ (" + totalDurationMinutes + " phút) vượt quá giờ đóng cửa của gara (" + closingHour + ":00). Vui lòng chọn giờ sớm hơn hoặc bớt dịch vụ.");
        }
    }

    public List<Service> getServicesByIds(String[] serviceIds) throws Exception {
        List<Service> allServices = serviceDao.getAllActiveServices();
        List<Service> selected = new ArrayList<>();
        if (serviceIds == null || serviceIds.length == 0) throw new Exception("Vui lòng chọn ít nhất 1 dịch vụ.");
        for (String idStr : serviceIds) {
            int sid = Integer.parseInt(idStr);
            boolean found = false;
            for (Service s : allServices) {
                if (s.getServiceId() == sid) {
                    selected.add(s);
                    found = true;
                    break;
                }
            }
            if (!found) throw new Exception("Dịch vụ không hợp lệ.");
        }
        return selected;
    }

    public boolean createBooking(int customerId, String serviceIds, int vehicleId, Integer voucherId, Date bookingDate, Time scheduledTime, double originalPrice, double discountAmount, double finalPrice, int totalDurationMinutes) throws Exception {
        return bookingDao.createBookingTransaction(
                customerId,
                serviceIds,
                vehicleId,
                voucherId,

                bookingDate,
                scheduledTime,
                originalPrice,
                discountAmount,
                finalPrice,
                totalDurationMinutes);
    }
}
