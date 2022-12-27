USE MEVS;

/* ***************************************************************************** */
/* Validate Member Login */

DROP PROC IF EXISTS sp_ValidateLogin;
GO
CREATE PROC sp_ValidateLogin
(
		@eMail VARCHAR(50),
		@Password VARCHAR(100)
)
AS
SELECT COUNT(ID) FROM tbl_Mitglied WHERE eMail = @eMail AND Passwort = @Password;
GO

/* ***************************************************************************** */
/* Get Member status as text*/

DROP PROC IF EXISTS sp_SelectMemberStatus;
GO
CREATE PROC sp_SelectMemberStatus
(
		@eMail VARCHAR(50)
)
AS
SELECT Status from tbl_Status 
JOIN tbl_Mitglied ON tbl_Status.ID = FK_Status
WHERE tbl_Mitglied.eMail = @eMail;
GO