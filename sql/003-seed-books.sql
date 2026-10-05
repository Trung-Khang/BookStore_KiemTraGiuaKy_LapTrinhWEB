/* Idempotent Câu 3 seed data. Existing rows are preserved. */
USE TrungKhang_BookStore;
GO
IF NOT EXISTS (SELECT 1 FROM dbo.author WHERE author_name=N'Nguyễn Nhật Ánh') INSERT INTO dbo.author(author_name,date_of_birth) VALUES (N'Nguyễn Nhật Ánh','1955-05-07');
IF NOT EXISTS (SELECT 1 FROM dbo.author WHERE author_name=N'Nam Cao') INSERT INTO dbo.author(author_name,date_of_birth) VALUES (N'Nam Cao','1915-10-29');
IF NOT EXISTS (SELECT 1 FROM dbo.author WHERE author_name=N'Tô Hoài') INSERT INTO dbo.author(author_name,date_of_birth) VALUES (N'Tô Hoài','1920-09-27');
IF NOT EXISTS (SELECT 1 FROM dbo.author WHERE author_name=N'Nguyễn Du') INSERT INTO dbo.author(author_name,date_of_birth) VALUES (N'Nguyễn Du','1765-01-03');
GO
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000001) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000001,N'Mắt biếc',N'Nhà xuất bản Trẻ',75.00,N'Tiểu thuyết Việt Nam','1990-01-01','book-default.svg',12);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000002) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000002,N'Tôi thấy hoa vàng trên cỏ xanh',N'Nhà xuất bản Trẻ',95.00,N'Tuổi thơ và tình bạn','2010-01-01','book-default.svg',15);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000003) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000003,N'Cho tôi xin một vé đi tuổi thơ',N'Nhà xuất bản Trẻ',88.00,N'Những ngày thơ ấu','2008-01-01','book-default.svg',10);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000004) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000004,N'Dế Mèn phiêu lưu ký',N'Nhà xuất bản Kim Đồng',65.00,N'Tác phẩm thiếu nhi kinh điển','1941-01-01','book-default.svg',20);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000005) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000005,N'Chí Phèo',N'Nhà xuất bản Văn học',55.00,N'Truyện ngắn hiện thực','1941-01-01','book-default.svg',8);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000006) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000006,N'Lão Hạc',N'Nhà xuất bản Văn học',52.00,N'Truyện ngắn Việt Nam','1943-01-01','book-default.svg',9);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000007) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000007,N'Quê nội',N'Nhà xuất bản Kim Đồng',72.00,N'Ký ức quê hương','1943-01-01','book-default.svg',11);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000008) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000008,N'O Chuột',N'Nhà xuất bản Kim Đồng',68.00,N'Truyện thiếu nhi','1950-01-01','book-default.svg',14);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000009) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000009,N'Truyện Kiều',N'Nhà xuất bản Văn học',120.00,N'Kiệt tác của Nguyễn Du','1820-01-01','book-default.svg',7);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000010) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000010,N'Đọc sách và phát triển bản thân',N'Nhà xuất bản Tổng hợp',110.00,N'Kỹ năng học tập','2022-01-01','book-default.svg',16);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000011) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000011,N'Hành trình về phương Đông',N'Nhà xuất bản Thế giới',130.00,N'Khám phá và trải nghiệm','2021-01-01','book-default.svg',13);
IF NOT EXISTS (SELECT 1 FROM dbo.books WHERE isbn=10000012) INSERT INTO dbo.books(isbn,title,publisher,price,description,publish_date,cover_image,quantity) VALUES (10000012,N'Nhà giả kim',N'Nhà xuất bản Hội Nhà văn',99.00,N'Tiểu thuyết truyền cảm hứng','1988-01-01','book-default.svg',18);
GO
INSERT INTO dbo.book_author(bookid,author_id)
SELECT b.bookid,a.author_id FROM dbo.books b CROSS JOIN dbo.author a
WHERE ((b.isbn IN (10000001,10000002,10000003,10000010,10000011,10000012) AND a.author_name=N'Nguyễn Nhật Ánh')
 OR (b.isbn IN (10000005,10000006) AND a.author_name=N'Nam Cao')
 OR (b.isbn IN (10000004,10000007,10000008) AND a.author_name=N'Tô Hoài')
 OR (b.isbn=10000009 AND a.author_name=N'Nguyễn Du'))
AND NOT EXISTS (SELECT 1 FROM dbo.book_author x WHERE x.bookid=b.bookid AND x.author_id=a.author_id);
GO
