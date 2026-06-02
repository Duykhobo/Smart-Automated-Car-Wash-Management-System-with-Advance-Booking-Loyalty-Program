package utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

/**
 * Tiện ích hỗ trợ xử lý việc Upload Ảnh/File an toàn
 */
public class FileUploadUtil {

    // Thư mục lưu trữ ảnh (Nằm trong thư mục web/assets/uploads)
    private static final String UPLOAD_DIR = "assets/uploads";

    /**
     * Hàm lưu file từ Request và trả về đường dẫn tương đối để lưu vào DB.
     * Trả về null nếu người dùng không chọn file nào.
     */
    public static String saveFile(HttpServletRequest request, String partName, String uploadPath) throws IOException {
        try {
            Part part = request.getPart(partName);
            if (part == null || part.getSize() == 0) {
                return null; // Không có file được tải lên
            }

            // Lấy tên gốc của file
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            if (fileName == null || fileName.isEmpty()) {
                return null;
            }

            // --- BẢO MẬT: Kiểm tra đuôi file (File Extension Whitelist) ---
            String fileExtension = "";
            int dotIndex = fileName.lastIndexOf(".");
            if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
                fileExtension = fileName.substring(dotIndex + 1).toLowerCase();
            }
            
            // Danh sách các đuôi file an toàn
            String[] allowedExtensions = {"jpg", "jpeg", "png", "gif", "webp"};
            boolean isValidExtension = false;
            for (String ext : allowedExtensions) {
                if (ext.equals(fileExtension)) {
                    isValidExtension = true;
                    break;
                }
            }
            
            if (!isValidExtension) {
                // Nếu đuôi file không hợp lệ, chặn ngay lập tức
                System.err.println("CẢNH BÁO: Phát hiện người dùng cố tình upload file không hợp lệ: " + fileName);
                return null; 
            }
            // -------------------------------------------------------------

            String extension2 = "";
            int dotIndex2 = fileName.lastIndexOf(".");
            if (dotIndex2 > 0) {
                extension2 = fileName.substring(dotIndex2);
            }
            String uniqueFileName = UUID.randomUUID().toString() + extension2;

            // Đảm bảo thư mục tồn tại
            String applicationPath = request.getServletContext().getRealPath("");
            String finalUploadPath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(finalUploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lưu file vật lý
            part.write(finalUploadPath + File.separator + uniqueFileName);

            // Chỉ trả về TÊN FILE để lưu vào DB (VD: xxxxx-Hinh.png)
            return uniqueFileName;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
