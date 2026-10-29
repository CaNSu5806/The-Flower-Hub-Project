-- =============================================================================
-- The Flower Hub Database: Master Execution Script
-- =============================================================================

SET SERVEROUTPUT ON;
SET FEEDBACK ON;

PROMPT [1/5] Dropping existing schema objects...
@schema/00_cleanup.sql

PROMPT [2/5] Creating tables, keys and constraints...
@schema/01_tables.sql

PROMPT [3/5] Inserting seed data...
@data/02_seed_data.sql

PROMPT [4/5] Compiling stored procedures...
@logic/03_procedures.sql

PROMPT [5/5] Compiling database triggers...
@logic/04_triggers.sql

PROMPT Database setup completed successfully!
