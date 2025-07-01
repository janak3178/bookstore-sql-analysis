# bookstore-sql-analysis
**Analyze bookstore data—sales, inventory, and customer behavior—using SQL**

---

## Overview
This project manages data for books, customers, and orders to help:
- Track inventory and avoid stockouts
- Analyze sales by genre, author, and customer
- Calculate revenue, top-selling books, and frequent buyers

---

## Setup

1. Install **PostgreSQL** or **MySQL**  
2. **Load schema**:
   ```bash
   psql -U <USER> -d <DBNAME> -f schema.sql

or for MySQL:
mysql -u <USER> -p <DBNAME> < schema.sql



## Load Data
psql -d <DBNAME> -f data.sql
or:
mysql -u <USER> -p <DBNAME> < data.sql






