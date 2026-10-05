/* Safe status test: only updates a deliberately marked test order.
   Create one through checkout with recipient name TEST and this exact email first.
   Set the exact order id and desired status below; real orders are never matched. */
DECLARE @TestOrderId INT = NULL; -- Set to the test order id only.
DECLARE @NewStatus VARCHAR(20) = 'CONFIRMED';

IF @TestOrderId IS NULL
    THROW 51000, 'Set @TestOrderId to the designated test order id.', 1;
IF @NewStatus NOT IN ('NEW','CONFIRMED','PREPARING','SHIPPING','DELIVERING','DELIVERED','CANCELLED','RETURNED')
    THROW 51001, 'Unsupported order status.', 1;
IF NOT EXISTS (
    SELECT 1 FROM dbo.orders
    WHERE order_id = @TestOrderId
      AND recipient_name = N'TEST'
      AND recipient_email = 'order-test@local.invalid'
)
    THROW 51002, 'Target id is not the designated test order.', 1;

SELECT order_id, recipient_name, recipient_email, status
FROM dbo.orders WHERE order_id = @TestOrderId;

UPDATE dbo.orders
SET status = @NewStatus
WHERE order_id = @TestOrderId
  AND recipient_name = N'TEST'
  AND recipient_email = 'order-test@local.invalid';

SELECT order_id, status FROM dbo.orders WHERE order_id = @TestOrderId;
GO
