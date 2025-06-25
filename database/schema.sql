-- HavenHero Database Schema
-- Created for HavenHero Platform

-- Create database
CREATE DATABASE IF NOT EXISTS havenhero CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE havenhero;

-- Users table (booteigenaren, havenmeesters, platform eigenaar)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    user_type ENUM('booteigenaar', 'havenmeester', 'eigenaar') NOT NULL,
    avatar_url VARCHAR(500),
    email_verified_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Havens table
CREATE TABLE havens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    havenmeester_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) DEFAULT 'Nederland',
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    phone VARCHAR(20),
    email VARCHAR(255),
    website_url VARCHAR(500),
    facilities JSON, -- WiFi, toilet, douche, elektriciteit, water, etc.
    images JSON, -- Array van afbeelding URLs
    opening_hours JSON, -- Opening times per dag
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (havenmeester_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Ligplaatsen table
CREATE TABLE ligplaatsen (
    id INT PRIMARY KEY AUTO_INCREMENT,
    haven_id INT NOT NULL,
    name VARCHAR(100) NOT NULL, -- bijv. "A1", "B12"
    position_x DECIMAL(8, 3), -- X coordinaat voor plattegrond
    position_y DECIMAL(8, 3), -- Y coordinaat voor plattegrond
    max_length DECIMAL(5, 2), -- Maximale bootlengte in meters
    max_width DECIMAL(5, 2), -- Maximale bootbreedte in meters
    max_depth DECIMAL(4, 2), -- Maximale diepgang in meters
    price_per_night DECIMAL(8, 2) NOT NULL,
    facilities JSON, -- Specifieke voorzieningen van deze ligplaats
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (haven_id) REFERENCES havens(id) ON DELETE CASCADE
);

-- Boten table
CREATE TABLE boten (
    id INT PRIMARY KEY AUTO_INCREMENT,  
    eigenaar_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    boat_type ENUM('zeilboot', 'motorboot', 'sloep', 'catamaran', 'rib', 'andere') NOT NULL,
    length DECIMAL(5, 2) NOT NULL, -- Lengte in meters
    width DECIMAL(4, 2) NOT NULL, -- Breedte in meters  
    depth DECIMAL(4, 2), -- Diepgang in meters
    registration_number VARCHAR(100),
    year_built YEAR,
    description TEXT,
    images JSON, -- Array van afbeelding URLs
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (eigenaar_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Reserveringen table
CREATE TABLE reserveringen (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booteigenaar_id INT NOT NULL,
    ligplaats_id INT NOT NULL,
    boot_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_nights INT NOT NULL,
    price_per_night DECIMAL(8, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'checked_in', 'checked_out', 'cancelled', 'no_show') DEFAULT 'pending',
    special_requests TEXT,
    guests_count TINYINT DEFAULT 1,
    arrival_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booteigenaar_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (ligplaats_id) REFERENCES ligplaatsen(id) ON DELETE CASCADE,
    FOREIGN KEY (boot_id) REFERENCES boten(id) ON DELETE CASCADE
);

-- Betalingen table
CREATE TABLE betalingen (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservering_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('ideal', 'creditcard', 'paypal', 'banktransfer', 'cash') NOT NULL,
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    transaction_id VARCHAR(255),
    payment_date TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (reservering_id) REFERENCES reserveringen(id) ON DELETE CASCADE
);

-- Reviews table
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservering_id INT NOT NULL,
    booteigenaar_id INT NOT NULL,
    haven_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(200),
    comment TEXT,
    images JSON, -- Array van review afbeelding URLs
    is_verified BOOLEAN DEFAULT FALSE,
    response_from_haven TEXT, -- Reactie van havenmeester
    response_date TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (reservering_id) REFERENCES reserveringen(id) ON DELETE CASCADE,
    FOREIGN KEY (booteigenaar_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (haven_id) REFERENCES havens(id) ON DELETE CASCADE
);

-- Berichten table (communicatie tussen gebruikers)
CREATE TABLE berichten (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    recipient_id INT NOT NULL,
    subject VARCHAR(255),
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    related_reservation_id INT NULL,
    message_type ENUM('general', 'reservation', 'support', 'system') DEFAULT 'general',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (related_reservation_id) REFERENCES reserveringen(id) ON DELETE SET NULL
);

-- Session table voor authenticatie
CREATE TABLE user_sessions (
    id VARCHAR(128) PRIMARY KEY,
    user_id INT NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    payload TEXT NOT NULL,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes voor performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_type ON users(user_type);
CREATE INDEX idx_havens_location ON havens(latitude, longitude);
CREATE INDEX idx_havens_city ON havens(city);
CREATE INDEX idx_ligplaatsen_haven ON ligplaatsen(haven_id);
CREATE INDEX idx_ligplaatsen_available ON ligplaatsen(is_available);
CREATE INDEX idx_reserveringen_dates ON reserveringen(check_in_date, check_out_date);
CREATE INDEX idx_reserveringen_status ON reserveringen(status);
CREATE INDEX idx_betalingen_status ON betalingen(payment_status);
CREATE INDEX idx_reviews_haven ON reviews(haven_id);
CREATE INDEX idx_berichten_recipient ON berichten(recipient_id, is_read);