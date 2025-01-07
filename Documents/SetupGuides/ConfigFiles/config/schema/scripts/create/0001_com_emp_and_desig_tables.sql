-- Drop tables if they already exist
DROP TABLE IF EXISTS com.employee;
DROP TABLE IF EXISTS com.designations;

-- For com.designations table
CREATE TABLE com.designations (
    designation_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    designation_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    salary_range VARCHAR(50),
    responsibilities TEXT,
    qualifications TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 100;

-- For com.employee table
CREATE TABLE com.employee (
    empid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    manager_id INT, -- Reference to empid in the same table
    supervisor_id INT, -- Reference to empid in the same table
    pic BLOB,
    salary DECIMAL(9, 3),
    role VARCHAR(45),
    dob DATE,
    doj DATE,
    resignation_date DATE, -- New field for resignation date
    status BOOLEAN, -- New field for status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    designation_id INT,
    FOREIGN KEY (designation_id) REFERENCES com.designations(designation_id),
    FOREIGN KEY (manager_id) REFERENCES com.employee(empid),
    FOREIGN KEY (supervisor_id) REFERENCES com.employee(empid)
) AUTO_INCREMENT = 2000;

