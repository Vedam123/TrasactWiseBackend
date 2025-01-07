-- Drop the tables if they exist (lowercase table names)
DROP TABLE IF EXISTS com.category_image_mapping;
DROP TABLE IF EXISTS com.item_image_mapping;
DROP TABLE IF EXISTS com.bom;
DROP TABLE IF EXISTS com.item_attributes;
DROP TABLE IF EXISTS com.items;
DROP TABLE IF EXISTS com.uom;
DROP TABLE IF EXISTS com.itemcategory;
DROP TABLE IF EXISTS com.category_images;
DROP TABLE IF EXISTS com.item_images;
DROP TABLE IF EXISTS com.attribute_definitions;

-- Create the com.itemcategory table with unique constraint on category_name
CREATE TABLE com.itemcategory (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,  -- Make category_name unique
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    tax_information VARCHAR(50),
    default_uom VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 1001;

-- Create the com.category_images table
CREATE TABLE com.category_images (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    image MEDIUMBLOB NOT NULL,
    image_type VARCHAR(50),  -- Optional: Type of image, e.g., 'thumbnail', 'fullsize'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 1001;

-- Create a mapping table to associate categories with multiple images
CREATE TABLE com.category_image_mapping (
    mapping_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    image_id INT NOT NULL,
    image_order INT,  -- Optional: To specify the order of images (e.g., for display purposes)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES com.itemcategory(category_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES com.category_images(image_id) ON DELETE CASCADE
) AUTO_INCREMENT = 1001;

-- Create the com.uom table (Unit of Measure)
CREATE TABLE com.uom (
    uom_id INT PRIMARY KEY AUTO_INCREMENT,
    uom_name VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(10) NOT NULL UNIQUE,
    conversion_factor DOUBLE NOT NULL,
    decimal_places TINYINT,
    base_unit INT NULL,  -- Allow NULL for base_unit
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    UNIQUE KEY unique_uom_name_abbreviation (uom_name, abbreviation),
    FOREIGN KEY (base_unit) REFERENCES com.uom(uom_id) ON DELETE CASCADE
);

-- Create the com.items table (updated with new columns)
CREATE TABLE com.items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_code VARCHAR(50) NOT NULL UNIQUE,
    item_name VARCHAR(255) NOT NULL,
    category_id INT,
    unit_price DECIMAL(10, 2),
    manufacturer VARCHAR(100),
    barcode VARCHAR(50),
    stock_quantity INT,
    min_stock_level INT,
    max_stock_level INT,
    reorder_point INT,
    lead_time INT,
    shelf_life INT,                -- Changed to INT to represent shelf life duration
    location VARCHAR(50),
    product_type VARCHAR(20),
    notes TEXT,
    default_uom_id INT,
    expiry_date_flag BOOLEAN,      -- New column added
    expiry_date DATE,              -- New column added
    is_serial_controlled BOOLEAN DEFAULT FALSE,  -- New column with default value NO
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (category_id) REFERENCES com.itemcategory (category_id),
    FOREIGN KEY (default_uom_id) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 1000001;

-- Create the com.item_images table
CREATE TABLE com.item_images (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    image MEDIUMBLOB NOT NULL,
    image_type VARCHAR(50),  -- Optional: Type of image, e.g., 'thumbnail', 'fullsize'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT = 1001;

-- Create the com.item_image_mapping table
CREATE TABLE com.item_image_mapping (
    mapping_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT NOT NULL,
    image_id INT NOT NULL,
    image_order INT,  -- Optional: To specify the order of images (e.g., for display purposes)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES com.items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES com.item_images(image_id) ON DELETE CASCADE
) AUTO_INCREMENT = 1001;

-- Create the com.bom table (Bill of Materials)
CREATE TABLE com.bom (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ModelItem INT,
    ParentItem INT,
    ComponentItem INT,
    Quantity DECIMAL(10, 2),
    uom INT,
    ScrapPercentage DECIMAL(5, 2),
    RoutingOperation VARCHAR(50),
    Revision VARCHAR(10),
    EffectiveDate DATE,
    EndDate DATE,
    NotesComments TEXT,
    Level INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    UNIQUE KEY (ModelItem, ParentItem, ComponentItem),
    FOREIGN KEY (ModelItem) REFERENCES com.items (item_id),
    FOREIGN KEY (ParentItem) REFERENCES com.items (item_id),
    FOREIGN KEY (ComponentItem) REFERENCES com.items (item_id),
    FOREIGN KEY (uom) REFERENCES com.uom (uom_id)
) AUTO_INCREMENT = 1111;

-- Create the com.attribute_definitions table for CRM orders
CREATE TABLE com.attribute_definitions (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_type VARCHAR(50) NOT NULL  -- For example, 'INT', 'VARCHAR', 'DATE', etc.
);

-- Create the com.item_attributes table for CRM orders
CREATE TABLE com.item_attributes (
    attributes_master_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    attribute_id INT,
    attribute_value VARCHAR(255),  -- Store the value as text and convert as needed
    FOREIGN KEY (item_id) REFERENCES com.items(item_id),
    FOREIGN KEY (attribute_id) REFERENCES com.attribute_definitions(attribute_id)
);
