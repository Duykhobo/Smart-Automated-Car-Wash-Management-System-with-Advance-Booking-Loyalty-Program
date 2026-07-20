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
        LOGGER.info("=== SMART CAR WASH SYSTEM STARTED ===");

        // Khởi tạo bộ đếm nhịp (Scheduler) chạy ngầm với 1 luồng duy nhất
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // Định nghĩa Công việc cần làm (Task)
        Runnable cancelTask = () -> {
            try {
                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.autoCancelExpiredBookings();
                bookingDAO.autoPromoteWaitlist();
            } catch (Exception e) {
                LOGGER.severe("Error in Background Job thread: " + e.getMessage());
            }
        };

        // Bắt đầu chạy ngầm: Chờ 1 phút rồi chạy, sau đó cứ lặp lại mỗi 1 phút
        scheduler.scheduleAtFixedRate(cancelTask, 1, 1, TimeUnit.MINUTES);
        LOGGER.info("=> Background Job [Auto-Cancel Expired Bookings] activated and running in background.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            LOGGER.info("=== SMART CAR WASH SYSTEM SHUTDOWN: Background Job cleaned up ===");
        }
    }
}
