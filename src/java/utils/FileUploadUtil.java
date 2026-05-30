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

            // Tạo tên file ngẫu nhiên để không bị đè ảnh khi trùng tên (VD: Hinh.png -> xxxxx-Hinh.png)
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

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
