-- Drop the tables if they exist
DROP TABLE IF EXISTS fin.journal_lines;
DROP TABLE IF EXISTS fin.journal_headers;
DROP TABLE IF EXISTS fin.default_accounts;
DROP TABLE IF EXISTS fin.accounts;

-- Create the fin.accounts table
CREATE TABLE fin.accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(50) NOT NULL UNIQUE,
    account_name VARCHAR(255) NOT NULL,
    account_category VARCHAR(255),
    account_type VARCHAR(255) NOT NULL,
    opening_balance DECIMAL(15, 2) DEFAULT 0,
    current_balance DECIMAL(15, 2) DEFAULT 0,
    currency_id INT NOT NULL,
    bank_name VARCHAR(255),
    branch_name VARCHAR(255),
    account_holder_name VARCHAR(255),
    contact_number VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    is_active BOOLEAN DEFAULT true,
    department_id INT,
    company_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    default_account BOOLEAN DEFAULT NULL,
    UNIQUE KEY unique_account_combination (company_id, department_id, account_category, account_type, default_account, currency_id),
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE SET NULL,
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE SET NULL,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id)
) AUTO_INCREMENT = 8001;


-- Create the fin.journal_headers table
CREATE TABLE fin.journal_headers (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    journal_number INT NOT NULL,  -- Added field
    company_id INT NOT NULL,
    department_id INT,
    journal_date DATE NOT NULL,
    journal_type VARCHAR(20) NOT NULL,
    source_number INT,  -- Changed field name from reference_number to source_number
    description VARCHAR(255) NOT NULL,
    currency_id INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE SET NULL,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    INDEX idx_company_id (company_id),
    INDEX idx_department_id (department_id),
    INDEX idx_currency_id (currency_id),
    INDEX idx_journal_number (journal_number) -- Added index
) AUTO_INCREMENT = 701;

-- Create the fin.journal_lines table
CREATE TABLE fin.journal_lines (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    line_number INT NOT NULL,
    header_id INT NOT NULL,
    account_id INT NOT NULL,
    debit DECIMAL(15, 2) DEFAULT 0.0,
    credit DECIMAL(15, 2) DEFAULT 0.0,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (header_id) REFERENCES fin.journal_headers (header_id) ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES fin.accounts (account_id),
    INDEX idx_header_id (header_id),
    INDEX idx_account_id (account_id),
    INDEX idx_line_number (line_number) -- Adding index to line_number
) AUTO_INCREMENT = 7001;


-- Create the fin.default_accounts table
CREATE TABLE fin.default_accounts (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    account_id INT NOT NULL,
    account_type VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    UNIQUE KEY unique_default_accounts (header_id, account_type),
    FOREIGN KEY (header_id) REFERENCES fin.default_account_headers (header_id) ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES fin.accounts (account_id)
) AUTO_INCREMENT = 3000;
