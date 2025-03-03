-- Drop tables if they exist
DROP TABLE IF EXISTS sal.sales_order_lines;
DROP TABLE IF EXISTS sal.opportunity_lines;
DROP TABLE IF EXISTS sal.opportunities;
DROP TABLE IF EXISTS sal.discounts;
DROP TABLE IF EXISTS sal.promotions;
DROP TABLE IF EXISTS sal.auto_invoice_log;
DROP TABLE IF EXISTS sal.leads;
DROP TABLE IF EXISTS inv.pick_and_ship_stage;
DROP TABLE IF EXISTS sal.sales_order_headers;
DROP TABLE IF EXISTS sal.sales_representatives;
DROP TABLE IF EXISTS sal.pick_release_log;

CREATE TABLE sal.discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_name VARCHAR(100) NOT NULL,
    discount_type VARCHAR(50) NOT NULL,
    discount_value DECIMAL(10, 2) NOT NULL,
    min_order_amount DECIMAL(15, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description TEXT,
    customer_id INT DEFAULT NULL,
    item_id INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (customer_id) REFERENCES com.businesspartner (partnerid) ON DELETE SET NULL,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE SET NULL,
    INDEX idx_customer_id (customer_id), -- Index for customer_id column
    INDEX idx_item_id (item_id) -- Index for item_id column
) AUTO_INCREMENT= 1000;

CREATE TABLE sal.promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    promotion_type VARCHAR(50) NOT NULL,
    promotion_value DECIMAL(10, 2) NOT NULL,
    min_order_amount DECIMAL(15, 2) NOT NULL,
    max_usage_limit INT,
    description TEXT,
    customer_id INT DEFAULT NULL,
    item_id INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (customer_id) REFERENCES com.businesspartner (partnerid) ON DELETE SET NULL,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE SET NULL,
    INDEX idx_customer_id (customer_id), -- Index for customer_id column
    INDEX idx_item_id (item_id) -- Index for item_id column
) AUTO_INCREMENT= 2000;

-- Create the Sales Representatives table
CREATE TABLE sal.sales_representatives (
    rep_id INT AUTO_INCREMENT PRIMARY KEY,
    rep_name VARCHAR(100) NOT NULL,
    email_id VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    department_id INT,
    empid INT DEFAULT NULL, -- Default value set to NULL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_department_id (department_id), -- Index for department_id column
    INDEX idx_empid (empid), -- Index for empid column
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE,
    FOREIGN KEY (empid) REFERENCES com.employee (empid) ON UPDATE CASCADE ON DELETE SET NULL -- Modified foreign key constraint
)AUTO_INCREMENT=75000;

CREATE TABLE sal.leads (
    lead_id INT AUTO_INCREMENT PRIMARY KEY,
    lead_source VARCHAR(100),
    lead_status VARCHAR(50),
    rep_id int default null,
    lead_name VARCHAR(255),
    contact_person VARCHAR(255),
    email_id VARCHAR(100),
    phone VARCHAR(20),
    company VARCHAR(255),
    industry VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_rep_id (rep_id), -- Index for rep_id column
    FOREIGN KEY (rep_id) REFERENCES sal.sales_representatives (rep_id) ON DELETE CASCADE
)AUTO_INCREMENT=8500;


CREATE TABLE sal.opportunities (
    opportunity_id INT AUTO_INCREMENT PRIMARY KEY,
    lead_id INT,
    opportunity_name VARCHAR(255),
    company_id INT,
    department_id INT,
    customer_id INT,
    rep_id INT DEFAULT NULL,
    expected_revenue DECIMAL(15, 2),
    probability DECIMAL(5, 2),
    close_date DATE,
    sales_stage VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_company_id (company_id), -- Index for company_id column
    INDEX idx_department_id (department_id), -- Index for department_id column
    INDEX idx_lead_id (lead_id), -- Index for lead_id column
    INDEX idx_customer_id (customer_id), -- Index for customer_id column
    INDEX idx_rep_id (rep_id), -- Index for rep_id column
    FOREIGN KEY (lead_id) REFERENCES sal.leads(lead_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES com.businesspartner (partnerid) ON DELETE CASCADE,
    FOREIGN KEY (rep_id) REFERENCES sal.sales_representatives (rep_id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE
)AUTO_INCREMENT=65000;


CREATE TABLE sal.opportunity_lines (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    opportunity_id INT,
    item_id INT,
    quantity DECIMAL(10, 2),
    unit_price DECIMAL(10, 2),
    line_total DECIMAL(15, 2),
    uom_id INT,
    tax_id INT,
    notes TEXT,
    status VARCHAR(50),
    discount_id INT DEFAULT NULL,
    promotion_id INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_opportunity_id (opportunity_id), -- Index for opportunity_id column
    INDEX idx_item_id (item_id), -- Index for item_id column
    INDEX idx_discount_id (discount_id), -- Index for discount_id column
    INDEX idx_promotion_id (promotion_id), -- Index for promotion_id column
    FOREIGN KEY (opportunity_id) REFERENCES sal.opportunities (opportunity_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id),
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id),
    FOREIGN KEY (discount_id) REFERENCES sal.discounts (discount_id) ON DELETE SET NULL,
    FOREIGN KEY (promotion_id) REFERENCES sal.promotions (promotion_id) ON DELETE SET NULL
) AUTO_INCREMENT = 70001;


CREATE TABLE sal.sales_order_headers (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    so_num INT UNIQUE NOT NULL,
    opportunity_id INT,
    company_id INT,
    department_id INT,
    customer_id INT,
    so_date DATE,
    type VARCHAR(50),
    status VARCHAR(20),
    payment_terms VARCHAR(100),
    shipping_method VARCHAR(100),
    billing_address TEXT,
    shipping_address TEXT,
    rep_id INT,
    total_amount DECIMAL(15, 2),
    currency_id INT,
    tax_id INT,
    comments TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_opportunity_id (opportunity_id), -- Index for opportunity_id column
    INDEX idx_company_id (company_id), -- Index for company_id column
    INDEX idx_department_id (department_id), -- Index for department_id column
    INDEX idx_customer_id (customer_id), -- Index for customer_id column
    INDEX idx_rep_id (rep_id), -- Index for rep_id column
    INDEX idx_tax_id (tax_id), -- Index for tax_id column
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (currency_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (department_id) REFERENCES com.department (id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES com.businesspartner (partnerid) ON DELETE CASCADE,
    FOREIGN KEY (tax_id) REFERENCES com.tax (tax_id),
    FOREIGN KEY (rep_id) REFERENCES sal.sales_representatives (rep_id) ON DELETE CASCADE
) AUTO_INCREMENT = 10000;


CREATE TABLE sal.sales_order_lines (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT,
    so_lnum INT UNIQUE NOT NULL,
    item_id INT,
    quantity DECIMAL(10, 2),
    unit_price DECIMAL(10, 2),
    line_total DECIMAL(15, 2),
    uom_id INT,
    notes TEXT,
    status VARCHAR(50),
    discount_id INT DEFAULT NULL,
    promotion_id INT DEFAULT NULL,
    base_uom_id INT,
    base_quantity DECIMAL(10, 2),
    picked_quantity DECIMAL(10, 2),
    uom_conversion_factor DECIMAL(10, 2), -- New field added
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    INDEX idx_header_id (header_id),
    INDEX idx_item_id (item_id),
    INDEX idx_uom_id (uom_id),
    INDEX idx_discount_id (discount_id),
    INDEX idx_promotion_id (promotion_id),
    INDEX idx_base_uom_id (base_uom_id),
    FOREIGN KEY (header_id) REFERENCES sal.sales_order_headers (header_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES com.items (item_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES com.uom (uom_id),
    FOREIGN KEY (discount_id) REFERENCES sal.discounts (discount_id) ON DELETE SET NULL,
    FOREIGN KEY (promotion_id) REFERENCES sal.promotions (promotion_id) ON DELETE SET NULL,
    FOREIGN KEY (base_uom_id) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 100;

CREATE TABLE sal.pick_release_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_id VARCHAR(50) NOT NULL UNIQUE, 
    sales_header_id INT NOT NULL,
    sales_order_line_id INT NOT NULL,
    sales_item_id INT NOT NULL,
    sales_uom_id INT NOT NULL,
    sales_uom_id_quantity DECIMAL(10, 2) NOT NULL,
    sales_base_uom_id INT NOT NULL,
    sales_base_uom_quantity DECIMAL(10, 2) NOT NULL,
    already_picked_quantity DECIMAL(10, 2),
    sales_line_status VARCHAR(50) NOT NULL,   
    sales_line_new_status VARCHAR(50),
    inventory_id INT,  -- NULL allowed
    picked_quantity DECIMAL(10, 2) NOT NULL,
    pick_release_status ENUM('RELEASED', 'REVERSED') DEFAULT 'RELEASED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    INDEX (execution_id),
    INDEX (sales_header_id),    
    INDEX (sales_order_line_id),
    INDEX (sales_item_id),
    INDEX (inventory_id)
) AUTO_INCREMENT = 10;

-- Table for pick and ship stage
CREATE TABLE inv.pick_and_ship_stage (
    pick_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_id VARCHAR(50) NOT NULL,  
    order_id INT NOT NULL,
    line_id INT NOT NULL,
    item_id INT NOT NULL,
    inventory_id INT NOT NULL,
    picked_quantity INT NOT NULL,
    pick_date DATE NOT NULL,
    picker_id INT NOT NULL,
    shipping_location_id INT,
    status VARCHAR(50) NOT NULL,
    shipping_method VARCHAR(50),
    destination VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES sal.sales_order_headers(header_id),
    FOREIGN KEY (execution_id) REFERENCES sal.pick_release_log(execution_id),
    FOREIGN KEY (item_id) REFERENCES com.items(item_id),
    FOREIGN KEY (inventory_id) REFERENCES inv.item_inventory(inventory_id),
    FOREIGN KEY (picker_id) REFERENCES com.employee(empid),
    FOREIGN KEY (shipping_location_id) REFERENCES inv.item_inventory(inventory_id)
) AUTO_INCREMENT=100;

CREATE TABLE sal.auto_invoice_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_id VARCHAR(50) NOT NULL,
    sales_header_id INT NOT NULL,
    invoice_header_id INT NOT NULL,
    so_header_prev_status VARCHAR(50) NOT NULL,
    so_header_update_status VARCHAR(50) NOT NULL,
    sales_invoice_status VARCHAR(50) NOT NULL,
    auto_inv_status VARCHAR(50) NOT NULL,   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    INDEX (execution_id),
    INDEX (sales_header_id),    
    INDEX (invoice_header_id)
) AUTO_INCREMENT = 11;
