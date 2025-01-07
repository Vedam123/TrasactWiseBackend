-- Drop the table if it exists (lowercase table name)
DROP TABLE IF EXISTS com.businesspartner;

-- Create the Business Partner table
CREATE TABLE com.businesspartner (
    partnerid INT AUTO_INCREMENT PRIMARY KEY,
    partnertype VARCHAR(20) NOT NULL,
    partnername VARCHAR(100) NOT NULL,
    contactperson VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postalcode VARCHAR(20),
    country VARCHAR(100),
    taxid VARCHAR(50),
    registrationnumber VARCHAR(50),
    additionalinfo TEXT,
    currency_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    status VARCHAR(20) NOT NULL,
    customerimage LONGBLOB
) AUTO_INCREMENT = 3000;
