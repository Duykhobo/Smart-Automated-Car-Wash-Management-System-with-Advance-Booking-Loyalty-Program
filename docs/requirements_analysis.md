# AUTOWASH PRO: HỆ THỐNG QUẢN LÝ RỬA XE TỰ ĐỘNG THÔNG MINH
## TÀI LIỆU PHÂN TÍCH YÊU CẦU NGHIỆP VỤ & HỆ THỐNG (CHUẨN BỊ CHO SRS)

Tài liệu này cung cấp bản phân tích chuyên sâu dưới góc nhìn của Business Analyst (BA) và System Analyst (SA) thực tế cho dự án **AutoWash Pro**. Tài liệu làm cầu nối giữa các yêu cầu nghiệp vụ thô và chi tiết triển khai kỹ thuật, được tối ưu hóa cho nền tảng công nghệ Java Servlet/JSP và cơ sở dữ liệu SQL Server.

---

## 1. TỔNG QUAN HỆ THỐNG

### 1.1 Mục tiêu Kinh doanh (Business Goals)
*   **Tối đa hóa tỷ lệ giữ chân khách hàng (Customer Retention):** Chuyển đổi từ chương trình thẻ giấy truyền thống "rửa 5 tặng 1" sang chương trình khách hàng thân thiết nhiều cấp độ (Multi-tier Loyalty) dựa trên dữ liệu. Các nghiên cứu bán lẻ hiện đại chứng minh rằng khách hàng trung thành chi tiêu nhiều hơn 67% và ghé thăm thường xuyên hơn gấp 3 lần. AutoWash Pro hướng tới mục tiêu tăng tỷ lệ khách hàng quay lại thêm **45%** và giá trị trọn đời của khách hàng (LTV) thêm **60%**.
*   **Tối ưu hóa hiệu suất vận hành:** Giảm thiểu tình trạng tắc nghẽn hàng chờ vào giờ cao điểm. Việc điều phối đặt lịch trước (Advance Booking) giúp phân bổ đều tần suất sử dụng các khoang rửa trong ngày, tăng công suất phục vụ tối đa của cửa hàng.
*   **Tiếp thị hướng mục tiêu dựa trên dữ liệu (Data-Driven Marketing):** Thay thế các chương trình khuyến mãi đại trà bằng các chiến dịch tiếp thị chính xác nhắm vào từng phân khúc khách hàng (ví dụ: chỉ gửi ưu đãi cho hạng "Bạc+" hoặc "Bạch Kim") để tối đa hóa tỷ lệ chuyển đổi và ROI marketing.
*   **Trải nghiệm khách hàng không điểm chạm (Frictionless Onboarding):** Tích hợp công nghệ nhận diện biển số xe (LPR - License Plate Recognition) để liên kết phương tiện vật lý của khách hàng với hồ sơ số, cho phép tự động mở cổng chào đón và kích hoạt hàng chờ ưu tiên ngay khi xe vào bãi.

### 1.2 Mục tiêu Người dùng (User Goals)
*   **Khách hàng (Customer):** Sử dụng ứng dụng di động (giao diện web tối ưu hóa cho di động) để chủ động đặt lịch trước lên tới 14 ngày, theo dõi điểm thưởng tích lũy theo thời gian thực, nhận đặc quyền ưu tiên đặt slot giờ vàng và dễ dàng đổi điểm lấy các dịch vụ gia tăng (phủ wax miễn phí, giảm giá trực tiếp).
*   **Quản trị viên (Admin):** Dễ dàng cấu hình các tham số hệ thống (hệ số nhân điểm, quy tắc nâng hạng), thiết lập các chiến dịch khuyến mãi mục tiêu, điều chỉnh hạng thẻ thủ công khi cần và giám sát hoạt động vận hành.
*   **Quản lý/Chủ doanh nghiệp (Manager):** Theo dõi hiệu quả kinh doanh thông qua báo cáo trực quan về doanh thu theo phân khúc khách hàng trung thành, tần suất sử dụng khoang rửa và chi phí quy đổi điểm thưởng để đưa ra quyết định tối ưu hóa dòng tiền.

### 1.3 Phạm vi Hệ thống (System Scope)

**Cấu trúc phân hệ AutoWash Pro:**
*   **Mobile Web Portal (Khách hàng):** Giao diện tương tác để đặt lịch, theo dõi hạng thành viên, tích điểm và đổi quà.
*   **Web App (Admin & Manager):** Công cụ quản lý luật Loyalty, thiết lập khuyến mãi mục tiêu và phân tích báo cáo doanh thu.
*   **Mock API Cổng LPR:** Cổng giả lập để gửi biển số xe, quét xác thực và tự động xếp vị trí trong hàng chờ ưu tiên.
*   **Tomcat Servlet Container & JDBC Driver:** Cầu nối trung gian xử lý logic nghiệp vụ và kết nối với cơ sở dữ liệu SQL Server.

#### Trong phạm vi phát triển (In-Scope):
1.  **Động cơ Loyalty (Loyalty Engine):** Bộ xử lý tự động tính toán tích điểm (theo hệ số nhân của từng hạng thẻ), tự động xét nâng/hạ hạng định kỳ hàng tháng, xử lý đổi điểm lấy Voucher và tự động hủy điểm hết hạn theo cơ chế FIFO (12 tháng).
2.  **Động cơ Đặt lịch theo Hạng (Tier-Based Booking Engine):** Logic kiểm soát thời gian đặt lịch trước theo cấp độ thành viên (7 đến 14 ngày) và thuật toán tính điểm ưu tiên xếp hàng (Priority Queue).
3.  **API mô phỏng nhận diện biển số (LPR Simulation API):** Endpoint nhận dữ liệu biển số xe quét từ cổng, đối chiếu với danh sách đặt lịch trong ngày để tự động xác nhận check-in và đẩy xe vào hàng chờ ưu tiên.
4.  **Bảng điều khiển cấu hình luật & Khuyến mãi (Admin Console):** Giao diện cho phép thay đổi tỷ lệ tích điểm, giá trị quy đổi quà tặng và thiết lập các chương trình khuyến mãi nhắm chọn đối tượng thành viên.
5.  **Báo cáo Analytics cho Quản lý:** Tổng hợp trực quan các chỉ số doanh thu, tỷ lệ phân bổ hạng thẻ và hiệu suất sử dụng khoang rửa theo thời gian.

#### Ngoài phạm vi phát triển (Out-of-Scope):
1.  **Viết ứng dụng di động Native (Android/iOS):** "Mobile App" cho khách hàng sẽ được triển khai dưới dạng trang Web tối ưu hiển thị trên di động (Mobile-Responsive Web App) bằng HTML5/JSP/CSS để đồng bộ với cấu trúc Java Servlet.
2.  **Tích hợp phần cứng camera LPR vật lý:** Việc nhận diện biển số sẽ được giả lập thông qua một giao diện API kiểm thử hoặc công cụ hỗ trợ (như Postman) gửi chuỗi biển số dạng Text về hệ thống.
3.  **Tích hợp cổng thanh toán trực tuyến (VNPay/Momo):** Để tập trung vào nghiệp vụ chính là Loyalty và Đặt lịch, các giao dịch thanh toán sẽ được đánh dấu trạng thái "Thanh toán tại quầy" hoặc sử dụng số dư ví giả lập (Simulated Wallet Balance).

### 1.4 Các giả định quan trọng (Critical Assumptions)
*   **Một xe hoạt động tại một thời điểm:** Để đơn giản hóa logic, mỗi tài khoản khách hàng chỉ liên kết với duy nhất một biển số xe hoạt động tại một thời điểm. Nếu đổi xe, khách hàng phải cập nhật biển số trong phần thông tin cá nhân.
*   **Đồng nhất múi giờ:** Hệ thống hoạt động thống nhất trên múi giờ Việt Nam (ICT - UTC+7) cho mọi tính toán giờ đặt lịch và hạn dùng của điểm.
*   **Không đặt lịch trùng giờ:** Một khách hàng không thể tạo hai lịch đặt ở trạng thái "Chờ duyệt" hoặc "Đã xác nhận" trong cùng một khung giờ.
*   **Chạy quét hạ hạng định kỳ:** Việc rà soát và hạ hạng thành viên được thực hiện tự động vào lúc 00:00:00 ngày 1 hàng tháng. Trong khi đó, việc nâng hạng sẽ được tính toán lập tức theo thời gian thực (Real-time) ngay sau khi khách hàng hoàn thành hóa đơn rửa xe đủ điều kiện.

---

## 2. PHÂN TÍCH TÁC NHÂN (ACTORS)

| Tác nhân (Actor) | Vai trò (Role) | Phân quyền (Permissions) | Mục tiêu chính | Hành động tiêu biểu |
| :--- | :--- | :--- | :--- | :--- |
| **Khách vãng lai** (Guest) | Người dùng chưa đăng ký | Xem bảng giá dịch vụ công khai, xem danh sách đặc quyền các hạng thẻ, Đăng ký tài khoản. | Tìm hiểu lợi ích hệ thống và tạo tài khoản mới. | Duyệt trang chủ, Xem bảng giá dịch vụ, Đăng ký (nhập Số điện thoại, Họ tên, Biển số xe, Mật khẩu). |
| **Khách hàng** (Customer) | Thành viên đã đăng ký | Đặt/Hủy lịch hẹn cá nhân, xem điểm tích lũy/hạng thẻ, xem lịch sử giao dịch, đổi điểm lấy voucher. | Đặt lịch rửa xe nhanh chóng, nhận tối đa ưu đãi thành viên VIP, tích lũy điểm thưởng. | Đăng nhập/Đăng xuất, Đặt lịch rửa xe, Đổi điểm lấy Voucher, Theo dõi hạn dùng của điểm, Cập nhật thông tin cá nhân. |
| **Quản trị viên** (Admin) | Người vận hành hệ thống | Quản lý người dùng (CRUD), chỉnh sửa luật tích điểm, cấu hình ưu đãi, kích hoạt giả lập LPR. | Đảm bảo hệ thống hoạt động ổn định, giải quyết khiếu nại điểm số, kiểm thử tính năng LPR. | Thay đổi tỷ lệ quy đổi điểm, quản lý thông tin khách hàng, cấu hình khuyến mãi, mô phỏng xe đến cổng. |
| **Quản lý** (Manager) | Chủ cửa hàng / Doanh nghiệp | Xem tất cả báo cáo tài chính, xuất dữ liệu báo cáo, phân tích dashboard doanh thu. | Giám sát doanh thu, đánh giá hiệu quả chương trình Loyalty để tối ưu hóa lợi nhuận. | Xem biểu đồ doanh thu theo hạng thẻ, đánh giá tỷ lệ đổi voucher, giám sát công suất khoang rửa giờ cao điểm. |

---

## 3. PHÂN TÍCH YÊU CẦU CHỨC NĂNG

### 3.1 Module: Xác thực & Tài khoản (Authentication)
*   **Mô tả:** Quản lý quy trình đăng ký, đăng nhập, đăng xuất và bảo mật phiên làm việc.
*   **Mục đích Nghiệp vụ:** Xác định danh tính khách hàng để ghi nhận điểm tích lũy và kiểm soát quyền hạn đặt lịch.
*   **Đầu vào (Inputs):** Họ tên, Số điện thoại (10 chữ số), Biển số xe, Mật khẩu (tối thiểu 8 ký tự).
*   **Đầu ra (Outputs):** Phiên làm việc (HttpSession) được thiết lập, chuyển hướng về trang Dashboard tương ứng.
*   **Quy tắc Kiểm tra dữ liệu (Validation Rules):**
    *   Số điện thoại không được trùng lặp trong bảng `Customers`.
    *   Biển số xe phải đúng định dạng giao thông Việt Nam (Ví dụ: `30A-123.45` hoặc `51K-9876`) và không trùng lặp.
*   **Luồng xử lý chính (Main Flow):**
    1.  Khách nhập thông tin đăng ký trên giao diện.
    2.  Hệ thống mã hóa mật khẩu bằng thuật toán SHA-256 kèm chuỗi muối (Salt).
    3.  Lưu thông tin đồng thời vào bảng `Users` và `Customers` trong cùng một Database Transaction.
    4.  Tạo Session đăng nhập và chuyển hướng khách hàng về trang chào mừng thành viên mới.
*   **Trường hợp ngoại lệ (Exception Cases):**
    *   *Trùng lặp dữ liệu:* Nếu số điện thoại hoặc biển số xe đã tồn tại trong DB, hệ thống từ chối đăng ký và trả lời: *"Số điện thoại hoặc Biển số xe này đã được đăng ký trên hệ thống."*
*   **Phụ thuộc (Dependencies):** Kết nối SQL Server ổn định, thư viện `javax.servlet.http.HttpSession`.

### 3.2 Module: Hồ sơ cá nhân & Thống kê Hạng (Customer Profile)
*   **Mô tả:** Hiển thị chi tiết hạng thẻ hiện tại, số điểm khả dụng, tổng chi tiêu tích lũy, số lượt rửa xe đã thực hiện và tiến trình đạt hạng tiếp theo.
*   **Mục đích Nghiệp vụ:** Áp dụng cơ chế Gamification (trò chơi hóa), kích thích khách hàng tiếp tục chi tiêu bằng cách hiển thị trực quan khoảng cách tới hạng thẻ kế tiếp.
*   **Đầu vào (Inputs):** ID khách hàng lấy từ Session.
*   **Đầu ra (Outputs):** Thông tin chi tiết khách hàng, huy hiệu hạng thẻ (Tier Badge), thanh tiến trình (Progress Bar).
*   **Luồng xử lý chính:**
    1.  Khách hàng tải trang Dashboard cá nhân.
    2.  Hệ thống truy vấn số lượt rửa xe hoàn thành và tổng chi tiêu từ DB.
    3.  Hệ thống so sánh các chỉ số này với bảng điều kiện `LoyaltyRules`.
    4.  Tính toán: `Số điểm cần thêm` và `Số lượt rửa xe cần thêm` để thăng hạng.
    5.  Hiển thị trực quan thanh tiến trình thăng hạng (Ví dụ: *"Bạn chỉ cần rửa xe thêm 2 lần hoặc chi tiêu 300,000 VND nữa để đạt hạng Bạc"*).
*   **Phụ thuộc (Dependencies):** Bảng `LoyaltyRules` trong database.

### 3.3 Module: Động cơ Loyalty (Loyalty Engine)
*   **Mô tả:** Bộ não của hệ thống chịu trách nhiệm tích điểm theo hệ số nhân hạng thẻ, thực hiện thăng/hạ hạng thẻ, xử lý đổi điểm lấy Voucher và khấu trừ điểm theo cơ chế FIFO.
*   **Mục đích Nghiệp vụ:** Đảm bảo toàn bộ quy trình tích lũy và sử dụng điểm diễn ra tự động, chính xác, không cần nhân viên can thiệp thủ công.
*   **Đầu vào (Inputs):** Giá trị hóa đơn rửa xe, lệnh xác nhận hoàn thành dịch vụ, hoặc yêu cầu đổi điểm của khách.
*   **Đầu ra (Outputs):** Số điểm tích lũy mới, trạng thái hạng thẻ cập nhật, mã Voucher đổi thưởng.
*   **Các luồng xử lý chính:**
    *   *Luồng Tích điểm (Accrual):*
        1.  Nhân viên nhấn xác nhận hoàn thành rửa xe cho khách (Giá trị hóa đơn: 200,000 VND).
        2.  Hệ thống lấy hạng thẻ hiện tại của khách (Ví dụ: Gold).
        3.  Hệ thống tìm luật tích điểm: Tỷ lệ gốc = 1 điểm cho mỗi 1,000 VND. Hệ số thưởng hạng Gold = +20% điểm.
        4.  Tính điểm gốc: `200,000 / 1,000 = 200 điểm`.
        5.  Tính điểm thưởng thêm: `200 * 20% = 40 điểm`. Tổng điểm tích lũy đợt này = 240 điểm.
        6.  Ghi một dòng vào bảng `PointLedger` với các giá trị: `PointsChange = 240`, `PointsRemaining = 240`, `EarnedDate = Ngày Hiện Tại`, `ExpiryDate = Ngày Hiện Tại + 12 Tháng`.
        7.  Cộng dồn số dư điểm `PointsBalance` trong hồ sơ khách hàng.
    *   *Luồng Nâng hạng tức thời (Instant Upgrade):*
        1.  Ngay sau khi hoàn thành hóa đơn, hệ thống đếm lại tổng số lượt rửa xe tích lũy của khách hàng trong 12 tháng qua.
        2.  Nếu số lượt đạt mức 15 lượt (điều kiện thăng hạng Vàng), hệ thống cập nhật `TierStatus` của khách thành `Gold`.
        3.  Ghi nhận sự kiện vào lịch sử thăng hạng `TierHistory`.
    *   *Luồng Đổi thưởng (Redeem):*
        1.  Khách chọn đổi "300 điểm lấy Voucher phủ sáp Wax miễn phí".
        2.  Hệ thống kiểm tra số dư điểm khả dụng `PointsBalance` >= 300.
        3.  Trừ 300 điểm trong số dư khả dụng của khách.
        4.  Lấy các dòng điểm tích lũy còn hạn từ bảng `PointLedger` theo thứ tự thời gian tăng dần (FIFO - cũ nhất trước) và thực hiện khấu trừ cho đến khi đủ 300 điểm.
        5.  Tạo mã voucher ngẫu nhiên duy nhất (Ví dụ: `WAX300-AB73K9`).
        6.  Lưu Voucher vào bảng `Vouchers` với trạng thái `Unused` (Chưa sử dụng).

### 3.4 Module: Động cơ Đặt lịch (Booking Engine)
*   **Mô tả:** Quản lý lịch hẹn, kiểm tra sức chứa khoang rửa theo giờ, kiểm soát khoảng thời gian đặt lịch trước theo hạng thẻ và tính điểm ưu tiên xếp hàng.
*   **Mục đích Nghiệp vụ:** Phân phối đều lượng xe vào các khung giờ, giảm tải thời gian chờ đợi tại cửa hàng và gia tăng quyền lợi độc quyền cho thành viên VIP.
*   **Đầu vào (Inputs):** Loại dịch vụ, Ngày hẹn, Khung giờ chọn, Mã Voucher/Promo (nếu có).
*   **Đầu ra (Outputs):** Hồ sơ đặt lịch thành công, mã số thứ tự ưu tiên (Priority Score).
*   **Quy tắc Kiểm tra (Validation Rules):**
    *   Ngày đặt lịch phải nằm trong giới hạn cho phép của hạng thành viên:
        *   **Member:** Tối đa đặt trước 7 ngày.
        *   **Silver:** Tối đa đặt trước 10 ngày.
        *   **Gold:** Tối đa đặt trước 12 ngày.
        *   **Platinum:** Tối đa đặt trước 14 ngày.
    *   Khung giờ được chọn phải còn chỗ trống (Ví dụ: Mỗi giờ tối đa nhận 3 xe).
*   **Luồng xử lý chính:**
    1.  Khách hàng chọn ngày và giờ muốn đặt lịch.
    2.  Hệ thống đối chiếu hạng thẻ của khách để xác nhận ngày chọn nằm trong giới hạn cho phép.
    3.  Hệ thống kiểm tra bảng `Bookings` xem khung giờ đó đã đạt giới hạn 3 xe chưa.
    4.  Khách nhập Voucher giảm giá -> Hệ thống kiểm tra và áp dụng giảm trừ tiền.
    5.  Khách nhấn xác nhận đặt lịch -> Hệ thống tính toán chỉ số ưu tiên xếp hàng (Priority Score) và lưu thông tin đặt lịch.
*   **Công thức tính điểm ưu tiên (Priority Score):**
    $$\text{PriorityScore} = (\text{TierRank} \times 1000) + (100000 - \text{BookingMinutesFromMidnight})$$
    *Giúp hệ thống tự động ưu tiên xe có hạng thẻ cao hơn và đặt lịch sớm hơn khi xếp lịch tại cổng vào.*

---

## 4. PHÂN TÍCH QUY TẮC NGHIỆP VỤ NÂNG CAO (BUSINESS RULES)

Quy tắc nghiệp vụ được chuẩn hóa dưới dạng thuật toán logic để lập trình viên hiện thực hóa chính xác trong các lớp xử lý của Java Servlet.

```
                  +--------------------------------------------------------+
                  |                 Đăng ký tài khoản                      |
                  +--------------------------------------------------------+
                                               |
                                               v
                  +--------------------------------------------------------+
                  |                Hạng: MEMBER (Mặc định)                 |
                  |                Tích điểm: 1,000 VND = 1 điểm            |
                  +--------------------------------------------------------+
                                               |
                        Rửa xe >= 5 lần   HOẶC   Chi tiêu >= 2,000,000 VND
                                               |
                                               v
                  +--------------------------------------------------------+
                  |                       Hạng: BẠC                        |
                  | Tặng: +10% Điểm thưởng, đặt lịch trước 10 ngày         |
                  +--------------------------------------------------------+
                                               |
                       Rửa xe >= 15 lần   HOẶC   Chi tiêu >= 6,000,000 VND
                                               |
                                               v
                  +--------------------------------------------------------+
                  |                       Hạng: VÀNG                       |
                  | Tặng: +20% Điểm, đặt lịch trước 12 ngày, nâng cấp free |
                  +--------------------------------------------------------+
                                               |
                       Rửa xe >= 30 lần   HOẶC   Chi tiêu >= 15,000,000 VND
                                               |
                                               v
                  +--------------------------------------------------------+
                  |                     Hạng: BẠCH KIM                     |
                  | Tặng: +30% Điểm, đặt trước 14 ngày, tặng 1 lần rửa/tháng|
                  +--------------------------------------------------------+
```

### 4.1 Quy tắc Tích lũy Điểm thưởng
*   **Công thức toán học:**
    $$\text{PointsEarned} = \left\lfloor \frac{\text{InvoiceAmount}}{1,000} \right\rfloor \times (1.0 + \text{TierBonusModifier})$$
*   **Bảng hệ số nhân thưởng theo hạng (TierBonusModifier):**
    *   **Member (Thường):** 0.0 (+0% điểm thưởng) -> Chi tiêu 100,000 VND tích 100 điểm.
    *   **Silver (Bạc):** 0.1 (+10% điểm thưởng) -> Chi tiêu 100,000 VND tích 110 điểm.
    *   **Gold (Vàng):** 0.2 (+20% điểm thưởng) -> Chi tiêu 100,000 VND tích 120 điểm.
    *   **Platinum (Bạch Kim):** 0.3 (+30% điểm thưởng) -> Chi tiêu 100,000 VND tích 130 điểm.
*   **Quy tắc làm tròn:** Số điểm lẻ luôn được làm tròn xuống (dùng `Math.floor()` trong Java) để đảm bảo không phát sinh điểm ảo ngoài ý muốn.

### 4.2 Quy tắc Nâng hạng & Hạ hạng Thành viên
*   **Nâng hạng (Xét duyệt tức thời - Real-time):**
    *   Được kiểm tra ngay lập tức tại thời điểm khách hàng thanh toán hóa đơn rửa xe thành công.
    *   Nếu khách hàng đạt đủ điều kiện số lần rửa HOẶC số tiền tích lũy của hạng thẻ cao hơn, hệ thống thực hiện nâng hạng ngay lập tức và ghi nhận lịch sử thăng hạng để khách hàng được hưởng ưu đãi ngay từ lần đặt sau.
*   **Hạ hạng (Xét duyệt định kỳ hàng tháng - Monthly Review):**
    *   Quá trình quét được thực hiện tự động vào lúc 00:00:00 ngày đầu tiên của mỗi tháng.
    *   Hệ thống kiểm tra tổng tích lũy số lần rửa xe và số tiền chi tiêu của khách hàng *trong vòng 12 tháng gần nhất (rolling 12 months)*.
    *   *Ví dụ:* Một thành viên hạng Vàng (Gold) chỉ đi rửa xe 10 lần và chi tiêu 4,000,000 VND trong vòng 12 tháng qua, hệ thống sẽ tự động hạ hạng của người này xuống hạng Bạc (Silver).
    *   **Quy tắc bảo vệ hạng (Grace Period):** Để tránh việc khách hàng bị lên/xuống hạng quá nhanh gây trải nghiệm không tốt, khi một khách hàng được nâng hạng, họ sẽ được **đảm bảo giữ nguyên hạng thẻ đó tối thiểu 3 tháng** trước khi chịu đợt quét hạ hạng đầu tiên.

### 4.3 Cơ chế Khấu trừ Điểm hết hạn theo FIFO
*   Điểm tích lũy từ mỗi hóa đơn có thời hạn sử dụng chính xác là 12 tháng.
*   Để khấu trừ điểm công bằng, hệ thống áp dụng cơ chế **FIFO (First-In, First-Out - Vào trước, Ra trước)**. Điểm được tích lũy trước sẽ được ưu tiên tiêu dùng trước.
*   *Mô tả cách hoạt động trên Cơ sở dữ liệu:*
    1.  Ngày 01/01/2026: Khách hàng tích lũy 100 điểm.
    2.  Ngày 01/02/2026: Khách hàng tích lũy thêm 200 điểm.
    3.  Ngày 01/03/2026: Khách hàng đổi quà hết 150 điểm.
    4.  Hệ thống xử lý:
        *   Dấu trừ 100 điểm từ đợt tích lũy ngày 01/01 (Số điểm còn lại của đợt này = 0).
        *   Dấu trừ thêm 50 điểm từ đợt tích lũy ngày 01/02 (Số điểm còn lại của đợt này = 150).
        *   Cập nhật số dư tài khoản khả dụng của khách hàng còn 150 điểm.
    5.  Đến ngày 02/01/2027 (Kỳ kiểm tra hết hạn đợt 1): Do 100 điểm của đợt ngày 01/01 đã được tiêu dùng hết trước đó, hệ thống ghi nhận số điểm hết hạn thực tế là 0 điểm.

### 4.4 Quy tắc Đổi điểm thưởng & Sử dụng Voucher
*   Việc đổi điểm không thể quy đổi ngược lại thành tiền mặt.
*   Điểm sau khi đổi sẽ sinh ra một mã Voucher điện tử, có giá trị sử dụng trong vòng **30 ngày**.
*   **Danh mục đổi thưởng mặc định:**
    *   **100 Điểm:** Đổi Voucher giảm giá 10% cho lần rửa tiếp theo (giảm tối đa 50,000 VND).
    *   **300 Điểm:** Đổi Voucher phủ sáp Wax miễn phí (trị giá dịch vụ gốc: 150,000 VND).
    *   **500 Điểm:** Đổi Voucher rửa xe gói Tiêu chuẩn miễn phí (trị giá dịch vụ gốc: 200,000 VND).
*   **Hạn chế áp dụng:** Mỗi lượt đặt lịch rửa xe chỉ cho phép áp dụng duy nhất 1 mã Voucher.

### 4.5 Quy tắc Đặt lịch, Hủy lịch & Xử lý No-Show
*   **Giới hạn đặt trước:** Hệ thống hiển thị lịch đặt linh hoạt dựa trên hạng thẻ của phiên đăng nhập hiện tại.
*   **Quy định Hủy lịch hẹn:** Khách hàng được quyền tự hủy lịch hẹn miễn phí trước giờ hẹn tối thiểu **12 tiếng**.
    *   Nếu hủy đúng hạn: Mọi điểm đổi Voucher áp dụng cho lịch hẹn đó sẽ được hoàn lại nguyên vẹn vào tài khoản.
    *   Nếu hủy muộn hoặc Không đến (No-Show): Khách hàng bị mất Voucher đã áp dụng và hệ thống ghi nhận 1 lần vi phạm No-Show.
    *   **Chế tài No-Show:** Nếu khách hàng tích lũy quá 3 lần No-Show trong vòng 30 ngày, hệ thống sẽ tự động khóa chức năng đặt lịch trực tuyến của tài khoản này trong vòng 14 ngày kế tiếp.

---

## 5. YÊU CẦU PHI CHỨC NĂNG (NON-FUNCTIONAL REQUIREMENTS - NFR)

Ánh xạ các yêu cầu phi chức năng từ đề bài vào kiến trúc phần mềm Java Servlet & SQL Server:

### 5.1 NFR-01: Thời gian Phản hồi (Response Time ≤ 5 giây cho 95% yêu cầu)
*   **Thách thức:** Hệ thống hiển thị dashboard và tìm kiếm lịch đặt cần phản hồi nhanh dưới tải thông thường.
*   **Giải pháp Kỹ thuật:**
    *   Sử dụng công nghệ **JDBC Connection Pooling** (như thư viện HikariCP hoặc Tomcat Connection Pool tích hợp) để tránh việc phải mở/đóng kết nối TCP vật lý tới SQL Server ở mỗi Request, giúp tiết kiệm thời gian xử lý từ 200ms xuống dưới 5ms.
    *   Tạo chỉ mục (Index) trên database cho các cột thường xuyên tìm kiếm: `CustomerID`, `Phone`, `LicensePlate`, `BookingDate`.
    *   Hạn chế lưu trữ dư thừa, tối ưu hóa các câu lệnh SQL JOIN phức tạp.

### 5.2 NFR-02: Thời gian xử lý giao dịch đặt lịch (Booking Processing ≤ 5 giây)
*   **Thách thức:** Việc lưu lịch đặt bao gồm nhiều bước: kiểm tra slot trống, xác thực voucher, trừ điểm loyalty và gửi thông báo xác nhận.
*   **Giải pháp Kỹ thuật:**
    *   Toàn bộ quá trình kiểm tra và lưu lịch đặt phải nằm trong một **Database Transaction** với Isolation Level là `Read Committed` để đảm bảo an toàn dữ liệu và tối ưu tốc độ khóa dòng.
    *   Các tác vụ phụ như gửi Email/SMS xác nhận đặt lịch thành công phải được đẩy sang một luồng xử lý nền bất đồng bộ (Asynchronous Background Thread - ví dụ dùng `ExecutorService` của Java) để giải phóng Servlet phản hồi ngay lập tức cho người dùng, thay vì bắt khách hàng đợi email gửi xong mới trả về màn hình thành công.

### 5.3 NFR-03: Khả năng chịu tải (Hỗ trợ ≥ 500 người dùng đồng thời)
*   **Thách thức:** Đảm bảo máy chủ Tomcat không bị tràn bộ nhớ hoặc treo nghẽn khi có hàng trăm khách hàng cùng truy cập đặt lịch.
*   **Giải pháp Kỹ thuật:**
    *   Thiết kế đối tượng `HttpSession` nhẹ nhất có thể. Tuyệt đối không lưu trữ các cấu trúc dữ liệu lớn hay các đối tượng phức tạp trong Session; chỉ lưu trữ các trường định danh cơ bản như `UserID`, `Phone`, và `TierStatus`.
    *   Sử dụng cơ chế giải phóng tài nguyên triệt để bằng cấu trúc **Try-with-resources** của Java khi tương tác với `Connection`, `PreparedStatement`, và `ResultSet` để đảm bảo không bị rò rỉ kết nối (Connection Leak) làm cạn kiệt tài nguyên máy chủ.

### 5.4 NFR-04: Tốc độ xử lý cổng LPR (Xác nhận xe ≤ 10 giây)
*   **Thách thức:** Khi xe tiến vào cổng quét, hệ thống cần đối chiếu nhanh biển số xe để kích hoạt mở cổng chào mừng.
*   **Giải pháp Kỹ thuật:**
    *   Do chỉ mục trên cột `LicensePlate` trong SQL Server hoạt động cực kỳ hiệu quả (tốc độ tìm kiếm chính xác thực tế chỉ mất `< 10 miligiây`), thời gian 10 giây còn lại là quá dư dả để hệ thống thực hiện các API trung gian nhận dạng chữ viết và gửi tín hiệu điều khiển mở cổng.

### 5.5 NFR-05 & NFR-06: Tính sẵn sàng & Sao lưu Dữ liệu (Uptime 99.5%, RTO ≤ 2 giờ)
*   **Thách thức:** Bảo vệ dữ liệu doanh nghiệp trước các sự cố phần cứng hoặc lỗi máy chủ bất ngờ.
*   **Giải pháp Kỹ thuật:**
    *   Cấu hình công cụ **SQL Server Agent** tự động thực hiện sao lưu dữ liệu đầy đủ (Full Backup) vào cuối mỗi tuần và sao lưu gia tăng (Differential Backup) vào lúc 23:00 hàng ngày.
    *   Các file sao lưu phải được đẩy tự động sang một máy chủ lưu trữ độc lập hoặc hệ thống đám mây để đảm bảo an toàn trong trường hợp cháy nổ ổ cứng máy chủ chính.

---

## 6. THIẾT KẾ CƠ SỞ DỮ LIỆU (DATABASE DIRECTION)

Dưới đây là mô tả mối quan hệ giữa các thực thể cơ sở dữ liệu trên SQL Server, được tối ưu hóa để đảm bảo toàn vẹn dữ liệu cho toàn bộ các quy tắc Loyalty và Booking đã phân tích.

**Mối quan hệ chính giữa các thực thể:**
*   **Users - Customers:** Liên kết **1-1** qua khóa phụ `UserID` để quản lý tài khoản và hồ sơ.
*   **Customers - Bookings:** Quan hệ **1-nhiều**; một khách hàng có thể đặt nhiều lịch rửa xe qua các thời kỳ.
*   **Customers - PointLedger:** Quan hệ **1-nhiều**; ghi chép chi tiết từng đợt cộng/trừ điểm tích lũy của khách hàng.
*   **Customers - Vouchers:** Quan hệ **1-nhiều**; lưu trữ danh sách voucher khách hàng đã đổi từ điểm thưởng.
*   **Bookings - WashRecords:** Quan hệ **1-1** (hoặc 1-0); mỗi lịch hẹn thành công tương ứng với tối đa 1 lượt rửa xe thực tế được ghi nhận bởi hệ thống/nhân viên.
*   **Bookings - Vouchers:** Quan hệ **nhiều-1** (hoặc nhiều-0); mỗi lịch đặt chỉ được phép áp dụng tối đa 1 voucher giảm giá/quà tặng.

### 6.1 Bảng: `Users`
*   *Mục đích:* Quản lý thông tin đăng nhập và phân quyền truy cập hệ thống.
*   *Các trường:*
    *   `UserID` (INT, Primary Key, Identity): ID định danh tự tăng.
    *   `Username` (VARCHAR(50), Unique, Not Null): Tên đăng nhập (sử dụng Số điện thoại).
    *   `PasswordHash` (VARCHAR(256), Not Null): Mật khẩu đã được băm SHA-256 kèm muối.
    *   `Role` (VARCHAR(20), Not Null): Vai trò người dùng gồm `ADMIN`, `MANAGER`, `CUSTOMER`.
    *   `CreatedAt` (DATETIME, Default GETDATE()): Thời gian tạo tài khoản.

### 6.2 Bảng: `Customers`
*   *Mục đích:* Lưu trữ thông tin chi tiết của khách hàng và trạng thái Loyalty.
*   *Các trường:*
    *   `CustomerID` (INT, Primary Key, Identity).
    *   `UserID` (INT, Foreign Key liên kết tới `Users(UserID)`).
    *   `FullName` (NVARCHAR(100), Not Null): Họ và tên khách hàng.
    *   `Phone` (VARCHAR(15), Unique, Not Null): Số điện thoại dùng để tìm kiếm và liên hệ.
    *   `LicensePlate` (VARCHAR(15), Unique, Not Null): Biển số xe đăng ký chính để quét LPR.
    *   `TierStatus` (VARCHAR(15), Default 'Member'): Phân hạng thẻ gồm `Member`, `Silver`, `Gold`, `Platinum`.
    *   `PointsBalance` (INT, Default 0, Constraint >= 0): Số dư điểm khả dụng hiện tại (ràng buộc không được âm).
    *   `TotalSpend` (DECIMAL(12, 2), Default 0.00): Tổng chi tiêu tích lũy trong vòng 12 tháng qua để xét thăng hạng.
    *   `TotalWashes` (INT, Default 0): Tổng số lượt rửa xe đã hoàn thành.
    *   `TierUpgradeDate` (DATETIME, Null): Ngày nâng hạng gần nhất để kiểm soát thời gian bảo vệ hạng thẻ.

### 6.3 Bảng: `Bookings`
*   *Mục đích:* Quản lý thông tin đặt lịch hẹn trước của khách hàng.
*   *Các trường:*
    *   `BookingID` (INT, Primary Key, Identity).
    *   `CustomerID` (INT, Foreign Key liên kết tới `Customers(CustomerID)`).
    *   `LicensePlate` (VARCHAR(15), Not Null): Ghi nhận biển số xe được đặt lịch (tránh trường hợp đổi biển số sau khi đặt).
    *   `BookingDate` (DATE, Not Null): Ngày hẹn rửa xe.
    *   `ScheduledTime` (TIME, Not Null): Khung giờ đặt chỗ (Ví dụ: 09:00:00).
    *   `OriginalPrice` (DECIMAL(10,2), Not Null): Giá trị gốc của gói dịch vụ.
    *   `DiscountAmount` (DECIMAL(10,2), Default 0.00): Số tiền được giảm trừ từ Voucher/Khuyến mãi.
    *   `FinalPrice` (DECIMAL(10,2), Not Null): Số tiền khách thực tế phải trả tại quầy.
    *   `Status` (VARCHAR(20), Default 'Pending'): Trạng thái gồm `Pending` (Chờ duyệt), `Confirmed` (Đã xác nhận), `InProgress` (Đang rửa), `Completed` (Đã hoàn thành), `Cancelled` (Đã hủy), `NoShow` (Không đến).
    *   `PriorityScore` (INT, Default 0): Điểm số ưu tiên dùng để xếp thứ tự xe vào khoang rửa.
    *   `VoucherID` (INT, Null, Foreign Key liên kết tới bảng `Vouchers`).

### 6.4 Bảng: `WashRecords`
*   *Mục đích:* Lưu lịch sử vận hành chi tiết của khoang rửa thực tế, phục vụ đối chiếu LPR.
*   *Các trường:*
    *   `WashRecordID` (INT, Primary Key, Identity).
    *   `BookingID` (INT, Unique, Foreign Key liên kết tới `Bookings(BookingID)`): Mỗi lịch đặt chỉ ứng với 1 lần rửa thực tế.
    *   `ActualStartTime` (DATETIME, Null): Thời gian bắt đầu rửa thực tế.
    *   `ActualEndTime` (DATETIME, Null): Thời gian hoàn thành rửa thực tế.
    *   `LPRConfidenceScore` (DECIMAL(5,2), Null): Độ chính xác của ảnh quét biển số giả lập từ camera LPR.
    *   `OperatorNotes` (NVARCHAR(256), Null): Ghi chú của nhân viên kỹ thuật.

### 6.5 Bảng: `PointLedger`
*   *Mục đích:* Sổ cái ghi chép chi tiết từng đợt biến động điểm số, phục vụ cơ chế trừ điểm FIFO và hủy điểm hết hạn.
*   *Các trường:*
    *   `LedgerID` (INT, Primary Key, Identity).
    *   `CustomerID` (INT, Foreign Key liên kết tới `Customers(CustomerID)`).
    *   `ReferenceType` (VARCHAR(20)): Phân loại biến động gồm `Accrual` (Cộng điểm từ hóa đơn), `Redemption` (Dùng điểm đổi voucher), `Expiration` (Hủy điểm hết hạn).
    *   `ReferenceID` (INT): Khóa phụ liên kết tới `BookingID` hoặc `VoucherID` tùy thuộc vào loại biến động.
    *   `PointsChange` (INT, Not Null): Số điểm biến động (Giá trị dương khi cộng, giá trị âm khi trừ).
    *   `PointsRemaining` (INT, Default 0): Số điểm còn lại chưa sử dụng của đợt cộng này (chỉ áp dụng cho dòng `Accrual`, dùng để tính FIFO).
    *   `EarnedDate` (DATETIME, Not Null): Ngày ghi nhận biến động điểm.
    *   `ExpiryDate` (DATETIME, Not Null): Ngày hết hạn của đợt điểm (bằng `EarnedDate + 12 Tháng`).
    *   `IsExpired` (BIT, Default 0): Đánh dấu dòng điểm đã hết hạn sử dụng.

### 6.6 Bảng: `Vouchers`
*   *Mục đích:* Quản lý các Voucher đổi thưởng từ điểm tích lũy của khách hàng.
*   *Các trường:*
    *   `VoucherID` (INT, Primary Key, Identity).
    *   `CustomerID` (INT, Foreign Key liên kết tới `Customers(CustomerID)`).
    *   `VoucherCode` (VARCHAR(30), Unique, Not Null): Mã Voucher dạng chữ-số viết hoa duy nhất.
    *   `RewardType` (VARCHAR(30)): Loại phần thưởng gồm `DISCOUNT_10` (Giảm 10%), `FREE_WAX` (Tặng phủ wax), `FREE_WASH` (Miễn phí rửa tiêu chuẩn).
    *   `PointsCost` (INT, Not Null): Giá trị điểm đã khấu trừ để đổi mã này.
    *   `ExpiryDate` (DATETIME, Not Null): Hạn chót sử dụng Voucher (bằng `Ngày đổi + 30 Ngày`).
    *   `Status` (VARCHAR(15), Default 'Unused'): Trạng thái gồm `Unused` (Chưa dùng), `Used` (Đã dùng), `Expired` (Đã hết hạn).

### 6.7 Bảng: `Promotions`
*   *Mục đích:* Quản lý các chương trình khuyến mãi chủ động của hệ thống nhắm đến các hạng thành viên.
*   *Các trường:*
    *   `PromoID` (INT, Primary Key, Identity).
    *   `Title` (NVARCHAR(100), Not Null): Tên chương trình khuyến mãi.
    *   `Description` (NVARCHAR(500)): Chi tiết chương trình.
    *   `TargetTierMin` (VARCHAR(15)): Hạng thành viên tối thiểu được tham gia (Ví dụ: `Silver` nghĩa là Bạc, Vàng, Bạch Kim được áp dụng; Thành viên thường không thấy).
    *   `DiscountPercent` (DECIMAL(5,2)): Phần trăm giảm giá.
    *   `StartDate` (DATE, Not Null).
    *   `EndDate` (DATE, Not Null).
    *   `IsActive` (BIT, Default 1): Đánh dấu chương trình đang kích hoạt.

---

## 7. BIỂU ĐỒ TRÌNH TỰ & KỊCH BẢN USE CASE (USE CASE & SEQUENCE)

### 7.1 Danh mục Use Case chính
1.  **UC-01: Đăng ký thành viên** (Tác nhân: Khách vãng lai)
2.  **UC-02: Chọn giờ & Đặt lịch rửa xe** (Tác nhân: Khách hàng thành viên)
3.  **UC-03: Đổi điểm lấy Voucher** (Tác nhân: Khách hàng thành viên)
4.  **UC-04: Check-in tự động cổng LPR** (Tác nhân: Cổng quét / Hệ thống)
5.  **UC-05: Cấu hình quy tắc điểm số** (Tác nhân: Quản trị viên)
6.  **UC-06: Phát động chiến dịch khuyến mãi mục tiêu** (Tác nhân: Quản trị viên)
7.  **UC-07: Xem báo cáo doanh thu & Loyalty** (Tác nhân: Quản lý)

### 7.2 Quy trình xử lý: Đặt lịch rửa xe kèm áp dụng Voucher điểm thưởng

#### Mô tả luồng xử lý chi tiết:
1.  **Tác nhân kích hoạt:** Khách hàng đã đăng nhập truy cập vào chức năng "Đặt lịch rửa xe".
2.  **Điều kiện cần:** Khách hàng đang có phiên đăng nhập hợp lệ và đã sở hữu một Voucher đổi thưởng có mã `WAX300-XY98Z`.
3.  **Luồng xử lý chính:**
    *   Hệ thống hiển thị bộ chọn lịch đặt, giới hạn số ngày được phép chọn theo hạng thành viên (Thành viên thường chỉ chọn được tối đa trong vòng 7 ngày tới).
    *   Khách chọn ngày `2026-05-20` vào lúc `10:00 AM`.
    *   Khách nhập mã Voucher đổi thưởng `WAX300-XY98Z` vào ô áp dụng ưu đãi.
    *   Khách nhấn nút "Xác nhận đặt lịch".
    *   `BookingServlet` chặn yêu cầu và mở một SQL Transaction để kiểm tra tính toàn vẹn dữ liệu.
    *   Hệ thống kiểm tra slot giờ đó đã đủ 3 xe chưa và Voucher có đúng là của khách hàng này và ở trạng thái `Unused` hay không.
    *   Nếu tất cả điều kiện thỏa mãn, hệ thống ghi nhận thông tin đặt lịch mới, đồng thời cập nhật cột `Status` của Voucher thành `Used` (Đã dùng).
    *   Giao diện chuyển hướng về màn hình thông báo Đặt lịch thành công, hiển thị chi tiết lịch hẹn kèm mã thứ tự ưu tiên trong hàng chờ rửa xe.
4.  **Điều kiện đủ:** Số lượng slot trống của khung giờ được giảm đi 1, Voucher được đánh dấu đã sử dụng thành công và không thể tái sử dụng cho giao dịch khác.

---

## 8. HƯỚNG THIẾT KẾ CÁC ĐƯỜNG API (SERVLET PATHS)

Hệ thống sử dụng kiến trúc MVC truyền thống của Java Web với các Servlet đóng vai trò là các RESTful Controller nhận và trả về dữ liệu định dạng JSON để phục vụ cho các tương tác động trên giao diện JSP.

### 8.1 Nhóm API Xác thực (Auth)
*   `POST /api/auth/register`
    *   *Dữ liệu gửi lên (Payload):* `{"fullName":"...", "phone":"...", "licensePlate":"...", "password":"..."}`
    *   *Dữ liệu trả về (Response):* `{"status":"success", "message":"Đăng ký tài khoản thành công"}`
*   `POST /api/auth/login`
    *   *Payload:* `{"phone":"...", "password":"..."}`
    *   *Response:* `{"status":"success", "role":"CUSTOMER", "redirect":"/customer/dashboard"}`

### 8.2 Nhóm API Khách hàng & Loyalty
*   `GET /api/customer/profile`
    *   *Yêu cầu:* Cookie chứa phiên đăng nhập `JSESSIONID=...` hợp lệ.
    *   *Response:*
        ```json
        {
          "customerId": 102,
          "tier": "Silver",
          "pointsBalance": 340,
          "totalWashes": 6,
          "spendToGoldRemaining": 2400000,
          "washesToGoldRemaining": 9
        }
        ```
*   `POST /api/loyalty/redeem`
    *   *Payload:* `{"rewardType": "FREE_WAX"}` (Yêu cầu trừ 300 điểm khả dụng)
    *   *Response:*
        ```json
        {
          "status": "success",
          "voucherCode": "WAX300-F839A2",
          "expiryDate": "2026-06-16T23:59:59",
          "newBalance": 40
        }
        ```

### 8.3 Nhóm API Đặt lịch (Booking)
*   `POST /api/booking/create`
    *   *Payload:* `{"date":"2026-05-20", "time":"14:00:00", "serviceId":1, "voucherCode":"WAX300-F839A2"}`
    *   *Response:*
        ```json
        {
          "status": "success",
          "bookingId": 4059,
          "priorityScore": 20850,
          "finalPrice": 150000
        }
        ```

### 8.4 Nhóm API Giả lập cổng nhận diện LPR
*   `POST /api/lpr/scan`
    *   *Payload:* `{"scannedPlate":"30A-123.45", "bayId": 1}`
    *   *Response:*
        ```json
        {
          "identified": true,
          "customerId": 102,
          "tier": "Silver",
          "bookingFound": true,
          "bookingId": 4059,
          "action": "OPEN_GATE_PRIORITY"
        }
        ```

---

## 9. ĐỊNH HƯỚNG GIAO DIỆN & TRẢI NGHIỆM NGƯỜI DÙNG (UI/UX FLOWS)

Giao diện trực quan sinh động là yếu tố then chốt giúp bạn ghi điểm tuyệt đối trước hội đồng chấm thi vấn đáp.

```
+------------------+     +--------------------+     +-------------------+
|    Trang chủ     | --> |   Giao diện Đăng ký| --> |Dashboard Khách    |
| (Lợi ích hạng)   |     |  (Số ĐT / Biển xe) |     | (Card VIP phát sáng)
+------------------+     +--------------------+     +-------------------+
                                                              |
                                                              v
+------------------+     +--------------------+     +-------------------+
| Màn hình Vé đặt  | <-- | Trang Thanh toán   | <-- | Chọn Ngày & Giờ   |
| (Mã QR check-in) |     |  (Áp dụng Voucher) |     | (Khóa ngày theo   |
+------------------+     +--------------------+     |      hạng thẻ)    |
                                                    +-------------------+
```

### 9.1 Luồng Trải nghiệm Khách hàng trên Thiết bị Di động (Mobile Web)
1.  **Đăng nhập & Vào Dashboard:** Khi khách hàng đăng nhập thành công, màn hình chính sẽ hiển thị một **Thẻ thành viên phát sáng (Glow-morphic Card)** với tông màu đại diện cho hạng thẻ hiện tại của họ (Đồng/Bạc/Vàng/Bạch Kim). Màn hình hiển thị số dư điểm hiện tại, tiến trình lên hạng tiếp theo bằng thanh progress bar trực quan, kèm nút lớn "Đặt lịch rửa xe".
2.  **Chọn lịch đặt:** Khi nhấp vào "Đặt lịch", bộ lịch hiện ra. Các ngày vượt quá giới hạn đặt trước của hạng thẻ hiện tại (Ví dụ: từ ngày thứ 8 đến ngày 14 đối với Thành viên thường) sẽ bị làm mờ xám và hiển thị biểu tượng ổ khóa nhỏ: 🔒 *"Chỉ dành cho thành viên hạng Vàng để đặt lịch trước 12 ngày"*.
3.  **Khấu trừ tiền bằng Voucher:** Ở bước thanh toán, một ngăn kéo ẩn (Drawer) sẽ trượt lên từ phía dưới màn hình, hiển thị danh sách các Voucher khả dụng hiện có của khách hàng (Ví dụ: *"Miễn phí Wax (Mã: WAX300-F839A2) - Hạn dùng còn 12 ngày"*). Khi khách hàng nhấp chọn Voucher, tổng số tiền cần thanh toán lập tức cập nhật về 0 VND trên màn hình hóa đơn.
4.  **Nhận vé điện tử check-in:** Sau khi hoàn tất đặt lịch, hệ thống hiển thị màn hình vé thành công dạng bán vé xem phim, trong đó chứa một **Mã QR Code** to, rõ ràng kèm dòng trạng thái: *"Hãy đưa mã này ra trước camera quét tại lối vào nếu biển số xe bị bẩn"*.

### 9.2 Luồng Trải nghiệm Quản trị viên & Quản lý (Admin/Manager Web Console)
1.  **Bảng điều khiển Analytics:** Thiết kế giao diện Dashboard quản lý hiện đại gồm 4 thẻ tổng hợp chính ở trên cùng: *Tổng doanh thu, Tổng số khách hàng hoạt động, Tổng số điểm dư đang lưu trữ* và *Hiệu suất lấp đầy khoang rửa*.
2.  **Bảng Cấu hình quy tắc kéo trượt (Rules Config):** Giao diện cho phép điều chỉnh hệ số nhân điểm thưởng và định mức thăng hạng bằng các thanh trượt kéo tiện lợi. Khi thay đổi hệ số nhân của hạng Vàng từ `+20%` lên `+25%` và nhấn "Lưu", backend Java Servlet lập tức áp dụng hệ số mới mà không yêu cầu khởi động lại máy chủ.
3.  **Mẫu tạo chiến dịch tiếp thị (Targeted Promos):** Giao diện tạo khuyến mãi hiển thị một hộp chọn nhiều phân khúc khách hàng (Checkboxes). Admin có thể tick chọn `Silver`, `Gold`, `Platinum` để phát động khuyến mãi 20% độc quyền. Khi lưu, các banner tương ứng lập tức hiển thị trên dashboard của nhóm khách hàng được chọn.

---

## 10. RỦI RO NGHIỆP VỤ & PHƯƠNG ÁN GIẢI QUYẾT (RISKS & SOLUTIONS)

Phần phân tích các góc khuất nghiệp vụ (Edge cases) chứng minh tư duy thiết kế hệ thống chín chắn của một System Analyst thực chiến.

### 10.1 Tích lũy Điểm trên Hóa đơn áp dụng Voucher giảm giá
*   *Rủi ro tiềm ẩn:* Nếu khách hàng đặt gói dịch vụ trị giá 300,000 VND nhưng áp dụng Voucher miễn phí hoàn toàn (Khách trả thực tế = 0 VND), hệ thống có tiếp tục tích điểm cho khách không? Nếu hệ thống vẫn tích điểm dựa trên giá trị gốc 300,000 VND, khách hàng có thể lạm dụng việc đổi voucher để tích lũy điểm ảo vô hạn.
*   *Phương án giải quyết (Quy tắc Nghiệp vụ):* Điểm thưởng chỉ được tích lũy dựa trên **số tiền mặt thực tế khách hàng thanh toán tại quầy sau khi đã trừ đi mọi Voucher giảm giá**. Nếu số tiền thực tế thanh toán bằng 0 VND, số điểm tích lũy nhận được sẽ bằng 0.

### 10.2 Tình trạng lạm dụng chiếm dụng Slot giờ đẹp của thành viên VIP
*   *Rủi ro tiềm ẩn:* Do thành viên hạng Bạch Kim có đặc quyền đặt lịch trước lên đến 14 ngày và được quyền hủy lịch miễn phí trước 12 tiếng, họ có thể tiến hành đặt giữ chỗ hàng loạt vào các khung giờ vàng (Ví dụ: các sáng Chủ Nhật) rồi hủy vào giờ chót, khiến các khách hàng khác có nhu cầu thực tế không thể đặt được chỗ.
*   *Phương án giải quyết (Chế tài Nghiệp vụ):*
    1.  Giới hạn mỗi khách hàng chỉ được phép sở hữu tối đa **3 lịch đặt ở trạng thái chờ thực hiện (Pending/Confirmed)** tại cùng một thời điểm.
    2.  Thiết lập quy định hủy lịch khắt khe: Nếu hủy lịch trong vòng 12 tiếng trước giờ hẹn, tài khoản sẽ bị đánh dấu 1 lần vi phạm "Hủy muộn".
    3.  Tự động khóa chức năng đặt lịch online 14 ngày đối với bất kỳ tài khoản nào tích lũy đủ 3 lần vi phạm Hủy muộn hoặc No-Show trong vòng 1 tháng.

### 10.3 Tranh chấp dữ liệu đặt lịch giờ cao điểm (Concurrrent Booking Locks)
*   *Rủi ro tiềm ẩn:* Vào các khung giờ cao điểm, hàng chục khách hàng cùng lúc nhấp nút "Xác nhận đặt lịch" cho slot trống cuối cùng. Nếu Servlet xử lý các luồng kiểm tra số lượng trống một cách song song mà không có cơ chế khóa đồng bộ, hệ thống sẽ phê duyệt vượt quá năng suất phục vụ (Over-booking).
*   *Phương án giải quyết (Thiết kế SA):* Sử dụng truy vấn khóa dòng trực tiếp trên SQL Server trong Transaction:
    ```sql
    SELECT SlotsReserved FROM BookingSlots WITH (UPDLOCK, ROWLOCK) WHERE SlotTime = ? AND SlotDate = ?
    ```
    Truy vấn này ép luồng truy cập sau phải tạm dừng ở tầng database cho đến khi luồng truy cập đầu tiên hoàn tất việc ghi lịch đặt và cập nhật số lượng chỗ trống.

### 10.4 Lỗi Nhận dạng Biển số xe vật lý LPR
*   *Rủi ro tiềm ẩn:* Xe đi mưa bị bùn đất bám bẩn hoặc thời tiết xấu khiến camera nhận dạng biển số không chính xác (Ví dụ: nhầm số `8` thành chữ `B`). Xe của thành viên VIP sẽ bị chặn ở cổng, làm hỏng trải nghiệm tự động hóa.
*   *Phương án giải quyết (Cơ chế Dự phòng):*
    1.  Mỗi vé đặt chỗ thành công trên ứng dụng di động của khách đều đi kèm một **Mã QR Code** duy nhất chứa `BookingID`.
    2.  Tại lối vào bãi rửa xe, bố trí thêm đầu đọc mã QR giá rẻ bên cạnh camera LPR. Khách hàng có thể chủ động đưa điện thoại quét mã QR để mở cổng ngay cả khi camera LPR nhận diện biển số thất bại.
    3.  Cung cấp giao diện tra cứu biển số thủ công trên máy tính bảng của nhân viên trực vận hành để ghi đè lệnh mở cổng trong trường hợp khẩn cấp.

---

## 11. BÍ QUYẾT BẢO VỆ VẤN ĐÁP ĐẠT ĐIỂM TỐI ĐA (VIVA DEFENSE ADVICE)

> [!IMPORTANT]
> **Khi trình bày dự án trước Hội đồng chấm Vấn đáp (Viva Committee), hãy chủ động giới thiệu 3 điểm sáng kỹ thuật sau để chứng minh năng lực thiết kế hệ thống chuyên nghiệp:**
> *   **Cơ chế Trừ điểm FIFO:** Hãy giải thích rõ cách bạn cấu trúc bảng `PointLedger` để giải quyết bài toán điểm tích lũy hết hạn sau 12 tháng. Chứng minh rằng hệ thống khấu trừ điểm cũ trước (FIFO) giúp số liệu kế toán điểm luôn minh bạch, tránh gây tranh chấp điểm với khách hàng.
> *   **Thiết kế Transaction Nguyên tử (Atomic Transaction):** Nhấn mạnh rằng thao tác "Đặt lịch rửa xe" và "Đánh dấu Voucher đã dùng" phải luôn chạy chung trong một Database Transaction. Nếu một trong hai bước bị lỗi, toàn bộ tiến trình sẽ tự động rollback để bảo vệ Voucher cho khách.
> *   **Giải pháp dự phòng QR Code cho LPR:** Hãy nhấn mạnh góc nhìn thực tế của bạn khi thiết kế thêm mã QR Code dự phòng cho trường hợp camera LPR bị bẩn hoặc quét sai biển số. Các thầy cô chấm thi luôn đánh giá rất cao những sinh viên biết lường trước rủi ro vận hành thực tế và đưa ra giải pháp dự phòng khả thi.

---
*Bản dịch và cập nhật tài liệu Tiếng Việt hoàn tất. Tài liệu đã sẵn sàng cho nhóm dự án AutoWash Pro.*
