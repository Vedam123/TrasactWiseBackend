-- Drop tables if they already exist
DROP TABLE IF EXISTS com.exchange_rates;
DROP TABLE IF EXISTS com.currency;
DROP TABLE IF EXISTS com.default_tax_codes;
DROP TABLE IF EXISTS com.tax;
DROP TABLE IF EXISTS com.default_tax_config;
DROP TABLE IF EXISTS com.tax_types;

-- Create the Currency table (lowercase table name and field names)
CREATE TABLE com.currency (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currencycode CHAR(3) UNIQUE NOT NULL,
    currencyname VARCHAR(100) NOT NULL,
    currencysymbol VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 10;

-- Create the Exchange Rates table
CREATE TABLE com.exchange_rates (
    exchange_rate_id INT AUTO_INCREMENT PRIMARY KEY,
    from_currency_id INT,
    to_currency_id INT,
    exchangerate DECIMAL(10,6),
    valid_from TIMESTAMP,
    valid_to TIMESTAMP,
    conversion_type VARCHAR(20),
    provider_id INT,
    status VARCHAR(10),
    version VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (from_currency_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (to_currency_id) REFERENCES com.currency (currency_id)
) AUTO_INCREMENT = 200;

-- Create the Tax table
CREATE TABLE com.tax (
    tax_id INT AUTO_INCREMENT PRIMARY KEY,
    tax_code VARCHAR(50) NOT NULL,
    tax_description VARCHAR(255) NOT NULL,
    tax_rate DECIMAL(10, 2) NOT NULL,
    tax_type VARCHAR(20) NOT NULL,
    tax_authority VARCHAR(100),
    tax_jurisdiction VARCHAR(100),
    tax_applicability VARCHAR(100),
    effective_date DATE NOT NULL,
    exemption VARCHAR(100),
    reporting_codes VARCHAR(100),
    integration_info TEXT,
    status BOOLEAN DEFAULT true,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 200;

-- Create the Default Tax Configuration table
CREATE TABLE com.default_tax_config (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 50;

-- Create the Default Tax Codes table
CREATE TABLE com.default_tax_codes (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    tax_id INT NOT NULL,
    tax_type VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (header_id) REFERENCES com.default_tax_config (header_id) ON DELETE CASCADE,
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id),
    UNIQUE KEY (header_id, tax_type)
) AUTO_INCREMENT = 500;

-- Create the Tax Types table
CREATE TABLE com.tax_types (
    tax_type_id INT AUTO_INCREMENT PRIMARY KEY,
    tax_type VARCHAR(255) NOT NULL,
    short_name VARCHAR(50) NOT NULL,
    description TEXT
) AUTO_INCREMENT = 100;
