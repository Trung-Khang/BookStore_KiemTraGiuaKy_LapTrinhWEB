/* Idempotent schema for De 01. The password column is VARCHAR(100) for BCrypt support. */
IF DB_ID(N'TrungKhang_BookStore') IS NULL
BEGIN
    CREATE DATABASE TrungKhang_BookStore;
END
GO

USE TrungKhang_BookStore;
GO

IF OBJECT_ID(N'dbo.users', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.users (
        id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        email VARCHAR(50) NOT NULL UNIQUE,
        fullname NVARCHAR(50) NULL,
        phone INT NULL,
        passwd VARCHAR(100) NOT NULL,
        signup_date DATETIME NULL,
        last_login DATETIME NULL,
        is_admin BIT NULL CONSTRAINT DF_users_is_admin DEFAULT 0
    );
END
GO

IF OBJECT_ID(N'dbo.books', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.books (
        bookid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        isbn INT NULL,
        title NVARCHAR(200) NULL,
        publisher NVARCHAR(100) NULL,
        price DECIMAL(6,2) NULL,
        description NVARCHAR(MAX) NULL,
        publish_date DATE NULL,
        cover_image VARCHAR(100) NULL,
        quantity INT NULL
    );
END
GO

IF OBJECT_ID(N'dbo.author', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.author (
        author_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        author_name NVARCHAR(100) NULL,
        date_of_birth DATE NULL
    );
END
GO

IF OBJECT_ID(N'dbo.book_author', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.book_author (
        bookid INT NOT NULL,
        author_id INT NOT NULL,
        CONSTRAINT PK_book_author PRIMARY KEY (bookid, author_id),
        CONSTRAINT FK_book_author_book FOREIGN KEY (bookid) REFERENCES dbo.books(bookid),
        CONSTRAINT FK_book_author_author FOREIGN KEY (author_id) REFERENCES dbo.author(author_id)
    );
END
GO

IF OBJECT_ID(N'dbo.rating', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.rating (
        userid INT NOT NULL,
        bookid INT NOT NULL,
        rating TINYINT NULL,
        review_text TEXT NULL,
        CONSTRAINT PK_rating PRIMARY KEY (userid, bookid),
        CONSTRAINT FK_rating_user FOREIGN KEY (userid) REFERENCES dbo.users(id),
        CONSTRAINT FK_rating_book FOREIGN KEY (bookid) REFERENCES dbo.books(bookid),
        CONSTRAINT CK_rating_range CHECK (rating IS NULL OR rating BETWEEN 1 AND 5)
    );
END
GO
