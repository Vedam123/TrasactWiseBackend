-- Drop the table if it already exists
DROP TABLE IF EXISTS adm.sequence_table;

-- Create the sequence_table
CREATE TABLE adm.sequence_table (
    sequence_name VARCHAR(255) NOT NULL,
    current_value BIGINT UNSIGNED NOT NULL,
    increment_value BIGINT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (sequence_name)
);

-- Insert initial values into the sequence_table
INSERT INTO adm.sequence_table (sequence_name, current_value, increment_value)
VALUES
('ITEM_NUMBER', 1000, 1),
('JOURNAL_HDR_NUMBER', 2000, 1),
('JOURNAL_LINE_NUMBER', 150000, 1),
('PUR_DIST_LINE_NUMBER', 2000, 1),
('PUR_HDR_INV_NUM', 2000, 1),
('PUR_LINE_NUMBER', 150000, 1),
('SAL_DIST_LINE_NUMBER', 2000, 1),
('SAL_HDR_INV_NUM', 8000, 1),
('SAL_LINE_NUMBER', 70000, 1);
