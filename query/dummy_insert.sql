DELIMITER //
CREATE PROCEDURE PopulateOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    START TRANSACTION;
    WHILE i <= 500000 DO
        INSERT INTO orders (user_id, order_date, total_amount, status)
        VALUES (
            FLOOR(1 + RAND() * 10000),                             -- 1〜10000のユーザーID
            NOW() - INTERVAL FLOOR(RAND() * 365 * 2) DAY,         -- 過去2年間のランダムな日付
            FLOOR(500 + RAND() * 50000),                          -- 購入金額
            ELT(FLOOR(1 + RAND() * 4), 'pending', 'shipped', 'completed', 'cancelled')
        );
        SET i = i + 1;
        -- 10,000件ごとにコミットして高速化
        IF (i MOD 10000 = 0) THEN
            COMMIT;
            START TRANSACTION;
        END IF;
    END WHILE;
    COMMIT;
END //
DELIMITER ;

-- データ投入を実行
CALL PopulateOrders();
