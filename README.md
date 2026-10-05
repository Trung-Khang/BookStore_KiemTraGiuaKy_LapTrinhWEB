# BookStore - Kiem tra giua ky

Ung dung Maven WAR cho de 01, su dung Jakarta Servlet/JSP/JSTL, JPA/Hibernate, SQL Server va SiteMesh 3.

## Moi truong

- Java 24, Maven compiler release 24
- Apache Tomcat 11.0.25
- SQL Server, cau hinh bang bien moi truong `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_ENCRYPT`, `DB_TRUST_SERVER_CERTIFICATE`

Tao schema bang `sql/001-create-bookstore.sql`; chay migration `sql/005-orders.sql` mot lan truoc khi checkout. Khong luu credential vao repository. Tai khoan thu nghiem khong duoc cong khai trong README; hay tao/cau hinh tai khoan rieng trong database local.

Build WAR:

```powershell
mvn clean package
```

## Chuc nang hien co

- Dang ky va xac minh tai khoan bang OTP email; dang nhap/dang xuat va phan quyen Admin.
- Trang chu phan trang sach, chi tiet sach va review.
- Admin CRUD sach va tac gia.
- Gio hang theo session cho User dang nhap; gia va ton kho doc tu database, khong tru kho khi them gio.
- Checkout COD dung JPA transaction, khoa va cap nhat ton kho, luu snapshot don hang.
- User xem lich su/chi tiet don va loc theo 8 ma trang thai: `NEW`, `CONFIRMED`, `PREPARING`, `SHIPPING`, `DELIVERING`, `DELIVERED`, `CANCELLED`, `RETURNED`.
- De quan sat filter, tao don test co nguoi nhan `TEST`, email `order-test@local.invalid`; script `sql/006-order-status-test.sql` chi cho phep cap nhat dung order duoc danh dau nay.
