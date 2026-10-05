# BookStore - Kiểm tra giữa kỳ

Ứng dụng Maven WAR cho đề 01, xây dựng bằng Java 24, Jakarta Servlet/JSP/JSTL, JPA/Hibernate, SQL Server và SiteMesh 3; triển khai trên Apache Tomcat 11.0.25.

## Chạy và kiểm thử

```powershell
mvn clean tes
mvn clean package


WAR được tạo tại `target/bookstore-24133028.war`. Cấu hình kết nối SQL Server bằng các biến môi trường `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_ENCRYPT` và `DB_TRUST_SERVER_CERTIFICATE`. Không lưu thông tin đăng nhập vào repository.

## Chức năng

- Đăng ký, xác minh OTP email, đăng nhập và phân quyền Admin.
- Danh sách sách phân trang, chi tiết sách và đánh giá.
- Giỏ hàng theo session, thanh toán COD, lịch sử và lọc trạng thái đơn hàng.
- Admin quản lý sách, tác giả và đơn hàng; chỉ đơn đã hủy mới được xóa.

## Giao diện

Giao diện được làm mới theo phong cách thư viện/kệ sách gỗ cổ điển, có hero sách mở 3D, bố cục responsive và biểu tượng Font Awesome. Các route, form, phân trang, luồng nghiệp vụ và dữ liệu JSP vẫn lấy từ hệ thống hiện có.

Trang chủ local: <http://localhost:8080/bookstore-24133028/home>

# Hướng dẫn sử dụng BookStore

Ứng dụng đang chạy trên Tomcat. Mở trang chủ:

[http://localhost:8080/bookstore-24133028/home](http://localhost:8080/bookstore-24133028/home)

## Đăng nhập

1. Chọn **Đăng nhập** trên thanh điều hướng hoặc mở [trang đăng nhập](http://localhost:8080/bookstore-24133028/login).
2. Tài khoản user: tự đăng kí và đăng nhập
3. Tài khoản admin: Email: trungkhang98pth+c2check@gmail.com | Password: C2SafePass938!
