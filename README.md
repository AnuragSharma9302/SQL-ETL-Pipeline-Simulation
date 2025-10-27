# 🧩 SQL ETL Pipeline Simulation  

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue?logo=postgresql)
![pgAdmin](https://img.shields.io/badge/Tool-pgAdmin-orange?logo=postgresql)
![License](https://img.shields.io/badge/License-MIT-green)
![Dataset](https://img.shields.io/badge/Data-Kaggle%20E--commerce-lightgrey?logo=kaggle)

---

### 🎯 **Overview**
A compact **SQL-based ETL Pipeline** built using **PostgreSQL** and **pgAdmin**, designed to simulate a real-world data engineering workflow — from importing raw CSV data to transforming, cleaning, and loading it into production-ready tables with audit logging and automation.

---

### ⚙️ **How It Works**
1. **Extract** → Imported Kaggle E-commerce CSV into PostgreSQL staging tables using the `COPY` command.  
2. **Transform** → Cleaned and standardized data (handled nulls, duplicates, invalid prices).  
3. **Load** → Moved transformed data to production tables with constraints.  
4. **Audit** → Implemented triggers and audit logs to track every ETL operation.  
5. **Validate** → Wrote SQL scripts to verify row counts, data quality, and totals.

---

## 🧰 Project Structure  

```bash
SQL-ETL-Pipeline-Simulation/
│
├── 📁 data/               # Raw Kaggle dataset (CSV files)
│   └── ecommerce_data.csv
│
├── 📁 scripts/            # SQL scripts used for ETL (DDL, DML, triggers, audits)
│   ├── create_tables.sql
│   ├── transform_data.sql
│   ├── load_production.sql
│   └── audit_triggers.sql
│
├── 📁 exports/            # Final exported cleaned & validated production tables
│   ├── production_customers.csv
│   ├── production_orders.csv
│   └── etl_logs.csv
│
├── 📁 validation/         # SQL queries for verification & data quality checks
│   └── etl_validation_queries.sql
│
├── README.md              # Project documentation
└── LICENSE                # Open-source license
```
---
### 📦 Folder Breakdown
Folder	Description
data/	      :  Contains raw Kaggle datasets used as input for ETL.
scripts/	  : Holds SQL scripts for table creation, transformation, loading, and automation                     (triggers, procedures).
exports/	  : Includes final cleaned and production-ready tables exported from PostgreSQL.
validation/ : Contains SQL validation and testing queries for verifying ETL results.

---

### 💡 **Why It Matters**
This project demonstrates how to manage **ETL workflows entirely in SQL**, showcasing:
- Handling **real-world data issues** (encoding, nulls, outliers).  
- Applying **data quality checks and audit trails**.  
- Building maintainable, modular ETL pipelines using only PostgreSQL.  

---

### 🧠 **Key Learnings**
- Practical experience with **SQL-based data engineering**.  
- Built triggers, audit tables, and cleaning logic in **PL/pgSQL**.  
- Learned to troubleshoot **encoding and import errors** (`WIN1252 → UTF8`).  
- Improved skills in **data modeling** and **ETL validation queries**.

---

### 🚀 **Outcomes**
✅ Built a **fully functional ETL pipeline** in SQL.  
✅ Produced **cleaned, validated production tables** from raw CSVs.  
✅ Created **automated audit logging** for data loads.  
✅ Achieved **complete traceability and reproducibility** of ETL steps.  

---

### 🧰 **Tech Stack**
**PostgreSQL 17** • **pgAdmin 4** • **SQL** • **Kaggle E-commerce Dataset**

---

### 🌱 **Next Steps**
- Add **Python / Streamlit dashboard** to visualize ETL metrics.  
- Automate ETL execution via **Airflow** or **cron jobs**.  
- Extend with **error handling and notifications** for failed loads.  

---

> 🗣 *“This project helped me bridge SQL fundamentals with real-world data engineering — building pipelines that are clean, auditable, and production-ready.”*

---
