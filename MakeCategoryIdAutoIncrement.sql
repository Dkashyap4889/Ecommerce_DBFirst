-- SQL Script to make the category.id column auto-increment (IDENTITY)
-- Run this in SQL Server Management Studio or Azure Data Studio

USE ECommerceApp;
GO

-- Step 1: Create a temporary table with IDENTITY
CREATE TABLE category_temp (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Step 2: Copy existing data (if any exists)
IF EXISTS (SELECT 1 FROM category)
BEGIN
    SET IDENTITY_INSERT category_temp ON;
    INSERT INTO category_temp (id, name)
    SELECT id, name FROM category;
    SET IDENTITY_INSERT category_temp OFF;
END

-- Step 3: Drop old table and foreign key dependencies
DROP TABLE category;

-- Step 4: Rename temp table to category
EXEC sp_rename 'category_temp', 'category';

-- Verify the change
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, 
       COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA + '.' + TABLE_NAME), COLUMN_NAME, 'IsIdentity') AS IsIdentity
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'category' AND COLUMN_NAME = 'id';

PRINT 'Category table id column is now set to IDENTITY (auto-increment)';
