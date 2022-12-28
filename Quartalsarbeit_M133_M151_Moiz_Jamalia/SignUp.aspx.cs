using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class SignUp : System.Web.UI.Page
    {

        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("sp_InsertMember", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@lastName", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@firstName", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@Handy", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.NVarChar, 255));

                cmd.Parameters["@lastName"].Value = String.Concat((tbLastName.Text).Where(c => !Char.IsWhiteSpace(c)));
                cmd.Parameters["@firstName"].Value = String.Concat((tbFirstName.Text).Where(c => !Char.IsWhiteSpace(c)));
                cmd.Parameters["@eMail"].Value = String.Concat((tbEmail.Text).Where(c => !Char.IsWhiteSpace(c)));
                cmd.Parameters["@Handy"].Value = tbMobileNumber.Text;
                cmd.Parameters["@Password"].Value = GetHashString(tbPassword.Text);

                
                int insert = cmd.ExecuteNonQuery();

                if (insert < 0) duplicateEmailVal.IsValid = false;
                else 
                {
                    lbMessage.Text = "Your Registration Request has been saved. Please wait until your request is accepted by an administrator. This may take some time. We thank you for your patience.";
                    tbFirstName.Text = String.Empty;
                    tbLastName.Text = String.Empty;
                    tbEmail.Text = String.Empty;
                    tbMobileNumber.Text = String.Empty;
                    tbPassword.Text = String.Empty;
                    tbConfirmPassword.Text = String.Empty;
                }
                
                con.Close();
            }
        }

        protected void BtnLogIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
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