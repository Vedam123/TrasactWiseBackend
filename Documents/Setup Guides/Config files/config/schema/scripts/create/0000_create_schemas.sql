-- Drop schemas if they already exist
DROP SCHEMA IF EXISTS pur;
DROP SCHEMA IF EXISTS inv;
DROP SCHEMA IF EXISTS sal;
DROP SCHEMA IF EXISTS adm;
DROP TABLE IF EXISTS fin.journal_lines;
DROP TABLE IF EXISTS fin.journal_headers;
DROP TABLE IF EXISTS fin.default_accounts;
DROP TABLE IF EXISTS fin.salesinvoicelines;
DROP TABLE IF EXISTS fin.salesinvoiceaccounts;
DROP TABLE IF EXISTS fin.salesinvoice;
DROP TABLE IF EXISTS fin.purchaseinvoicelines;
DROP TABLE IF EXISTS fin.purchaseinvoiceaccounts;
DROP TABLE IF EXISTS fin.purchaseinvoice;
DROP TABLE IF EXISTS fin.accounts;
DROP TABLE IF EXISTS com.department;

-- Now drop the schemas
DROP SCHEMA IF EXISTS com;
DROP SCHEMA IF EXISTS fin; 

-- Create schemas
CREATE SCHEMA fin;
CREATE SCHEMA adm;
CREATE SCHEMA pur;
CREATE SCHEMA com;
CREATE SCHEMA inv;
CREATE SCHEMA sal;

-- In this script I incorrectly designed the table to reference fin.default_account_headers,
-- this table can be created within the com module, fix this later without fail.
-- Because of this, dropping modules and recreating them causes issues during installation process.
-- To drop the com and fin schemas, you need to drop the referential tables in these two schemas to avoid issues.
-- I've added drop tables in the above script before dropping com and fin schemas.
