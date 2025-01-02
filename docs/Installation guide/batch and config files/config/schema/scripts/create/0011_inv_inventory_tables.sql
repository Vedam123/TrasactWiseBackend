-- Drop tables if they exist 

DROP TABLE IF EXISTS inv.item_inventory;
DROP TABLE IF EXISTS inv.shipments;
DROP TABLE IF EXISTS inv.bins;
DROP TABLE IF EXISTS inv.racks;
DROP TABLE IF EXISTS inv.invrows;
DROP TABLE IF EXISTS inv.aisles;
DROP TABLE IF EXISTS inv.zones;
DROP TABLE IF EXISTS inv.receipts;
DROP TABLE IF EXISTS inv.inspection;
DROP TABLE IF EXISTS inv.locations;
DROP TABLE IF EXISTS inv.warehouses;

-- Table to store information about warehouses
CREATE TABLE inv.warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_name VARCHAR(255) NOT NULL,
    description TEXT,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    capacity INT,
    temperature_controlled ENUM('normal', 'cold', 'warm'),
    security_level ENUM('low', 'medium', 'high'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
) AUTO_INCREMENT=10;

-- Table to store information about locations
CREATE TABLE inv.locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(255) NOT NULL,
    location_type ENUM('store', 'distribution_center', 'other') NOT NULL,
    description TEXT,
    capacity INT,
    temperature_controlled ENUM('normal', 'cold', 'warm'),
    security_level ENUM('low', 'medium', 'high'),
    warehouse_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (warehouse_id) REFERENCES inv.warehouses(warehouse_id) ON DELETE CASCADE
) AUTO_INCREMENT=20;


-- Table to store information about zones within a location
CREATE TABLE inv.zones (
    zone_id INT PRIMARY KEY AUTO_INCREMENT,
    location_id INT,
    zone_name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (location_id) REFERENCES inv.locations(location_id) ON DELETE CASCADE
) AUTO_INCREMENT=30;

-- Table to store information about aisles within a zone
CREATE TABLE inv.aisles (
    aisle_id INT PRIMARY KEY AUTO_INCREMENT,
    zone_id INT,
    aisle_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (zone_id) REFERENCES inv.zones(zone_id) ON DELETE CASCADE
) AUTO_INCREMENT=40;

-- Table to store information about invrows within an aisle
CREATE TABLE inv.invrows (
    row_id INT PRIMARY KEY AUTO_INCREMENT,
    aisle_id INT,
    row_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (aisle_id) REFERENCES inv.aisles(aisle_id) ON DELETE CASCADE
) AUTO_INCREMENT=50;

-- Table to store information about racks within a row
CREATE TABLE inv.racks (
    rack_id INT PRIMARY KEY AUTO_INCREMENT,
    row_id INT,
    rack_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (row_id) REFERENCES inv.invrows(row_id) ON DELETE CASCADE
) AUTO_INCREMENT=70;


-- Table to store information about bins within a rack
CREATE TABLE inv.bins (
    bin_id INT PRIMARY KEY AUTO_INCREMENT,
    rack_id INT,
    bin_name VARCHAR(50) NOT NULL,
    description TEXT,
    capacity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (rack_id) REFERENCES inv.racks(rack_id) ON DELETE CASCADE
) AUTO_INCREMENT=70;

-- Table for inspections
CREATE TABLE inv.inspection (
  inspection_id INT PRIMARY KEY AUTO_INCREMENT,
  item_id INT,
  inspection_name VARCHAR(255) NOT NULL,
  inspection_location_id INT,
  transaction_quantity INT,
  accepted_quantity INT,
  rejected_quantity INT,
  uom_id INT,
  status VARCHAR(50),
  comments TEXT,
  transaction_number INT,
  transaction_type VARCHAR(255),
  transaction_header_number INT,
  accepted_qty_details TEXT,
  rejected_qty_details TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by INT,
  updated_by INT,
  FOREIGN KEY (inspection_location_id) REFERENCES inv.locations(location_id),
  FOREIGN KEY (uom_id) REFERENCES com.uom(uom_id),
  FOREIGN KEY (item_id) REFERENCES com.items(item_id)
) AUTO_INCREMENT=4562;

-- Table for receiving inventory
CREATE TABLE inv.receipts (
  receipt_id INT PRIMARY KEY AUTO_INCREMENT,
  transaction_number INT,
  transaction_header_number INT,
  item_id INT,
  receipt_name VARCHAR(255) NOT NULL,
  receiving_location_id INT,
  quantity INT,
  uom_id INT,
  comments TEXT,
  inspect BOOLEAN,
  accepted_qty INT,
  rejected_qty INT,
  inspection_id INT NULL,
  inspection_location_id INT,
  status VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by INT,
  updated_by INT,
  FOREIGN KEY (receiving_location_id) REFERENCES inv.locations(location_id),
  FOREIGN KEY (uom_id) REFERENCES com.uom(uom_id),
  FOREIGN KEY (item_id) REFERENCES com.items(item_id),
  FOREIGN KEY (inspection_id) REFERENCES inv.inspection(inspection_id) ON DELETE SET NULL,
  FOREIGN KEY (inspection_location_id) REFERENCES inv.locations(location_id)
) AUTO_INCREMENT=1024;

-- Table for shipments
CREATE TABLE inv.shipments (
  shipment_id INT PRIMARY KEY AUTO_INCREMENT,
  item_id INT,
  shipment_name VARCHAR(255) NOT NULL,
  staging_location_id INT,
  quantity INT,
  uom_id INT,
  comments TEXT,
  inspect BOOLEAN,
  transaction_number INT,
  status VARCHAR(255) DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by INT,
  updated_by INT,
  FOREIGN KEY (staging_location_id) REFERENCES inv.locations(location_id),
  FOREIGN KEY (uom_id) REFERENCES com.uom(uom_id),
  FOREIGN KEY (item_id) REFERENCES com.items(item_id)
) AUTO_INCREMENT=2212;

-- Table to store information about item inventory
CREATE TABLE inv.item_inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT NOT NULL,
    transaction_type VARCHAR(255) NOT NULL,
    item_id INT NOT NULL,
    uom_id INT NOT NULL,
    quantity INT,
    bin_id INT,
    rack_id INT,
    row_id INT,
    aisle_id INT,
    zone_id INT,
    location_id INT,
    warehouse_id INT,
    status ENUM('Yes', 'No'),
    subject VARCHAR(255),
    additional_info LONGTEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    UNIQUE KEY unique_combination (
        transaction_id, transaction_type, item_id, uom_id,
        bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id
    ),
    FOREIGN KEY (item_id) REFERENCES com.items(item_id),
    FOREIGN KEY (uom_id) REFERENCES com.uom(uom_id),
    FOREIGN KEY (bin_id) REFERENCES inv.bins(bin_id),
    FOREIGN KEY (rack_id) REFERENCES inv.racks(rack_id),
    FOREIGN KEY (row_id) REFERENCES inv.invrows(row_id),
    FOREIGN KEY (aisle_id) REFERENCES inv.aisles(aisle_id),
    FOREIGN KEY (zone_id) REFERENCES inv.zones(zone_id),
    FOREIGN KEY (location_id) REFERENCES inv.locations(location_id),
    FOREIGN KEY (warehouse_id) REFERENCES inv.warehouses(warehouse_id)
) AUTO_INCREMENT=1111;

