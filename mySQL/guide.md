# MySQL Mastery Roadmap

*A comprehensive path from fundamentals to production-grade MySQL expertise — extended with engine internals, operations, security, and data science integration.*

> **How to use this:** Check off `[ ]` items as you go. Items marked **(8.0+)** require MySQL 8.0 or later — worth confirming your target environment's version before you rely on them.

## Table of Contents
- [Phase 1: Fundamentals](#phase-1-fundamentals)
- [Phase 2: Intermediate Concepts](#phase-2-intermediate-concepts)
- [Phase 3: Advanced Features](#phase-3-advanced-features)
- [Phase 4: Performance & Optimization](#phase-4-performance--optimization)
- [Phase 5: Real-World Skills](#phase-5-real-world-skills)
- [Phase 6: Professional Development](#phase-6-professional-development)
- [Practical Tips for Success](#practical-tips-for-success)
- [Job-Ready Indicators](#job-ready-indicators)

---

## Phase 1: Fundamentals
*Get comfortable with what a database actually is and how to talk to one.*

### 1. Database Basics
- [ ] What is a database
- [ ] RDBMS concepts
- [ ] Primary keys and Foreign keys
- [ ] Basic database design principles
- [ ] Entity-Relationship Diagrams (ERD)
- [ ] ACID properties (Atomicity, Consistency, Isolation, Durability)
- [ ] Key types: candidate, composite, surrogate vs. natural, unique

### 2. Basic SQL Queries
- [ ] SELECT statements
- [ ] WHERE clauses
- [ ] ORDER BY, GROUP BY
- [ ] Basic filtering conditions
- [ ] DISTINCT keyword
- [ ] Column aliases
- [ ] CASE WHEN conditional expressions
- [ ] Comments (`--` and `/* */`)
- [ ] LIMIT / OFFSET pagination

### 3. Data Types and Schema
- [ ] Numeric types
- [ ] String types
- [ ] Date/Time types
- [ ] NULL values
- [ ] CREATE TABLE syntax
- [ ] Understanding constraints
- [ ] MySQL-specific types: `ENUM`, `SET`, `TINYINT`/`MEDIUMINT`/`BIGINT`, `YEAR`
- [ ] `AUTO_INCREMENT`
- [ ] Character sets & collations (`utf8mb4` vs. `latin1` — a classic MySQL gotcha)

### 4. Environment & Tooling Setup
- [ ] Installing MySQL Server (native + Docker)
- [ ] `mysql` command-line client basics
- [ ] MySQL Workbench walkthrough
- [ ] GUI clients (DBeaver, TablePlus)

---

## Phase 2: Intermediate Concepts
*Move from single-table queries to combining, aggregating, and nesting logic across tables.*

### 1. JOINs Mastery
- [ ] INNER JOIN
- [ ] LEFT/RIGHT JOIN
- [ ] FULL OUTER JOIN (MySQL has no native syntax — emulate via `UNION` of a LEFT and RIGHT JOIN)
- [ ] CROSS JOIN
- [ ] Self JOIN
- [ ] Multiple table joins
- [ ] Anti-joins (`NOT EXISTS`, `NOT IN`, `LEFT JOIN ... WHERE IS NULL`)

### 2. Aggregate Functions
- [ ] COUNT, SUM, AVG
- [ ] MIN, MAX
- [ ] GROUP BY with HAVING
- [ ] Complex aggregations
- [ ] Mathematical functions
- [ ] `WITH ROLLUP` for subtotals
- [ ] Statistical aggregates: `STDDEV`, `VARIANCE` (handy for a quick EDA pass before reaching for pandas)

### 3. Subqueries
- [ ] Single row subqueries
- [ ] Multiple row subqueries
- [ ] Correlated subqueries
- [ ] EXISTS operator
- [ ] IN vs. ANY vs. ALL
- [ ] Derived tables (subqueries in `FROM`)
- [ ] `LATERAL` derived tables **(8.0.14+)**

### 4. Set Operations & Conditional Logic
- [ ] `UNION` vs. `UNION ALL`
- [ ] `INTERSECT` / `EXCEPT` **(8.0.31+)**
- [ ] NULL handling: `COALESCE`, `IFNULL`, `NULLIF`
- [ ] `CASE`-based conditional aggregation (MySQL's answer to PIVOT)

---

## Phase 3: Advanced Features
*Analytical SQL — window functions, CTEs, and server-side logic that used to live only in application code.*

### 1. Window Functions
- [ ] RANK, DENSE_RANK
- [ ] ROW_NUMBER
- [ ] LAG/LEAD
- [ ] FIRST_VALUE/LAST_VALUE
- [ ] Running totals
- [ ] Moving averages
- [ ] NTILE, PERCENT_RANK, CUME_DIST
- [ ] Frame clauses: `ROWS` vs. `RANGE BETWEEN`

### 2. Common Table Expressions (CTEs)
- [ ] Basic CTEs
- [ ] Recursive CTEs
- [ ] Multiple CTEs
- [ ] CTEs vs. Subqueries

### 3. Views and Stored Procedures
- [ ] Creating views
- [ ] Materialized views (no native support in MySQL — simulate with scheduled/triggered summary tables)
- [ ] Writing stored procedures
- [ ] Functions vs. Procedures
- [ ] Triggers basics
- [ ] Cursors inside stored procedures
- [ ] Error handling: `DECLARE ... HANDLER`
- [ ] User-defined functions (UDFs)
- [ ] Event Scheduler (MySQL's built-in cron)

### 4. Triggers Deep Dive
- [ ] BEFORE/AFTER INSERT, UPDATE, DELETE
- [ ] Use cases: auditing, maintaining denormalized aggregates
- [ ] Pitfalls: trigger chains, hidden performance costs, debugging difficulty

---

## Phase 4: Performance & Optimization
*What MySQL is doing under the hood, and why some queries are fast and others aren't.*

### 1. Indexing
- [ ] B-tree indexes
- [ ] Clustered vs. Non-clustered
- [ ] Composite indexes
- [ ] When to use indexes
- [ ] Index maintenance
- [ ] Covering indexes
- [ ] Full-text & spatial indexes
- [ ] Invisible indexes **(8.0+)** — test the impact of removal without dropping
- [ ] Descending indexes **(8.0+)**
- [ ] Index cardinality & selectivity — a B-tree lookup is O(log n) against an O(n) full table scan, but selectivity determines whether the optimizer actually takes that path

### 2. Query Optimization
- [ ] Reading execution plans
- [ ] Query performance analysis
- [ ] Common bottlenecks
- [ ] Query refactoring
- [ ] Best practices
- [ ] `EXPLAIN` vs. `EXPLAIN ANALYZE` **(8.0.18+)**
- [ ] Optimizer hints (`STRAIGHT_JOIN`, index hints)
- [ ] Cost-based optimizer basics

### 3. Database Design
- [ ] Normalization (1NF to 3NF)
- [ ] Denormalization when needed
- [ ] Table partitioning
- [ ] Data integrity
- [ ] Backup strategies

### 4. Storage Engines
- [ ] InnoDB internals: buffer pool, redo log, undo log, MVCC
- [ ] MyISAM vs. InnoDB vs. Memory engine — trade-offs
- [ ] Choosing the right engine per table/workload

### 5. Server Configuration & Tuning
- [ ] Key `my.cnf` parameters (`innodb_buffer_pool_size`, `max_connections`, etc.)
- [ ] Connection pooling
- [ ] Monitoring: `performance_schema`, slow query log

---

## Phase 5: Real-World Skills
*Production concerns — transactions, security, backups, replication, and getting data in and out of Python.*

### 1. Data Manipulation
- [ ] CRUD operations
- [ ] Batch operations
- [ ] Transaction management
- [ ] Error handling
- [ ] Concurrency control
- [ ] `ON DUPLICATE KEY UPDATE`, `REPLACE INTO` (MySQL-flavored upserts)
- [ ] Transaction isolation levels (`READ COMMITTED`, `REPEATABLE READ` — MySQL's default, `SERIALIZABLE`)
- [ ] Deadlock detection & handling

### 2. Data Migration
- [ ] Import/Export techniques
- [ ] ETL basics
- [ ] Data cleaning
- [ ] Handling large datasets
- [ ] Version control for schema

### 3. Industry Specifics
- [ ] Working with dates/times
- [ ] String manipulation
- [ ] JSON/XML handling — `JSON_EXTRACT`, `JSON_TABLE` **(8.0.4+)**, generated columns from JSON paths
- [ ] Geographical data
- [ ] Full-text search: natural language vs. boolean mode

### 4. MySQL Security
- [ ] User management: `CREATE USER`, `GRANT` / `REVOKE`
- [ ] Roles **(8.0+)**
- [ ] Preventing SQL injection (parameterized queries, prepared statements)
- [ ] Encryption at rest & in transit (SSL/TLS)
- [ ] Auditing & access logging

### 5. Backup, Recovery & Replication
- [ ] Logical backups: `mysqldump`, `mysqlpump`
- [ ] Physical backups: Percona XtraBackup
- [ ] Binary logs & point-in-time recovery
- [ ] Replication: Master-Slave (async), Master-Master, Group Replication
- [ ] High availability patterns: failover, read replicas

### 6. MySQL for Data Science & Python Integration
- [ ] Connecting via `mysql-connector-python` / `PyMySQL`
- [ ] SQLAlchemy ORM basics for MySQL
- [ ] `pandas.read_sql()` and `DataFrame.to_sql()` workflows
- [ ] Efficient batch inserts (`executemany`, `LOAD DATA INFILE`)
- [ ] MySQL as a feature store / staging layer in an ML pipeline

---

## Phase 6: Professional Development
*Package what you know into projects, tooling fluency, and interview-ready explanations.*

### 1. Project Portfolio
- [ ] E-commerce database
- [ ] Social media schema
- [ ] Inventory system
- [ ] Analytics database
- [ ] Real-time monitoring system
- [ ] Data warehouse mini-project (star schema: fact + dimension tables)

### 2. Tools & Ecosystem
- [ ] SQL clients (DBeaver, etc.)
- [ ] Version control (Git)
- [ ] Documentation tools
- [ ] Testing frameworks
- [ ] Monitoring tools
- [ ] Cloud-managed MySQL: AWS RDS & Aurora, Google Cloud SQL, Azure Database for MySQL
- [ ] Percona Toolkit, ProxySQL
- [ ] Schema migration tools: Flyway, Liquibase

### 3. Interview Preparation
- [ ] Common SQL problems
- [ ] Performance optimization
- [ ] System design questions
- [ ] Code review practices
- [ ] Best practices discussion
- [ ] Oracle MySQL certification track (Database Administrator / Developer) — optional, but a useful anchor if you want a formal credential

---

## Practical Tips for Success
1. Practice regularly with real datasets
2. Participate in online challenges (HackerRank, LeetCode)
3. Contribute to open-source projects
4. Build personal projects
5. Join SQL communities
6. Read technical blogs
7. Attend workshops/webinars
8. Read `EXPLAIN` output line by line before touching a query — most bad queries diagnose themselves
9. Benchmark against a synthetic dataset of 1M+ rows — index behavior at 100 rows and 1M rows is not the same conversation

## Job-Ready Indicators
- [ ] Can write complex queries efficiently
- [ ] Understands performance implications
- [ ] Can design normalized databases
- [ ] Knows when to use different SQL features
- [ ] Can explain and justify design decisions
- [ ] Has a portfolio of practical projects
- [ ] Can handle technical interviews
- [ ] Understands business context
- [ ] Can justify a storage engine and replication topology for a given workload
- [ ] Can bridge SQL results into a Python/pandas analysis pipeline