-- Car Rental System Database Setup for PostgreSQL
-- Run this script in DBeaver to create the database and schema

-- Step 1: Create the database (run this as postgres superuser)
-- If the database already exists, you can skip this step
CREATE DATABASE carrental
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE carrental IS 'Car Rental Management System Database';

-- Step 2: Connect to the carrental database in DBeaver
-- Then run the rest of this script

-- Create schema (optional, public schema is used by default)
-- CREATE SCHEMA IF NOT EXISTS public;

-- The Spring Boot application will automatically create these tables
-- when it starts with spring.jpa.hibernate.ddl-auto=update
-- But you can manually create them if needed:

-- Cars Table
CREATE TABLE IF NOT EXISTS car (
    id INTEGER PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    available BOOLEAN NOT NULL DEFAULT true
);

-- Users Table
CREATE TABLE IF NOT EXISTS app_user (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20)
);

-- Rentals Table
CREATE TABLE IF NOT EXISTS rental (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
    rental_date TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user(id),
    FOREIGN KEY (car_id) REFERENCES car(id)
);

-- Insert sample data
INSERT INTO car (id, make, model, available) VALUES 
    (1, 'Toyota', 'Corolla', true),
    (2, 'Honda', 'Civic', true),
    (3, 'BMW', 'X5', true),
    (4, 'Mercedes', 'C-Class', true),
    (5, 'Audi', 'A4', true)
ON CONFLICT (id) DO NOTHING;

INSERT INTO app_user (id, name, email, phone) VALUES 
    (1, 'Ayush', 'ayush@example.com', '+91-9876543210'),
    (2, 'Adi', 'adi@example.com', '+91-9876543211'),
    (3, 'Priya', 'priya@example.com', '+91-9876543212')
ON CONFLICT (id) DO NOTHING;

-- Verify data
SELECT * FROM car;
SELECT * FROM app_user;
SELECT * FROM rental;

-- Useful queries for monitoring
-- View all rentals with user and car details
CREATE OR REPLACE VIEW rental_details AS
SELECT 
    r.id as rental_id,
    r.rental_date,
    u.name as user_name,
    u.email as user_email,
    c.make || ' ' || c.model as car_name,
    c.available as car_available
FROM rental r
JOIN app_user u ON r.user_id = u.id
JOIN car c ON r.car_id = c.id
ORDER BY r.rental_date DESC;

-- Grant permissions (if using a specific user)
-- GRANT ALL PRIVILEGES ON DATABASE carrental TO your_username;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_username;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO your_username;
