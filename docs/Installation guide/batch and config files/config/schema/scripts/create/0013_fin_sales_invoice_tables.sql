-- Drop tables if they exist
DROP TABLE IF EXISTS fin.salesinvoicelines;
DROP TABLE IF EXISTS fin.salesinvoiceaccounts;
DROP TABLE IF EXISTS fin.salesinvoice;

-- Create salesinvoice table
CREATE TABLE fin.salesinvoice (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number INT NOT NULL,
    partnerid INT NOT NULL,
    invoicedate DATE NOT NULL,
    totalamount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    payment_terms VARCHAR(50),
    payment_duedate DATE,
    tax_id INT,
    currency_id INT,    
    department_id INT,
    company_id INT,
    transaction_source VARCHAR(50), -- New field added
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id),
    FOREIGN KEY (partnerid) REFERENCES com.businesspartner(partnerid),
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (department_id) REFERENCES com.department (id),
    FOREIGN KEY (company_id) REFERENCES com.company (id)
) AUTO_INCREMENT = 8000;

-- Create salesinvoicelines table
CREATE TABLE fin.salesinvoicelines (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    line_number VARCHAR(50) NOT NULL,
    header_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    line_total DECIMAL(15, 2) NOT NULL,
    uom_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (header_id) REFERENCES fin.salesinvoice(header_id),
    FOREIGN KEY (item_id) REFERENCES com.items (item_id),
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id),
    UNIQUE (line_number, header_id)
) AUTO_INCREMENT = 808000;

-- Create salesinvoiceaccounts table
CREATE TABLE fin.salesinvoiceaccounts (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    line_number VARCHAR(50) NOT NULL,
    header_id INT NOT NULL,
    is_tax_line BOOLEAN DEFAULT FALSE,
    account_id INT NOT NULL,
    debitamount DECIMAL(10, 2) NOT NULL,
    creditamount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    UNIQUE KEY unique_line (header_id, line_number, line_id), -- Unique constraint added
    FOREIGN KEY (header_id) REFERENCES fin.salesinvoice(header_id),
    FOREIGN KEY (account_id) REFERENCES fin.accounts(account_id),
    UNIQUE (line_number, header_id)
) AUTO_INCREMENT = 909000;
