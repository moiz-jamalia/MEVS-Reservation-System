USE MEVS;

/* ***************************************************************************** */
/* Database Values & Tables  */

UPDATE tbl_Status SET Status = '2 - Registriert' WHERE ID = 2;

UPDATE tbl_Mitglied SET eMail = 'marcel.weber@gbssg.ch' WHERE ID = 1; 

UPDATE tbl_Mitglied SET eMail = 'peter.koch@gmail.com' WHERE ID = 2;

UPDATE tbl_Mitglied SET Passwort = '29349D3905197DD4830220D388BA2EEEE8BE2F31D7908948EFA6F70A9DE39A6B' WHERE ID = 1;

UPDATE tbl_Mitglied SET Passwort = '3499889F3F98A32DB69C03DC488B0794713233FF63E16095E6BD06F972726A2B' WHERE ID = 2;

DROP TABLE tbl_Zug_Rollmaterial;

CREATE TABLE [MEVS].[dbo].[tbl_Zug_Rollmaterial]
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	FK_Zug INT NOT NULL,
	FK_Rollmaterial INT NOT NULL,
	FOREIGN KEY (FK_Zug) REFERENCES [MEVS].[dbo].[tbl_Zug],
	FOREIGN KEY (FK_Rollmaterial) REFERENCES [MEVS].[dbo].[tbl_Rollmaterial]
);

/* ***************************************************************************** */
/* Validate Member Login */

DROP PROC IF EXISTS sp_ValidateLogin;
GO
CREATE PROC sp_ValidateLogin
(
	@eMail NVARCHAR(255),
	@Password NVARCHAR(255)
)
AS
SELECT COUNT(ID) FROM tbl_Mitglied
WHERE eMail = @eMail
AND Passwort = @Password;
GO

/* ***************************************************************************** */
/* Get Member status as text */

DROP PROC IF EXISTS sp_SelectMemberStatus;
GO
CREATE PROC sp_SelectMemberStatus
(
	@eMail NVARCHAR(255)
)
AS
SELECT S.Status from tbl_Status AS S
JOIN tbl_Mitglied AS M ON S.ID = M.FK_Status
WHERE M.eMail = @eMail;
GO

/* ***************************************************************************** */
/* Select if Member is Admin  */

DROP PROC IF EXISTS sp_SelectIsMemberAdmin;
GO
CREATE PROC sp_SelectIsMemberAdmin
(
	@eMail NVARCHAR(255)
)
AS
SELECT COUNT(IsAdmin) FROM tbl_Mitglied
WHERE eMail = @eMail
AND IsAdmin = 1;
GO

/* ***************************************************************************** */
/* Insert new Member */

DROP PROC IF EXISTS sp_InsertMember;
GO
CREATE PROC sp_InsertMember
(
	@lastName NVARCHAR(255),
	@firstName NVARCHAR(255),
	@eMail NVARCHAR(255),
	@Handy NVARCHAR(255),
	@Password NVARCHAR(255)
)
AS
IF NOT EXISTS (SELECT * FROM tbl_Mitglied WHERE eMail = @eMail)
INSERT INTO tbl_Mitglied (FK_Status, Name, Vorname, eMail, Handy, Passwort, IsAdmin, Bemerkung)
VALUES ((SELECT ID FROM tbl_Status WHERE Status = '1 - Anfrage'), @lastName, @firstName, @eMail, @Handy, @Password, 0, NULL);
GO

/* ***************************************************************************** */
/* Select date of a single Member */

DROP PROC IF EXISTS sp_SelectMember;
GO
CREATE PROC sp_SelectMember
(
	@eMail NVARCHAR(255)
)
AS
SELECT M.Name, M.Vorname, M.eMail, M.Handy, M.Bemerkung, M.FK_Status AS "Stat_ID", S.Status, M.IsAdmin FROM tbl_Mitglied AS M
JOIN tbl_Status AS S ON M.FK_Status = S.ID
WHERE eMail = @eMail;
GO

/* ***************************************************************************** */
/* Select all memrbers which are not in the Sign Up process */

DROP PROC IF EXISTS sp_SelectMembers;
GO
CREATE PROC sp_SelectMembers
AS
SELECT M.Name, M.Vorname, M.eMail, M.Handy, M.Bemerkung, M.FK_Status AS "Stat_ID", S.Status, M.IsAdmin FROM tbl_Mitglied AS M
JOIN tbl_Status AS S ON M.FK_Status = S.ID
WHERE FK_Status != 1
ORDER BY M.ID;
GO

/* ***************************************************************************** */
/* Select all Statuses */

DROP PROC IF EXISTS sp_SelectAllStatuses;
GO
CREATE PROC sp_SelectAllStatuses
AS
SELECT ID, Status FROM tbl_Status
ORDER BY ID;
GO

/* ***************************************************************************** */
/* Update Member Status */

DROP PROC IF EXISTS sp_UpdateMemberStatus;
GO
CREATE PROC sp_UpdateMemberStatus
(
	@eMail NVARCHAR(255),
	@newStatusID INT
)
AS
UPDATE tbl_Mitglied 
SET FK_Status = @newStatusID
WHERE eMail = @eMail;
GO

/* ***************************************************************************** */
/* Delete Member */

DROP PROC IF EXISTS sp_DeleteMember;
GO
CREATE PROC sp_DeleteMember
(
	@eMail NVARCHAR(255)
)
AS
DECLARE @DeletedMemberID AS INT;
SELECT @DeletedMemberID = ID FROM tbl_Mitglied WHERE eMail = @eMail;

DELETE tbl_Zug_Rollmaterial
FROM tbl_Zug_Rollmaterial AS ZR 
JOIN tbl_zug AS Z 
ON ZR.FK_Zug = Z.ID
WHERE Z.FK_Mitglied = @DeletedMemberID;

UPDATE tbl_Rollmaterial SET Fk_Mitglied = NULL WHERE Fk_Mitglied = @DeletedMemberID;

UPDATE tbl_Rollmaterial SET Bemerkung = NULL WHERE Fk_Mitglied = @DeletedMemberID;

DELETE FROM tbl_Zug WHERE FK_Mitglied = @DeletedMemberID;

DELETE FROM tbl_Mitglied WHERE eMail = @eMail;
GO

/* ***************************************************************************** */
/* Update a single Member */

DROP PROC IF EXISTS sp_UpdateMember;
GO
CREATE PROC sp_UpdateMember
(
	@Status INT,
	@LastName NVARCHAR(255),
	@FirstName NVARCHAR(255),
	@CurrentEmail NVARCHAR(255),
	@Handy NVARCHAR(255),
	@IsAdmin BIT,
	@Comment NVARCHAR(255)
)
AS
UPDATE tbl_Mitglied SET Name = @LastName, Vorname = @FirstName, Handy = @Handy, IsAdmin = @IsAdmin, Bemerkung = @Comment
WHERE eMail = @CurrentEmail;

IF(@Status != 0)
UPDATE tbl_Mitglied SET FK_Status = @Status
WHERE eMail = @CurrentEmail;
GO

/* ***************************************************************************** */
/* Select all registrations */

DROP PROC IF EXISTS sp_SelectRegistrations;
GO
CREATE PROC sp_SelectRegistrations
AS
SELECT Name, Vorname, eMail, Handy FROM tbl_Mitglied
WHERE FK_Status = 1
ORDER BY ID;
GO

/* ***************************************************************************** */
/* Select all Reservations */

DROP PROC IF EXISTS sp_SelectAllReservations;
GO
CREATE PROC sp_SelectAllReservations
AS
SELECT
Z.ID,
M.Name,
M.Vorname,
Z.Bezeichnung AS "Zugbezeichnung",
R.ID,
CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial",
(FORMAT (Z.ReservationVon, 'dd.MM.yy HH:mm')) AS 'Von',
(FORMAT (Z.ReservationBis, 'dd.MM.yy HH:mm')) AS 'Bis',
R.Bemerkung
FROM tbl_Mitglied AS M
JOIN tbl_Zug AS Z ON Z.FK_Mitglied = M.ID
LEFT JOIN tbl_Zug_Rollmaterial AS ZR ON Z.ID = ZR.FK_Zug 
LEFT JOIN tbl_Rollmaterial AS R ON ZR.FK_Rollmaterial = R.ID
ORDER BY M.ID;
GO

/* ***************************************************************************** */
/* Select Own Reservations */

DROP PROC IF EXISTS sp_SelectOwnReservations;
GO
CREATE PROC sp_SelectOwnReservations
(
	@eMail NVARCHAR(255)
)
AS
SELECT 
Z.ID,
M.Name,
M.Vorname,
Z.Bezeichnung AS "Zugbezeichnung",
R.ID,
CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial",
(FORMAT (Z.ReservationVon, 'dd.MM.yy HH:mm')) AS 'Von',
(FORMAT (Z.ReservationBis, 'dd.MM.yy HH:mm')) AS 'Bis',
R.Bemerkung
FROM tbl_Mitglied AS M
JOIN tbl_Zug AS Z ON Z.FK_Mitglied = M.ID
LEFT JOIN tbl_Zug_Rollmaterial AS ZR ON Z.ID = ZR.FK_Zug 
LEFT JOIN tbl_Rollmaterial AS R ON ZR.FK_Rollmaterial = R.ID
WHERE M.eMail = @eMail
ORDER BY M.ID;
GO

/* ***************************************************************************** */
/* create Reservation */

DROP PROC IF EXISTS sp_InsertReservation;
GO
CREATE PROC sp_InsertReservation
(
	@eMail NVARCHAR(255),
	@fromDate DATETIME2,
	@toDate DATETIME2,
	@comment NVARCHAR(255),
	@trainComponentID INT,
	@trainDesignation NVARCHAR(255)
)
AS
SET DATEFORMAT dmy;
DECLARE @memberID AS INT;
SELECT @memberID = M.ID FROM tbl_Mitglied AS M WHERE M.eMail = @eMail;

INSERT INTO tbl_Zug (Bezeichnung, FK_Mitglied, ReservationBis, ReservationVon) VALUES (@trainDesignation, @memberID, @toDate, @fromDate);

UPDATE tbl_Rollmaterial SET Fk_Mitglied = @memberID WHERE ID = @trainComponentID;

UPDATE tbl_Rollmaterial SET Bemerkung = @comment WHERE ID = @trainComponentID;

INSERT INTO tbl_Zug_Rollmaterial (FK_Zug, FK_Rollmaterial) VALUES ((SELECT ID FROM tbl_Zug WHERE Bezeichnung = @trainDesignation), (SELECT ID FROM tbl_Rollmaterial WHERE ID = @trainComponentID));
GO

/* ***************************************************************************** */
/* Delete Reservation */

DROP PROC IF EXISTS sp_DeleteReservation;
GO
CREATE PROC sp_DeleteReservation
(
	@FirstName NVARCHAR(255),
	@LastName NVARCHAR(255),
	@trainDesignation NVARCHAR(255),
	@TrainDesignationID INT
)
AS
DECLARE @memberID AS INT
SELECT @memberID = M.ID FROM tbl_Mitglied AS M WHERE M.Vorname = @FirstName AND M.Name = @LastName;

DECLARE @trainComponentID AS INT
SELECT @trainComponentID = ZR.FK_Rollmaterial FROM tbl_Zug_Rollmaterial AS ZR WHERE ZR.FK_Zug = @TrainDesignationID;

DELETE FROM tbl_Zug_Rollmaterial WHERE FK_Zug = (SELECT ID FROM tbl_Zug WHERE Bezeichnung = @trainDesignation) AND FK_Rollmaterial = (SELECT ID FROM tbl_Rollmaterial WHERE ID = @trainComponentID);

DELETE FROM tbl_Zug WHERE ID = @TrainDesignationID;

UPDATE tbl_Rollmaterial SET Fk_Mitglied = NULL WHERE ID = @trainComponentID;

UPDATE tbl_Rollmaterial SET Bemerkung = NULL WHERE ID = @trainComponentID;
GO

/* ***************************************************************************** */
/* Update Reservation */

DROP PROC IF EXISTS sp_UpdateReservation;
GO
CREATE PROC sp_UpdateReservation
(
	@oldTrainDesignationID INT,
	@firstName NVARCHAR(255),
	@lastName NVARCHAR(255),
	@newTrainDesignation NVARCHAR(255),
	@newTrainComponentID INT,
	@fromDate DATETIME2,
	@toDate DATETIME2,
	@comment NVARCHAR(255)
)
AS
DECLARE @memberID AS INT;
SELECT @memberID = M.ID FROM tbl_Mitglied AS M WHERE M.Vorname = @firstName AND M.Name = @lastName;

DECLARE @oldTrainDesignation AS NVARCHAR(255);
SELECT @oldTrainDesignation = Z.Bezeichnung FROM tbl_Zug AS Z WHERE ID = @oldTrainDesignationID;

DECLARE @oldTrainComponentID AS INT;
SELECT @oldTrainComponentID = ZR.FK_Rollmaterial FROM tbl_Zug_Rollmaterial AS ZR WHERE ZR.FK_Zug = @oldTrainDesignationID;

UPDATE tbl_Rollmaterial SET Fk_Mitglied = @memberID, Bemerkung = @comment WHERE ID = @newTrainComponentID;

UPDATE tbl_Rollmaterial SET Fk_Mitglied = NULL, Bemerkung = NULL WHERE ID = @oldTrainComponentID;

UPDATE tbl_Zug_Rollmaterial SET FK_Rollmaterial = @newTrainComponentID;

UPDATE tbl_Zug SET Bezeichnung = @newTrainDesignation, ReservationVon = @fromDate, ReservationBis = @toDate WHERE FK_Mitglied = @memberID AND Bezeichnung = @oldTrainDesignation;
GO

/* ***************************************************************************** */
/* Select whole Train Component table */

DROP PROC IF EXISTS sp_SelectAllTrainComponents;
GO
CREATE PROC sp_SelectAllTrainComponents
AS
SELECT 
R.ID,
M.Name AS "FirstName",
M.Vorname AS "LastName",
H.Bezeichnung AS "Manufacturer",
CAST(V.Nachname AS NVARCHAR(255)) + ' ' + CAST(V.Vorname AS NVARCHAR(255)) AS "Seller",
B.Abkürzung AS "RailwayCompany",
T.Bezeichnung AS "Model",
R.Typenbezeichnung,
R.Nr,
R.Beschreibung,
R.Kaufpreis,
R.ImBesitz,
R.Occasion,
R.Veröffentlichung,
R.ArtNr,
R.SetNr,
R.Farbe,
R.Bemerkung,
R.FreigabeFuerZugbildung FROM tbl_Rollmaterial AS R
LEFT JOIN tbl_Mitglied AS M ON R.Fk_Mitglied = M.ID
LEFT JOIN tbl_Hersteller AS H ON R.FK_Hersteller = H.ID
LEFT JOIN tbl_Verkäufer AS V ON R.FK_Verkaeufer = V.ID
LEFT JOIN tbl_Bahngesellschaft AS B ON R.FK_Bahngesellschaft = B.ID
LEFT JOIN tbl_Typ AS T ON R.FK_Typ = T.ID
ORDER BY R.ID;
GO

/* ***************************************************************************** */
/* Select All available And from Member reserved Train Components */

DROP PROC IF EXISTS sp_SelectTrainComponents;
GO
CREATE PROC sp_SelectTrainComponents
AS
SELECT 
R.ID AS "RollmaterialID", 
CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial"
FROM tbl_Rollmaterial as R
WHERE R.FreigabeFuerZugbildung = 1 AND R.Fk_Mitglied IS NULL
ORDER BY R.ID;
GO

/* ***************************************************************************** */
/* Insert Train Component */

DROP PROC IF EXISTS sp_InsertTrainComponent;
GO
CREATE PROC sp_InsertTrainComponent
(
	@FKMitglied INT, 
	@FKHersteller INT, 
	@FKVerkaeufer INT,
	@FKBahngesellschaft INT,
	@FKTyp INT,
	@typenbezeichnung NVARCHAR(255),
	@rollNr NVARCHAR(255),
	@beschreibung NVARCHAR(255),
	@kaufpreis MONEY,
	@imBesitz NVARCHAR(255),
	@occasion BIT,
	@veröffentlichung NVARCHAR(255),
	@artNr NVARCHAR(255),
	@setNr NVARCHAR(255),
	@farbe NVARCHAR(255),
	@bemerkung NVARCHAR(255),
	@freigabe BIT
)
AS
INSERT INTO tbl_Rollmaterial (Fk_Mitglied, FK_Hersteller, FK_Verkaeufer, FK_Bahngesellschaft, FK_Typ,
Typenbezeichnung, Nr, Beschreibung, Kaufpreis, ImBesitz, Occasion, Veröffentlichung, ArtNr, SetNr, Farbe, Bemerkung, FreigabeFuerZugbildung)
VALUES 
(
@FKMitglied,
@FKHersteller,
@FKVerkaeufer,
@FKBahngesellschaft,
@FKTyp,
@typenbezeichnung,
@rollNr,
@beschreibung,
@kaufpreis,
@imBesitz,
@occasion,
@veröffentlichung,
@artNr,
@setNr,
@farbe,
@bemerkung,
@freigabe
);
GO

/* ***************************************************************************** */
/* Check if Reservation overlaps */

DROP PROC IF EXISTS sp_SelectOverlapsReservation;
GO
CREATE PROC sp_SelectOverlapsReservation
(
	@trainDesignationID INT,
	@fromDate DATETIME2,
	@toDate DATETIME2
)
AS
SET DATEFORMAT dmy;
SELECT COUNT(ID) FROM tbl_Zug WHERE (ID = @trainDesignationID) AND (ReservationVon < @toDate) AND (ReservationBis > @fromDate);
GO