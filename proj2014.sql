CREATE TABLE User (
	Email VARCHAR(255),
	Name VARCHAR(255),
	Password VARCHAR(255),
	Up/DownVotes int,
	PRIMARY KEY (Email)
);

CREATE TABLE Message (
	FromUser VARCHAR(255),
	ToUser VARCHAR(255),
	Date date,
	Time time,
	Content VARCHAR(255),
	FOREIGN KEY (FromUser) REFERENCES User(Email)
);

CREATE TABLE Topic (
	Name VARCHAR(255),
	PRIMARY KEY (Name)
);

CREATE TABLE Thread (
	Title VARCHAR(255),
	TopicName VARCHAR(255),
	Time time,
	Date date,
	Up/DownVotes int,
	UserName VARCHAR(255),
	PRIMARY KEY (Title),
	FOREIGN KEY (TopicName) REFERENCES Topic(Name)
);

CREATE TABLE Post (
	Title VARCHAR(255),
	ThreadName VARCHAR(255),
	Time time,
	Date date,
	Up/DownVotes int,
	UserName VARCHAR(255),
	PRIMARY KEY (Title),
	FOREIGN KEY (ThreadName) REFERENCES Thread(Title)
);

CREATE TABLE Admin (
	AdminId int,
	UserEmail VARCHAR(255),
	PRIMARY KEY (AdminId),
	FOREIGN KEY (UserEmail) REFERENCES User(Email)
);

CREATE TABLE Moderator (
	ModeratorId int,
	UserEmail VARCHAR(255),
	PRIMARY KEY (ModeratorId),
	FOREIGN KEY (UserEmail) REFERENCES User(Email)
);

CREATE TABLE Sales (
	SalesId int,
	UserEmail VARCHAR(255),
	CompanyName VARCHAR(255),
	PRIMARY KEY (SalesId),
	FOREIGN KEY (CompanyName) REFERENCES Company(Name),
	FOREIGN KEY (UserEmail) REFERENCES User(Email)
);

CREATE TABLE Casual (
	CasualId int,
	UserEmail VARCHAR(255),
	PRIMARY KEY (CasualId),
	FOREIGN KEY (UserEmail) REFERENCES User(Email)
);

CREATE TABLE Doctor(
	DoctorId int,
	DoctorVerification bit(1),
	UserEmail VARCHAR(255),
	PRIMARY KEY (DoctorId),
	FOREIGN KEY (UserEmail) REFERENCES Email(Email)
);

CREATE TABLE Customer (
	CreditCardNumber int,
	Address VARCHAR(255),
	PurchasePoints int,
	UserType VARCHAR(255),
	UserId int,
	PRIMARY KEY (CreditCardNumber)
);

CREATE TABLE Company (
	Name VARCHAR(255),
	Address VARCHAR(255),
	PRIMARY KEY (Name)
);

CREATE TABLE Products (Name VARCHAR(255)
	Price float,
	PRIMARY KEY (Name)
);

CREATE TABLE Transaction (
	OrderId int,
	Total float,
	Date date,
	Time time,
	CustomerCard int,
	ProductName VARCHAR(255),
	PRIMARY KEY (OrderId),
	FOREIGN KEY (CustomerCard) REFERENCES Customer(CreditCardNumber),
	FOREIGN KEY (ProductName) REFERENCES Products(Name)
);

CREATE TABLE Advertisement (
	AdvertisementId int,
	Approved bit(1),
	Expiration date,
	Date date,
	ProductName VARCHAR(255),
	PRIMARY KEY (AdvertisementId),
	FOREIGN KEY (Productname) REFERENCES Products(Name)
);

CREATE TABLE Displays(
	Keyword VARCHAR(255),
	AdvertisementId int,
	UserEmail VARCHAR(),
	PRIMARY KEY (Keyword),
	FOREIGN KEY (UserEmail) REFERENCES User(Email),
	FOREIGN KEY (AdvertisementId) REFERENCES Advertisement(AdvertisementId)
);
