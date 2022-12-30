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
SELECT Status from tbl_Status 
JOIN tbl_Mitglied ON tbl_Status.ID = FK_Status
WHERE tbl_Mitglied.eMail = @eMail;
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
/* Select All Train Components */
/*
DROP PROC IF EXISTS sp_SelectTrainComponents;
GO
CREATE PROC sp_SelectTrainComponents
*/

/* ***************************************************************************** */
/* Select date of a single Member */

DROP PROC IF EXISTS sp_SelectMember;
GO
CREATE PROC sp_SelectMember
(
	@eMail NVARCHAR(255)
)
AS
SELECT Name, Vorname, eMail, Handy, tbl_Mitglied.Bemerkung, FK_Status AS "Stat_ID", Status, IsAdmin FROM tbl_Mitglied
JOIN tbl_Status ON FK_Status = tbl_Status.ID
WHERE eMail = @eMail;
GO

/* ***************************************************************************** */
/* Select all memrbers which are not in the Sign Up process */

DROP PROC IF EXISTS sp_SelectMembers;
GO
CREATE PROC sp_SelectMembers
AS
SELECT Name, Vorname, eMail, Handy, tbl_Mitglied.Bemerkung, FK_Status AS "Stat_ID", Status, IsAdmin FROM tbl_Mitglied
JOIN tbl_Status ON FK_Status = tbl_Status.ID
WHERE FK_Status != 1
ORDER BY tbl_Mitglied.ID;
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
/* Delete Member Status */

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
SELECT Z.ID, M.Name, M.Vorname, Z.Bezeichnung AS "Zugbezeichnung", CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial", (FORMAT (Z.ReservationVon, 'dd.MM.yy HH:mm')) AS 'Von', (FORMAT (Z.ReservationBis, 'dd.MM.yy HH:mm')) AS 'Bis' 
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
SELECT Z.ID, M.Name, M.Vorname, Z.Bezeichnung AS "Zugbezeichnung", CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial", (FORMAT (Z.ReservationVon, 'dd.MM.yy HH:mm')) AS 'Von', (FORMAT (Z.ReservationBis, 'dd.MM.yy HH:mm')) AS 'Bis' 
FROM tbl_Mitglied AS M
JOIN tbl_Zug AS Z ON Z.FK_Mitglied = M.ID
LEFT JOIN tbl_Zug_Rollmaterial AS ZR ON Z.ID = ZR.FK_Zug 
LEFT JOIN tbl_Rollmaterial AS R ON ZR.FK_Rollmaterial = R.ID
WHERE M.eMail = @eMail
ORDER BY M.ID;
GO

/* ***************************************************************************** */
/* Select All Train Components */

DROP PROC IF EXISTS sp_SelectTrainComponents;
GO
CREATE PROC sp_SelectTrainComponents
AS
SELECT R.ID AS "RollmaterialID", CAST(R.Typenbezeichnung AS NVARCHAR(255)) + ' ' + CAST(R.Nr AS NVARCHAR(255)) + ' ' + CAST(R.Beschreibung AS NVARCHAR(255)) + ' ' + CAST(R.Farbe AS NVARCHAR(255)) AS "Rollmaterial"
FROM tbl_Rollmaterial as R
ORDER BY R.ID;
GO