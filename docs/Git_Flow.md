### Giai đoạn 1: Lấy code mới nhất và Tạo nhánh làm việc

_Luôn làm bước này vào đầu ngày hoặc khi bắt đầu một task mới._

```bash
# 1. Chuyển về nhánh làm việc chung của cả team
git checkout develop

# 2. Kéo code mới nhất từ server về máy
git pull origin develop

# 3. Tạo và chuyển sang nhánh tính năng mới
# (Ví dụ: feature/login, feature/create-database, feature/ui-booking)
git checkout -b feature/<tên-nhánh-của-bạn>

```

---

### Giai đoạn 2: Trong quá trình code

_Chia nhỏ công việc, code được một phần thì lưu lại ngay, lặp lại nhiều lần bước này._

```bash
# 1. Xem mình đã sửa những file nào
git status

# 2. Đưa tất cả các file đã sửa vào danh sách chuẩn bị lưu
git add .

# 3. Đóng gói và ghi chú lại thay đổi
# (Ví dụ: "feat: làm xong giao diện", "fix: sửa lỗi nút bấm")
git commit -m "<mô-tả-ngắn-gọn-những-gì-vừa-làm>"

```

---

### Giai đoạn 3: Cập nhật code từ team & Xử lý xung đột

_Làm bước này khi đã code xong task và chuẩn bị đẩy lên mạng._

```bash
# 1. Kéo thông tin mới nhất từ server về máy (chưa gộp)
git fetch origin

# 2. Trộn code mới nhất của team vào nhánh của bạn
git merge origin/develop

```

⚠️ **CHÚ Ý:** Nếu bước 2 báo lỗi **CONFLICT**, hãy mở VS Code lên, tìm file bị lỗi để sửa. Sửa xong bắt buộc phải chạy lệnh: `git add .` và `git commit -m "fix: resolve conflict"`

---

### Giai đoạn 4: Đẩy code lên Server

_Khi code ở máy đã chạy tốt và không còn xung đột._

```bash
# Đẩy nhánh của bạn lên GitHub
git push origin feature/<tên-nhánh-của-bạn>

```

---

### Giai đoạn 5: Tạo Pull Request (Trên GitHub)

1. Lên trang GitHub của dự án, bấm nút **Compare & pull request**.
2. Chọn thông số:

- **BASE (Nhánh đích):** `develop`
- **COMPARE (Nhánh nguồn):** `feature/<tên-nhánh-của-bạn>`

3. Bấm **Create pull request** và chờ Tech Lead duyệt code.

---

### Giai đoạn 6: Dọn dẹp chiến trường

_Chỉ làm bước này SAU KHI Pull Request đã được Tech Lead bấm Merge._

```bash
# 1. Trở về nhánh chung
git checkout develop

# 2. Kéo code tổng mới nhất (đã có code của bạn) về máy
git pull origin develop

# 3. Xóa nhánh tính năng cũ đi cho nhẹ máy
git branch -d feature/<tên-nhánh-của-bạn>

```
