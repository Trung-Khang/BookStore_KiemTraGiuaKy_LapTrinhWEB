/* Fix Vietnamese text storage for Câu 3 data. Idempotent and data-preserving. */
USE TrungKhang_BookStore;
GO

IF COL_LENGTH(N'dbo.books', N'title') IS NOT NULL
    ALTER TABLE dbo.books ALTER COLUMN title NVARCHAR(200) NULL;
IF COL_LENGTH(N'dbo.books', N'publisher') IS NOT NULL
    ALTER TABLE dbo.books ALTER COLUMN publisher NVARCHAR(100) NULL;
IF COL_LENGTH(N'dbo.books', N'description') IS NOT NULL
    ALTER TABLE dbo.books ALTER COLUMN description NVARCHAR(MAX) NULL;
IF COL_LENGTH(N'dbo.author', N'author_name') IS NOT NULL
    ALTER TABLE dbo.author ALTER COLUMN author_name NVARCHAR(100) NULL;
GO

/* Restore the known Câu 3 seed rows by stable ISBN, without touching other books. */
UPDATE b SET title=N'Mắt biếc', publisher=N'Nhà xuất bản Trẻ', description=N'Tiểu thuyết Việt Nam'
FROM dbo.books b WHERE b.isbn=10000001;
UPDATE b SET title=N'Tôi thấy hoa vàng trên cỏ xanh', publisher=N'Nhà xuất bản Trẻ', description=N'Tuổi thơ và tình bạn'
FROM dbo.books b WHERE b.isbn=10000002;
UPDATE b SET title=N'Cho tôi xin một vé đi tuổi thơ', publisher=N'Nhà xuất bản Trẻ', description=N'Những ngày thơ ấu'
FROM dbo.books b WHERE b.isbn=10000003;
UPDATE b SET title=N'Dế Mèn phiêu lưu ký', publisher=N'Nhà xuất bản Kim Đồng', description=N'Tác phẩm thiếu nhi kinh điển'
FROM dbo.books b WHERE b.isbn=10000004;
UPDATE b SET title=N'Chí Phèo', publisher=N'Nhà xuất bản Văn học', description=N'Truyện ngắn hiện thực'
FROM dbo.books b WHERE b.isbn=10000005;
UPDATE b SET title=N'Lão Hạc', publisher=N'Nhà xuất bản Văn học', description=N'Truyện ngắn Việt Nam'
FROM dbo.books b WHERE b.isbn=10000006;
UPDATE b SET title=N'Quê nội', publisher=N'Nhà xuất bản Kim Đồng', description=N'Ký ức quê hương'
FROM dbo.books b WHERE b.isbn=10000007;
UPDATE b SET title=N'O Chuột', publisher=N'Nhà xuất bản Kim Đồng', description=N'Truyện thiếu nhi'
FROM dbo.books b WHERE b.isbn=10000008;
UPDATE b SET title=N'Truyện Kiều', publisher=N'Nhà xuất bản Văn học', description=N'Kiệt tác của Nguyễn Du'
FROM dbo.books b WHERE b.isbn=10000009;
UPDATE b SET title=N'Đọc sách và phát triển bản thân', publisher=N'Nhà xuất bản Tổng hợp', description=N'Kỹ năng học tập'
FROM dbo.books b WHERE b.isbn=10000010;
UPDATE b SET title=N'Hành trình về phương Đông', publisher=N'Nhà xuất bản Thế giới', description=N'Khám phá và trải nghiệm'
FROM dbo.books b WHERE b.isbn=10000011;
UPDATE b SET title=N'Nhà giả kim', publisher=N'Nhà xuất bản Hội Nhà văn', description=N'Tiểu thuyết truyền cảm hứng'
FROM dbo.books b WHERE b.isbn=10000012;

UPDATE dbo.author SET author_name=N'Nguyễn Nhật Ánh' WHERE author_name LIKE N'%Nhật%' OR author_name LIKE N'%Nguy%'
    AND author_id IN (SELECT DISTINCT ba.author_id FROM dbo.book_author ba JOIN dbo.books b ON b.bookid=ba.bookid WHERE b.isbn IN (10000001,10000002,10000003,10000010,10000011,10000012));
UPDATE dbo.author SET author_name=N'Tô Hoài' WHERE author_id IN (SELECT DISTINCT ba.author_id FROM dbo.book_author ba JOIN dbo.books b ON b.bookid=ba.bookid WHERE b.isbn IN (10000004,10000007,10000008));
UPDATE dbo.author SET author_name=N'Nguyễn Du' WHERE author_id IN (SELECT DISTINCT ba.author_id FROM dbo.book_author ba JOIN dbo.books b ON b.bookid=ba.bookid WHERE b.isbn=10000009);
GO
