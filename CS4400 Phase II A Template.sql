-- CS4400: Introduction to Database Systems (Spring 2026)
-- Phase II A: Create Table Statements [v0] [February 9th, 2026]

-- Team __
-- Nicholas Hoyt (nhoyt6)
-- John Neubauer (jneubauer3)
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
  AccountID VARCHAR(50) NOT NULL, 
  Name VARCHAR(100) NOT NULL, 
  Bdate DATE NOT NULL, 
  Email VARCHAR(100) NOT NULL,
  PRIMARY KEY (AccountID)
);

CREATE TABLE Listener(
  AccountID VARCHAR(50) NOT NULL,
  Username VARCHAR(50) NOT NULL,
  ContentID VARCHAR(100),
  SubscriptionID VARCHAR(100),
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
  AccountID VARCHAR(50) NOT NULL,
  Stage_Name VARCHAR(100),
  Biography VARCHAR(100),
  Pinned_ContentID VARCHAR(100),
  PRIMARY KEY (AccountID),
  FOREIGN KEY (AccountID) REFERENCES User(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (Pinned_ContentID) REFERENCES Content(ContentID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Socials(
  AccountID VARCHAR(50) NOT NULL,
  Handle VARCHAR(100),
  Platform VARCHAR(100),
  PRIMARY KEY (Handle, Platform),
  FOREIGN KEY (AccountID) REFERENCES Creator(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Subscription(
  SubscriptionID VARCHAR(50) NOT NULL,
  Start_Date DATE,
  End_Date DATE,
  Cost DECIMAL(10, 2),
  PRIMARY KEY (SubscriptionID)
);

CREATE TABLE Individual(
  SubscriptionID VARCHAR(50) NOT NULL,
  Tier VARCHAR(100),
  PRIMARY KEY (SubscriptionID),
  FOREIGN KEY (SubscriptionID) REFERENCES Subsription(SubscriptionID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE table Family(
  SubscriptionID VARCHAR(50) NOT NULL,
  Max_Family_Size INT NOT NULL CHECK (Max_Family_Size > 0),
  PRIMARY KEY (SubscriptionID),
  FOREIGN KEY (SubscriptionID) REFERENCES Subsription(SubscriptionID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Content(
  ContentID VARCHAR(50) NOT NULL,
  Title VARCHAR(100) NOT NULL,
  Release_Date DATE NOT NULL,
  Maturity VARCHAR(100) NOT NULL,
  Length INT NOT NULL,
  Language VARCHAR(100) NOT NULL,
  PRIMARY KEY (ContentID)
);

CREATE TABLE SONG(
  ContentID VARCHAR(50) NOT NULL,
  AlbumnName VARCHAR(100),
  AccountID VARCHAR(50) NOT NULL,
  PRIMARY KEY (ContentID),
  FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
  FOREIGN KEY (AlbumName, AccountID) REFERENCES Album(Name, AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE GENRES(
  ContentID VARCHAR(50) NOT NULL,
  Genre VARCHAR(100) NOT NULL,
  PRIMARY KEY (ContentID, Genre),
  FOREIGN KEY (ContentID) REFERENCES Song(ContentID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Podcast_Episode(
  ContentID VARCHAR(50) NOT NULL,
  Topic VARCHAR(100) NOT NULL,
  Episode_Number INT NOT NULL,
  Podcast_ID VARCHAR(50) NOT NULL,
  PRIMARY KEY (ContentID),
  FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (PodcastID) REFERENCES Podcast_Series(PodcastID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Podcast_Series(
  PodcastID VARCHAR(50) NOT NULL,
  Description VARCHAR(100) NOT NULL,
  Title VARCHAR(100) NOT NULL,
  PRIMARY KEY (PodcastID)
);

CREATE TABLE Playlist(
  PlaylistID VARCHAR(50) NOT NULL,
  Name VARCHAR(100) NOT NULL,
  AccountID VARCHAR(50) NOT NULL,
  PRIMARY KEY (PlaylistID)
  FOREIGN KEY (AccountID) REFERENCES Listener(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Album(
  Name VARCHAR(100) NOT NULL,
  AccountID VARCHAR(50) NOT NULL,
  PRIMARY KEY (Name, AccountID)
  FOREIGN KEY (AccountID) REFERENCES Creator(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Friends(
  Username1 VARCHAR(100) NOT NULL,
  Username2 VARCHAR(100) NOT NULL,
  PRIMARY KEY (Username1, Username2),
  FOREIGN KEY (Username1) REFERENCES Listener(Username)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (Username2) REFERENCES Listener(Username)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE CREATES(
  ContentID VARCHAR(50) NOT NULL,
  AccountID VARCHAR(50) NOT NULL,
  PRIMARY KEY (ContentID, AccountID),
  FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (AccountID) REFERENCES Creator(AccountID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE Makes_Up(
  PlaylistID VARCHAR(50) NOT NULL,
  ContentID VARCHAR(50) NOT NULL,
  Track_Order INT,
  PRIMARY KEY (PlaylistID, ContentId),
  FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
  FOREIGN KEY (ContentID) REFERENCES Song(ContentID)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);