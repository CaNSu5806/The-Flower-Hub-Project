-- =============================================================================
-- The Flower Hub Database: Stored Procedures
-- =============================================================================

CREATE OR REPLACE PROCEDURE processcheckout (
    p_customer_id IN NUMBER,
    p_shop_id     IN NUMBER,
    p_product_id  IN NUMBER,
    p_quantity    IN NUMBER,
    p_unit_price  IN NUMBER
) AS
    v_new_order_id NUMBER;
    v_total_price  NUMBER;
BEGIN
    v_total_price := p_quantity * p_unit_price;
    
    INSERT INTO Orders (
        customer_id,
        shop_id,
        total_price,
        status
    ) VALUES ( 
        p_customer_id,
        p_shop_id,
        v_total_price,
        'PREPARING' 
    ) RETURNING order_id INTO v_new_order_id;
    
    INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price)
    VALUES (v_new_order_id, p_product_id, p_quantity, p_unit_price);
    
END processcheckout;
/
