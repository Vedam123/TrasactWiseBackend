-- Drop tables if they already exist
DROP TABLE IF EXISTS com.department;
DROP TABLE IF EXISTS com.company_tax_codes;
DROP TABLE IF EXISTS com.company;
DROP TABLE IF EXISTS com.group_company;
DROP TABLE IF EXISTS com.legal_entity;
DROP TABLE IF EXISTS fin.default_account_headers;

-- For com.legal_entity table
CREATE TABLE com.legal_entity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    registration_number VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact_email VARCHAR(40),
    contact_phone VARCHAR(20),
    about TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 1001;

-- For com.group_company table
CREATE TABLE com.group_company (
    id INT AUTO_INCREMENT PRIMARY KEY,
    legal_entity_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (legal_entity_id) REFERENCES com.legal_entity (id) ON DELETE CASCADE
) AUTO_INCREMENT = 2001;

-- For com.company_tax_codes table
CREATE TABLE com.company_tax_codes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(100),
    default_sales_tax_id INT,
    default_purchase_tax_id INT,
    default_excise_duty_id INT,
    default_customs_duty_id INT,
    default_income_tax_id INT,
    default_property_tax_id INT,
    default_corporate_tax_id INT,
    default_local_tax_id INT,
    default_environmental_tax_id INT,
    default_vat_id INT,
    default_gst_id INT,
    default_service_tax_id INT,
    default_excise_tax_id INT,
    default_other_tax_id INT,
    default_extra_tax1_id INT,
    default_extra_tax2_id INT,
    default_extra_tax3_id INT,
    default_extra_tax4_id INT,
    default_extra_tax5_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (default_sales_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_purchase_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_excise_duty_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_customs_duty_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_income_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_property_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_corporate_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_local_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_environmental_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_vat_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_gst_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_service_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_excise_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_other_tax_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_extra_tax1_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_extra_tax2_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_extra_tax3_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_extra_tax4_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL,
    FOREIGN KEY (default_extra_tax5_id) REFERENCES com.tax (tax_id) ON DELETE SET NULL
) AUTO_INCREMENT = 301;

-- For fin.default_account_headers table
CREATE TABLE fin.default_account_headers (
    header_id INT AUTO_INCREMENT PRIMARY KEY,
    header_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 2000;

-- For com.company table
CREATE TABLE com.company (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_company_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    local_cur_id INT,
    home_cur_id INT,
    reporting_cur_id INT,
    default_tax_code_id INT,
    default_account_header_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (group_company_id) REFERENCES com.group_company (id) ON DELETE CASCADE,
    FOREIGN KEY (local_cur_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (home_cur_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (reporting_cur_id) REFERENCES com.currency (currency_id),
    FOREIGN KEY (default_tax_code_id) REFERENCES com.default_tax_config (header_id) ON DELETE SET NULL,
    FOREIGN KEY (default_account_header_id) REFERENCES fin.default_account_headers (header_id) ON DELETE SET NULL
) AUTO_INCREMENT = 3001;

-- For com.department table
CREATE TABLE com.department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT,
    description TEXT,
    default_account_header_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (company_id) REFERENCES com.company (id) ON DELETE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES com.employee (empid) ON DELETE SET NULL,
    FOREIGN KEY (default_account_header_id) REFERENCES fin.default_account_headers (header_id) ON DELETE SET NULL
) AUTO_INCREMENT = 40001;


