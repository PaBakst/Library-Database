CREATE SCHEMA Library;

SET SEARCH_PATH = Library;

CREATE TABLE Clients (
    ClientEmail VARCHAR(320) PRIMARY KEY CHECK (ClientEmail LIKE '%@%'),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Password VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    BookID SERIAL PRIMARY KEY,
    Title TEXT NOT NULL,
    PublishedDate DATE,
    CopiesAvailable INT NOT NULL CHECK (CopiesAvailable >= 0)
);

CREATE TABLE Authors (
    AuthorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    BirthDate DATE
);

CREATE TABLE Genres (
    GenreID SERIAL PRIMARY KEY,
    GenreName VARCHAR(100) NOT NULL
);

CREATE TABLE Books_X_Authors (
    BookID INT REFERENCES Books(BookID),
    AuthorID INT REFERENCES Authors(AuthorID),
    PRIMARY KEY (BookID, AuthorID)
);


CREATE TABLE Books_X_Genres (
    BookID INT REFERENCES Books(BookID),
    GenreID INT REFERENCES Genres(GenreID),
    PRIMARY KEY (BookID, GenreID)
);

CREATE TABLE Transactions (
    BookID INT REFERENCES Books(BookID),
    ClientEmail VARCHAR(320) REFERENCES Clients(ClientEmail),
    TransactionTime DATE,
    Type VARCHAR(100) NOT NULL,
    PRIMARY KEY (BookID, ClientEmail, TransactionTime)
);

CREATE TABLE Reviews (
    BookID INT REFERENCES Books(BookID),
    ClientEmail VARCHAR(320) REFERENCES Clients(ClientEmail),
    Rating INT NOT NULL CHECK (Rating >= 0 AND Rating <= 10),
    Comment TEXT,
    PRIMARY KEY (BookID, ClientEmail)
);

CREATE TABLE ReviewsHistory (
    BookID INT REFERENCES Books(BookID),
    ClientEmail VARCHAR(320) REFERENCES Clients(ClientEmail),
    ReviewTime TIMESTAMP,
    Rating INT NOT NULL CHECK (Rating >= 0 AND Rating <= 10),
    Comment TEXT,
    PRIMARY KEY (BookID, ClientEmail, ReviewTime)
);

