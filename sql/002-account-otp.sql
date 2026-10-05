/* Idempotent Câu 2 schema. No OTP is stored in plain text. */
USE TrungKhang_BookStore;
GO

IF COL_LENGTH(N'dbo.users', N'email_verified') IS NULL
BEGIN
    ALTER TABLE dbo.users ADD email_verified BIT NOT NULL
        CONSTRAINT DF_users_email_verified DEFAULT 0;
END
GO

IF OBJECT_ID(N'dbo.account_otps', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.account_otps (
        id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        user_id INT NOT NULL,
        purpose VARCHAR(30) NOT NULL,
        otp_hash VARCHAR(64) NOT NULL,
        expires_at DATETIME2 NOT NULL,
        used_at DATETIME2 NULL,
        attempt_count INT NOT NULL CONSTRAINT DF_account_otps_attempt_count DEFAULT 0,
        created_at DATETIME2 NOT NULL CONSTRAINT DF_account_otps_created_at DEFAULT SYSDATETIME(),
        CONSTRAINT FK_account_otps_user FOREIGN KEY (user_id) REFERENCES dbo.users(id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_account_otps_user_purpose_created' AND object_id = OBJECT_ID(N'dbo.account_otps'))
BEGIN
    CREATE INDEX IX_account_otps_user_purpose_created ON dbo.account_otps(user_id, purpose, created_at);
END
GO
