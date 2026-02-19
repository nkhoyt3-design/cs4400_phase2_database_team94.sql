-- CS4400: Introduction to Database Systems (Spring 2026)
-- Phase II A: Create Table Statements [v0] [February 9th, 2026]

-- Team __
-- Nicholas Hoyt (nhoyt6)
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Team Member Name (GT username)

-- Directions:
-- Please follow all instructions for Phase II A as listed in the instructions document.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from a SQL Dump file.
-- This file must run without error for credit.

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'media_streaming_service';
drop database if exists media_streaming_service;
create database if not exists media_streaming_service;
use media_streaming_service;

-- Define the database structures
/* You must enter your tables definitions (with primary, unique, and foreign key declarations,
data types, and check constraints) here.  You may sequence them in any order that 
works for you (and runs successfully). */

CREATE TABLE User(
  AccountID VARCHAR(64) NOT NULL, 
  Name VARCHAR(64) NOT NULL, 
  Bdate DATE NOT NULL, 
  Email VARCHAR(64) NOT NULL,
  PRIMARY KEY (AccountID)
);

CREATE TABLE Listener(
  AccountID VARCHAR(64) NOT NULL,
  Username VARCHAR(64) NOT NULL,
  ContentID VARCHAR(64),
  SubscriptionID VARCHAR(64),
  Timestamp DATETIME,
  PRIMARY KEY (Username),
  FOREIGN KEY (AccountID) REFERENCES User(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Creator(
  AccountID VARCHAR(64) NOT NULL,
  Stage_Name VARCHAR(64),
  Biography VARCHAR(64),
  Pinned_ContentID VARCHAR(64),
  PRIMARY KEY (AccountID),
  FOREIGN KEY (AccountID) REFERENCES UserTable(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (Pinnned_ContentID) REFERENCES Content(ContentID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Socials(
  AccountID VARCHAR(64) NOT NULL,
  Handle VARCHAR(64) NOT NULL,
  Platform VARCHAR(64) NOT NULL,
  PRIMARY KEY (Handle, Platform)
);

CREATE TABLE Subsription(
  SubscriptionID VARCHAR(64) NOT NULL,
  Start_Date DATE NOT NULL,
  End_Date DATE NOT NULL,
  Cost DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (SubscriptionID)
);

-- ADD Individual

-- ADD Family

CREATE TABLE Content(
  ContentID VARCHAR(64) NOT NULL,
  Title VARCHAR(64) NOT NULL,
  Release_Date DATE NOT NULL,
  Maturity VARCHAR(64) NOT NULL,
  Length INT NOT NULL,
  Language VARCHAR(64) NOT NULL,
  PRIMARY KEY (ContentID)
);

-- ADD Song

-- ADD Genres