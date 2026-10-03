CREATE DATABASE IF NOT EXISTS slow_quiz_db;
USE slow_quiz_db;

-- 再帰処理の上限を一時的に拡張
SET SESSION max_recursive_iterations = 1000000;

-- ダミーデータ用テーブルの作成（既存があれば削除して作成）
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
