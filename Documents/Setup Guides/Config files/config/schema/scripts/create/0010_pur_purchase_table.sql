-- Drop tables if they exist
DROP TABLE IF EXISTS pur.purchase_order_line;
DROP TABLE IF EXISTS pur.purchase_order_header;
DROP TABLE IF EXISTS pur.rfq_response_line;
DROP TABLE IF EXISTS pur.rfq_response_header;
DROP TABLE IF EXISTS pur.rfq_line;
DROP TABLE IF EXISTS pur.rfq_header;
DROP TABLE IF EXISTS pur.requisition_line;
DROP TABLE IF EXISTS pur.requisition_header;
DROP TABLE IF EXISTS pur.auto_purchase_log;

-- Create the Purchase Requisition Header table
CREATE TABLE pur.requisition_header (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    req_num INT UNIQUE NOT NULL,  
    company_id INT NOT NULL,
    department_id INT NOT NULL,
    requisition_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (company_id),
    INDEX (department_id),
    INDEX (req_num),
    INDEX (status),
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE
) AUTO_INCREMENT = 301;

-- Create the Purchase Requisition Line table
CREATE TABLE pur.requisition_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    req_lnum INT UNIQUE NOT NULL,
    header_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity DECIMAL(15, 4) NOT NULL,
    unit_price DECIMAL(15, 2) NOT NULL,
    currency_id INT,
    uom_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (header_id),
    INDEX (req_lnum),
    INDEX (item_id),
    INDEX (currency_id),
    INDEX (uom_id),
    FOREIGN KEY (header_id) REFERENCES pur.requisition_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 300001;

-- Create the Request for Quotation (RFQ) Header table
CREATE TABLE pur.rfq_header (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    rfq_num INT UNIQUE NOT NULL,
    company_id INT NOT NULL,
    department_id INT NOT NULL,
    req_header_id INT,
    rfq_date DATE NOT NULL,
    supplier_id INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (company_id),
    INDEX (department_id),
    INDEX (rfq_num),
    INDEX (req_header_id),
    INDEX (supplier_id),
    INDEX (status),
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE,
    FOREIGN KEY (req_header_id) REFERENCES pur.requisition_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES com.businesspartner (partnerid) ON DELETE CASCADE
) AUTO_INCREMENT = 501;

-- Create the RFQ Line table
CREATE TABLE pur.rfq_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    rfq_lnum INT UNIQUE NOT NULL,
    item_id INT NOT NULL,
    quantity DECIMAL(15, 4) NOT NULL,
    uom_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (header_id),
    INDEX (rfq_lnum),
    INDEX (item_id),
    INDEX (uom_id),
    FOREIGN KEY (header_id) REFERENCES pur.rfq_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 500001;

-- Create the RFQ Response Header table
CREATE TABLE pur.rfq_response_header (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    rfq_header_id INT,
    resp_num INT UNIQUE NOT NULL,
    supplier_id INT NOT NULL,
    response_date DATE NOT NULL,
    currency_id INT,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (rfq_header_id),
    INDEX (resp_num),
    INDEX (supplier_id),
    INDEX (currency_id),
    INDEX (status),
    FOREIGN KEY (rfq_header_id) REFERENCES pur.rfq_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES com.businesspartner (partnerid) ON DELETE CASCADE,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id)
) AUTO_INCREMENT = 2000;

-- Create the RFQ Response Line table
CREATE TABLE pur.rfq_response_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    resp_lnum INT UNIQUE NOT NULL,
    item_id INT NOT NULL,
    quantity DECIMAL(15, 4) NOT NULL,
    uom_id INT,
    quoted_price DECIMAL(15, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (header_id),
    INDEX (resp_lnum),
    INDEX (item_id),
    INDEX (uom_id),
    FOREIGN KEY (header_id) REFERENCES pur.rfq_response_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 2000;

-- Create the Purchase Order Header table
CREATE TABLE pur.purchase_order_header (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    po_num INT UNIQUE NOT NULL,
    company_id INT NOT NULL,
    department_id INT,
    rfq_header_id  INT,
    po_date DATE NOT NULL,
    supplier_id INT NOT NULL,
    currency_id INT NOT NULL,
    tax_id INT,
    total_amount DECIMAL(15, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (company_id),
    INDEX (po_num),
    INDEX (department_id),
    INDEX (rfq_header_id),
    INDEX (supplier_id),
    INDEX (currency_id),
    INDEX (tax_id),
    INDEX (status),
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE,
    FOREIGN KEY (rfq_header_id) REFERENCES pur.rfq_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES com.businesspartner (partnerid) ON DELETE CASCADE,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id)
) AUTO_INCREMENT = 601;

-- Create the Purchase Order Line table
CREATE TABLE pur.purchase_order_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    po_lnum INT UNIQUE NOT NULL,
    item_id INT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    line_total DECIMAL(15, 2) NOT NULL,
    uom_id INT,
    tax_id INT,
    notes TEXT,
    status VARCHAR(50), -- New status column
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX (header_id),
    INDEX (po_lnum),
    INDEX (item_id),
    INDEX (uom_id),
    INDEX (tax_id),
    INDEX (status), -- Index for status column
    FOREIGN KEY (header_id) REFERENCES pur.purchase_order_header (header_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id),
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id)
) AUTO_INCREMENT = 1001;

-- Create the Auto Purchase Log table
CREATE TABLE pur.auto_purchase_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_id VARCHAR(50) NOT NULL,
    purchase_header_id INT NOT NULL,
    purchase_invoice_id INT NOT NULL,
    po_header_prev_status VARCHAR(50) NOT NULL,
    po_header_update_status VARCHAR(50) NOT NULL,
    purchase_invoice_status VARCHAR(50) NOT NULL,
    auto_purchase_status VARCHAR(50) NOT NULL,   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    INDEX (execution_id),
    INDEX (purchase_header_id),    
    INDEX (purchase_invoice_id)
) AUTO_INCREMENT = 11;
