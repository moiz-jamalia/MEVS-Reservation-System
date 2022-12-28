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
IF NOT EXISTS(SELECT * FROM tbl_Mitglied WHERE eMail = @eMail)
INSERT INTO tbl_Mitglied (FK_Status, Name, Vorname, eMail, Handy, Passwort, IsAdmin, Bemerkung)
VALUES ((SELECT ID FROM tbl_Status WHERE Status = '1 - Anfrage'), @lastName, @firstName, @eMail, @Handy, @Password, 0, NULL);
GO