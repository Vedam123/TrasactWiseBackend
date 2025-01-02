-- Drop tables if they already exist
DROP TABLE IF EXISTS adm.user_module_permissions;
DROP TABLE IF EXISTS adm.users;
DROP TABLE IF EXISTS adm.modules;
DROP TABLE IF EXISTS adm.ui_config_data; 
DROP TABLE IF EXISTS adm.bk_configurations; 
DROP TABLE IF EXISTS adm.bk_super_user; 

-- For adm.modules table
CREATE TABLE adm.modules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folder_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 10;

-- For adm.users table
CREATE TABLE adm.users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    empid INT,
    emailid VARCHAR(255) UNIQUE, -- Adding UNIQUE constraint to emailid
    status VARCHAR(50),
    start_date DATE,
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    -- Adding foreign key reference to com.employee table
    FOREIGN KEY (empid) REFERENCES com.employee(empid)
) AUTO_INCREMENT = 1200;

-- For adm.user_module_permissions table
CREATE TABLE adm.user_module_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    module VARCHAR(100) NOT NULL,
    read_permission BOOLEAN DEFAULT false,
    write_permission BOOLEAN DEFAULT false,
    update_permission BOOLEAN DEFAULT false,
    delete_permission BOOLEAN DEFAULT false,
    UNIQUE (user_id, module),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (user_id) REFERENCES adm.users(id)
) AUTO_INCREMENT = 100;

-- For adm.ui_config_data table
CREATE TABLE adm.ui_config_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(255) NOT NULL UNIQUE,
    config_value TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
);

-- For adm.bk_configurations table
CREATE TABLE adm.bk_configurations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(255) NOT NULL UNIQUE,
    config_value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
);

CREATE TABLE adm.bk_super_user (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Auto-incremented primary key
    username VARCHAR(255) NOT NULL,       -- Username field, cannot be null
    name VARCHAR(255) NOT NULL,           -- Name field, cannot be null
    password VARCHAR(255) NOT NULL        -- Password field, cannot be null
);

