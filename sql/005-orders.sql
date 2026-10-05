/* Idempotent order schema. Existing bookstore data is not altered. */
IF OBJECT_ID(N'dbo.orders', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.orders (
        order_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_orders PRIMARY KEY,
        user_id INT NOT NULL,
        recipient_name NVARCHAR(100) NOT NULL,
        recipient_phone VARCHAR(30) NOT NULL,
        recipient_email VARCHAR(254) NOT NULL,
        shipping_address NVARCHAR(500) NOT NULL,
        payment_method VARCHAR(20) NOT NULL CONSTRAINT DF_orders_payment_method DEFAULT 'COD',
        status VARCHAR(20) NOT NULL CONSTRAINT DF_orders_status DEFAULT 'NEW',
        total_amount DECIMAL(12,2) NOT NULL,
        created_at DATETIME2(0) NOT NULL CONSTRAINT DF_orders_created_at DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES dbo.users(id),
        CONSTRAINT CK_orders_payment_method CHECK (payment_method = 'COD'),
        CONSTRAINT CK_orders_status CHECK (status IN ('NEW','CONFIRMED','PREPARING','SHIPPING','DELIVERING','DELIVERED','CANCELLED','RETURNED')),
        CONSTRAINT CK_orders_total CHECK (total_amount >= 0)
    );
END;
GO

IF OBJECT_ID(N'dbo.order_items', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.order_items (
        order_item_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_order_items PRIMARY KEY,
        order_id INT NOT NULL,
        book_id INT NULL,
        book_title NVARCHAR(200) NOT NULL,
        unit_price DECIMAL(12,2) NOT NULL,
        quantity INT NOT NULL,
        line_total DECIMAL(12,2) NOT NULL,
        CONSTRAINT FK_order_items_orders FOREIGN KEY (order_id) REFERENCES dbo.orders(order_id) ON DELETE CASCADE,
        CONSTRAINT FK_order_items_books FOREIGN KEY (book_id) REFERENCES dbo.books(bookid) ON DELETE SET NULL,
        CONSTRAINT CK_order_items_unit_price CHECK (unit_price >= 0),
        CONSTRAINT CK_order_items_quantity CHECK (quantity > 0),
        CONSTRAINT CK_order_items_line_total CHECK (line_total >= 0)
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_orders_user_created' AND object_id = OBJECT_ID(N'dbo.orders'))
    CREATE INDEX IX_orders_user_created ON dbo.orders(user_id, created_at DESC);
GO
