# Automobile Sales Database System





A complete relational database design and MySQL implementation for an automobile manufacturing and dealership sales company (modeled after multi-brand automotive groups such as Volkswagen Group, Tata Motors, General Motors, and Mahindra). This repository covers the full database lifecycle: conceptual Entity-Relationship (ER) modeling, logical relational schema mapping, database creation (DDL), realistic Indian sample data population (DML), and analytical business queries.

---

## Table of Contents

- [About the Database (What It Does)](#about-the-database-what-it-does)
- [Repository Structure (What Is Where)](#repository-structure-what-is-where)
- [Database Schema Overview](#database-schema-overview)
- [Getting Started](#getting-started)
- [Analytical & Operational Queries](#analytical--operational-queries)
- [Credits & Acknowledgements](#credits--acknowledgements)

---

## About the Database 

This database is engineered to manage and track the core operations of corporate brand management, vehicle manufacturing, supplier part tracking, dealership inventory, and customer sales:

* **Corporate Brand & Model Hierarchy:** Tracks multiple automotive brands under parent companies (such as *Volkswagen*, *Skoda*, and *Audi* under Volkswagen Group India, plus *Tata* and *Mahindra*) along with model body styles (*4-Door Sedan*, *SUV*, *Convertible*), colors, engines, and transmissions.
* **Manufacturing Plants & Supplier Parts Tracking:** Records both company-owned plants (*Final Assembly* and *Parts Manufacturing*) and external component suppliers (*Getrag*, *Bosch India*, *Bharat Forge*) with plant locations and manufacturing dates so defective part batches can be traced directly to affected vehicles and buyers.
* **Dealership Inventory & Sales Lifecycle:** Tracks vehicles by unique Vehicle Identification Number (`vin`) from dealership arrival (`arrival_date`) through customer purchase (`sale_date`, `sale_price`), while maintaining unsold stock (`In Inventory`) to measure dealer holding times.
* **Customer Demographics & OLAP Analytics:** Stores buyer gender, annual income, and decomposed Indian address fields to support multi-year sales trend rollups by brand, time period, gender, and income bracket.

---

## Repository Structure 

* **`README.md`** — Repository documentation, architecture overview, setup instructions, and project credits.
* **`ER_diagram.pdf`** — The conceptual Entity-Relationship (ER) diagram illustrating entities, attributes, primary keys, cardinality arrows, and total participation lines.
* **`Relational_model.pdf`** — The logical relational schema diagram (in `dbdiagram.io` format) mapping all 8 tables, column data types, primary keys, and foreign key relationships.
* **`automobile_sales_schema_and_data.sql`** — The complete MySQL setup script containing `CREATE TABLE` (DDL) statements with referential integrity constraints and `INSERT` (DML) statements populated with Indian customer names, dealerships, and manufacturing plants.
* **`test_queries.sql`** — The SQL script containing all analytical, recall, and dealership inventory queries used to validate the database.
* **`query_outputs/`** — Directory containing screenshots of the MySQL execution results for every test query.
---

## Database Schema Overview

The logical model consists of **8 normalized tables**:

| Table Name | Entity Type | Primary Key | Foreign Keys | Description |
| :--- | :--- | :--- | :--- | :--- |
| **`Brand`** | Independent | `brand_id` | *None* | Stores automotive brand `name` and parent `company_name`. |
| **`Model`** | Dependent | `model_id` | `brand_id` | Defines vehicle `name`, `body_style`, `color`, `engine`, and `transmission`. |
| **`Supplier`** | Independent | `supplier_id` | *None* | Stores external part supplier `name`, `plant_city`, and `phone`. |
| **`Plant`** | Independent | `plant_id` | *None* | Represents company-owned facilities (`Final Assembly`, `Parts Manufacturing`). |
| **`Part`** | Dependent | `part_id` | `model_id`, `supplier_id`, `plant_id` | Tracks component batches (`Transmission`, `Engine`, `Electronics`) and `mfg_date`. |
| **`Dealer`** | Independent | `dealer_id` | *None* | Stores authorized dealership contact info and decomposed address (`street`, `city`, `state`, `zip`). |
| **`Customer`** | Independent | `c_id` | *None* | Stores buyer contact details, `gender`, `annual_income`, and decomposed address. |
| **`Vehicle`** | Dependent | `vin` | `model_id`, `plant_id`, `dealer_id`, `c_id`, `part_id` | Central vehicle record tracking `arrival_date`, `sale_date`, `sale_price`, and inventory `status`. |

---

## Getting Started

### Prerequisites
* **MySQL Server** (8.0+ recommended)
* **MySQL Workbench**, DBeaver, phpMyAdmin, or the MySQL CLI

### Installation & Execution

1. **Clone the repository:**
   ```bash
   git clone https://github.com/sunnywork124-ai/Automobile-Sales-Database
   cd Automobile-Sales-Database
   ```

2. **Initialize the database and sample data:**
   * Open your MySQL client and execute the `automobile_sales_schema_and_data.sql` script.
   * This will automatically create the `automobile_sales` database, construct all 8 tables with foreign key constraints, and insert the Indian sample dataset.

3. **Run the analytical queries:**
   * Open `test_queries.sql` in your MySQL editor and execute the queries individually to inspect the outputs.

---

## Analytical & Operational Queries

The `test_queries.sql` script provides solutions to the following client scenarios:

1. **3-Year Brand Sales Trends:**
   * Aggregates unit sales and revenue by brand over the past 3 years across `year`, `month`, and `week`.
   * Breaks out brand sales by buyer `gender` and `income_range` brackets.
2. **Defective Getrag Transmission Recall:** Identifies the `vin` and buyer contact details for every car containing a transmission manufactured by supplier `Getrag` at its `Pune` plant between two given dates.
3. **Top 2 Brands by Revenue:** Finds the top 2 brands by total sales amount in the past year.
4. **Top 2 Brands by Unit Volume:** Finds the top 2 brands by number of vehicles sold in the past year.
5. **Convertible Seasonality:** Determines the calendar month (`March`) in which `Convertible` models achieve peak unit sales.
6. **Dealer Inventory Holding Time:** Ranks dealerships by the longest average number of days vehicles remain in inventory prior to sale.

---

## Credits & Acknowledgements

* **[dbdiagram.io](https://dbdiagram.io):** Used its web platform to build and visualize the logical Relational Model diagram.
