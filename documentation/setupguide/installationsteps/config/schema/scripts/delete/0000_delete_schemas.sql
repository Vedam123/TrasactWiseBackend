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
DROP SCHEMA IF EXISTS com;
DROP SCHEMA IF EXISTS fin; 