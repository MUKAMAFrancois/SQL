## Lecture: Introduction to PostgreSQL and PostgreSQL Architecture

### 1. Introduction to PostgreSQL

#### What is PostgreSQL?

PostgreSQL, often referred to as Postgres, is a powerful, open-source object-relational database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads. Originally developed at the University of California, Berkeley, PostgreSQL has a strong reputation for its reliability, feature robustness, and performance.

#### History and Features

- **History:**
  - **1986:** The project started as POSTGRES at the University of California, Berkeley.
  - **1996:** Renamed to PostgreSQL to reflect its support for SQL.
  - **1997:** The first open-source version was released.
  - **Present:** Continuous development with contributions from a global community.

- **Features:**
  - **ACID Compliance:** Ensures reliable transactions.
  - **Extensibility:** Support for custom functions, data types, operators, and languages.
  - **Advanced Data Types:** Support for JSON, arrays, hstore, and more.
  - **Full-Text Search:** Built-in capabilities for full-text search.
  - **Concurrency:** Uses MVCC (Multi-Version Concurrency Control) for high concurrency.
  - **Replication and Recovery:** Offers streaming replication and point-in-time recovery.
  - **Internationalization:** Full support for different character sets, encodings, and locale settings.

#### Installation and Setup

##### Installation on Different Operating Systems

- **Windows:**
  - Download the installer from the [PostgreSQL website](https://www.postgresql.org/download/windows/).
  - Run the installer and follow the setup wizard.
  
- **macOS:**
  - Use Homebrew: `brew install postgresql`
  - Alternatively, download the installer from the [PostgreSQL website](https://www.postgresql.org/download/macosx/).
  
- **Linux:**
  - On Debian-based systems (e.g., Ubuntu): `sudo apt-get install postgresql`
  - On Red Hat-based systems (e.g., CentOS, Fedora): `sudo yum install postgresql-server`

##### Setting Up PostgreSQL Server

- **Initialization:**
  - On Linux: `sudo service postgresql initdb`
  - On macOS: `initdb /usr/local/var/postgres`

- **Starting the Server:**
  - On Linux: `sudo service postgresql start`
  - On macOS: `pg_ctl -D /usr/local/var/postgres start`
  - On Windows: Use the "Start PostgreSQL" option in the Start menu or run `pg_ctl -D "C:\Program Files\PostgreSQL\13\data" start` in the command prompt.

##### Basic Configuration

- **Configuration Files:**
  - `postgresql.conf`: Main configuration file for database settings.
  - `pg_hba.conf`: Client authentication configuration file.
  
- **Common Settings:**
  - `listen_addresses`: Specifies which IP addresses the server should listen on.
  - `port`: The port the server listens on (default is 5432).
  - `max_connections`: Maximum number of concurrent connections.
  - `shared_buffers`: Amount of memory the database server uses for shared memory buffers.

#### Basic Commands

##### Starting and Stopping the Server

- **Start the Server:**
  - `pg_ctl start -D /path/to/data_directory`
  
- **Stop the Server:**
  - `pg_ctl stop -D /path/to/data_directory`
  
- **Restart the Server:**
  - `pg_ctl restart -D /path/to/data_directory`

##### Connecting to the Server Using `psql`

- **Open `psql`:**
  - `psql -U username -d database_name -h hostname -p port`
  
- **Common `psql` Commands:**
  - `\l`: List databases.
  - `\c database_name`: Connect to a database.
  - `\dt`: List tables.
  - `\d table_name`: Describe a table.
  - `\q`: Quit `psql`.

### 2. PostgreSQL Architecture

#### Overview of PostgreSQL Architecture

PostgreSQL's architecture is designed to support high concurrency and robust data integrity. Key components include:

- **PostgreSQL Server Process:** Manages database files, accepts connections, and performs database operations.
- **Client Applications:** Connect to the server to perform queries and transactions (e.g., `psql`).

#### PostgreSQL Processes

- **Postmaster Process:** The main daemon process that manages database server operations.
- **Backend Processes:** Handle individual client connections.
- **WAL Writer Process:** Writes the Write-Ahead Log (WAL) records to disk.
- **Background Writer Process:** Manages the writing of dirty shared buffers to disk.
- **Autovacuum Process:** Automatically vacuums the database to reclaim storage and improve performance.
- **Checkpointer Process:** Ensures that all changes to the database are properly written to disk at regular intervals.

#### Memory Architecture

- **Shared Memory:** Used by all server processes for caching data and managing transaction logs.
- **Private Memory:** Allocated per backend process for query execution and temporary data storage.

#### Storage Architecture

- **Tablespaces:** Logical storage units within a database cluster. Default tablespace is `pg_default`.
- **Data Files:** Store actual table and index data. Organized in a directory structure under the data directory.
- **WAL Files:** Store transaction logs for data recovery.

#### System Catalogs

- **System Tables:** Store metadata about the database objects (tables, indexes, columns, etc.).
  - `pg_database`: Information about databases.
  - `pg_tables`: Information about tables.
  - `pg_indexes`: Information about indexes.
  - `pg_roles`: Information about user roles and permissions.
