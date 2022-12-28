USE MEVS;

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
/* SELECT if Member is Admin  */

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
/* Select all Reservations */

DROP PROC IF EXISTS sp_SelectAllReservations;
GO
CREATE PROC sp_SelectAllReservations
AS
SELECT 

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