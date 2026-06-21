package listener;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import dao.BookingDAO;

@WebListener
public class AppStartupListener implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(AppStartupListener.class.getName());
    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("=== HỆ THỐNG SMART CAR WASH ĐÃ KHỞI ĐỘNG ===");

        // Khởi tạo bộ đếm nhịp (Scheduler) chạy ngầm với 1 luồng duy nhất
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // Định nghĩa Công việc cần làm (Task)
        Runnable cancelTask = () -> {
            try {
                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.autoCancelExpiredBookings();
            } catch (Exception e) {
                LOGGER.severe("Lỗi trong luồng Background Job: " + e.getMessage());
            }
        };

        // Bắt đầu chạy ngầm: Chờ 1 phút rồi chạy, sau đó cứ lặp lại mỗi 1 phút
        scheduler.scheduleAtFixedRate(cancelTask, 1, 1, TimeUnit.MINUTES);
        LOGGER.info("=> Background Job [Auto-Cancel Expired Bookings] đã được kích hoạt chạy ngầm.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            LOGGER.info("=== HỆ THỐNG SMART CAR WASH TẮT: Đã dọn dẹp Background Job ===");
        }
    }
}
