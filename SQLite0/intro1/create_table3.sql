-- practice to demonstrate the creation of table.

-- Create BankClient table
CREATE TABLE BankClient(
    clientID INTEGER PRIMARY KEY AUTOINCREMENT,
    clientName TEXT NOT NULL,
    bankName TEXT NOT NULL,
    telephoneNumber TEXT NOT NULL UNIQUE

);


-- Create Deposit table
CREATE TABLE Deposit (
    depositID INTEGER PRIMARY KEY AUTOINCREMENT,
    clientID INTEGER NOT NULL,  -- Foreign key referencing BankClient
    depositedAmount REAL DEFAULT 0.0,
    depositedAt TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (clientID) REFERENCES BankClient(clientID)
);

-- Create Withdraw table
CREATE TABLE Withdraw (
    withdrawID INTEGER PRIMARY KEY AUTOINCREMENT,
    clientID INTEGER NOT NULL,  -- Foreign key referencing BankClient
    withdrawnAmount REAL DEFAULT 0.0,
    withdrawnAt TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (clientID) REFERENCES BankClient(clientID)
);

-- Create Balance table
CREATE TABLE Balance (
    balanceID INTEGER PRIMARY KEY AUTOINCREMENT,
    clientID INTEGER NOT NULL,  -- Foreign key referencing BankClient
    balanceAvailable REAL NOT NULL DEFAULT 0.0,
    lastUpdated TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (clientID) REFERENCES BankClient(clientID)
);
