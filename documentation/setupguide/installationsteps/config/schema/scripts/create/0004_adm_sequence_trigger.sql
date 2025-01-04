-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS adm.get_next_sequence_value;

-- Set delimiter to $$ for multi-line procedure definition
DELIMITER $$

-- Create the procedure
CREATE PROCEDURE adm.get_next_sequence_value(IN seq_name VARCHAR(255), OUT next_val BIGINT)
BEGIN
    -- Update the current value of the sequence by adding the increment value
    UPDATE sequence_table
    SET current_value = LAST_INSERT_ID(current_value + increment_value)
    WHERE sequence_name = seq_name;

    -- Retrieve the next value (after the increment) into the OUT parameter
    SELECT LAST_INSERT_ID() INTO next_val;
END $$

-- Reset delimiter to default semicolon
DELIMITER ;
