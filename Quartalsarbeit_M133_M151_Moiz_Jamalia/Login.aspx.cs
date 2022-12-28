using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] != null) Response.Cookies["SecureCookie"].Expires = DateTime.Now.AddDays(-1);
        }

        protected void BtnLogIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if(IsLoginValid())
                {
                    switch(GetMemberStatus(tbEmail.Text))
                    {
                        case "1 - Anfrage":
                            lbInvalidLogin.Text = "Your registration request has been saved and is still being processed. This may take some time. We thank you for your patience.";
                            break;

                        case "2 - Registriert":
                            lbInvalidLogin.Text = "";
                            Session["email"] = tbEmail.Text;
                            Session["isAdmin"] = IsMemberAdmin(tbEmail.Text);

                            Response.Cookies.Add(new HttpCookie("secureCookie", GetHashString(tbEmail.Text))
                            { 
                                HttpOnly = true,
                                Secure= true,
                            });

                            Response.Redirect("~/ReservationOverview.aspx");
                            break;

                        case "3 - Inaktiv":
                            lbInvalidLogin.Text = "This Account has been suspended by an administrator or has been deleted.";
                            break;

                        default:
                            lbInvalidLogin.Text = "An error occured";
                            break;
                    }
                }
                else lbInvalidLogin.Text = "The login data entered is incorrect.";
            }
        }

        private bool IsLoginValid()
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("sp_ValidateLogin", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.VarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar, 255));
            cmd.Parameters["@eMail"].Value = tbEmail.Text;
            cmd.Parameters["@Password"].Value = GetHashString(tbPassword.Text);

            bool IsValid = (int)cmd.ExecuteScalar() >= 1;
            con.Close();
            return IsValid;
        }

        private string GetMemberStatus(string email)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_SelectMemberStatus", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.VarChar, 255));
            cmd.Parameters["@eMail"].Value = email;

            SqlDataReader reader = cmd.ExecuteReader();
            Object o = null;

            while(reader.Read()) o = reader[0].ToString(); ;
            
            con.Close();

            string status;
            if (o != null) status = o.ToString();
            else status = "error";

            return status;
        }

        private bool IsMemberAdmin(string email)
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("sp_SelectIsMemberAdmin", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.VarChar, 255));
            cmd.Parameters["@eMail"].Value = email;

            bool IsAdmin = (int)cmd.ExecuteScalar() == 1;
            con.Close();
            return IsAdmin;
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if(Page.IsPostBack) Response.Redirect("~/SignUp.aspx");
        }

        private byte[] GetHash(string input)
        {
            using (HashAlgorithm algorithm = SHA256.Create()) return algorithm.ComputeHash(Encoding.UTF8.GetBytes(input));
        }

        private string GetHashString(string input)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(input)) sb.Append(b.ToString("X2"));
            return sb.ToString();
        }
    }
}