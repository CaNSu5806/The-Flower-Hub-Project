-- =============================================================================
-- The Flower Hub Database: Business Logic Triggers
-- =============================================================================

-- 1. Inventory Change Audit Log
CREATE OR REPLACE TRIGGER trg_track_inventory_changes
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO InventoryLogs (
        product_id,
        change_amount,
        action_type,
        timestamp
    ) VALUES (
        :NEW.product_id,
        :NEW.stock_quantity - :OLD.stock_quantity,
        'STOCK_UPDATE',
        CURRENT_TIMESTAMP
    );
END;
/

-- 2. Stock Availability Check & Deduction
CREATE OR REPLACE TRIGGER trg_process_order_stock
BEFORE INSERT ON OrderDetails
FOR EACH ROW
DECLARE
    v_current_stock NUMBER;
BEGIN
    SELECT stock_quantity
    INTO v_current_stock
    FROM Products
    WHERE product_id = :NEW.product_id
    FOR UPDATE;

    IF v_current_stock < :NEW.quantity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ID: ' || :NEW.product_id);
    END IF;

    UPDATE Products
    SET stock_quantity = stock_quantity - :NEW.quantity
    WHERE product_id = :NEW.product_id;
END;
/
