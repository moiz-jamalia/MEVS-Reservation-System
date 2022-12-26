using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        private bool isEmailValid(String email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch 
            { 
                return false;
            }
        }

        protected void Email_Validation(object source, ServerValidateEventArgs args)
        {
            String mail = args.Value.ToString();
            args.IsValid = args != null && isEmailValid(mail) && !String.IsNullOrEmpty(mail) && (mail != "");
        }

        protected void BtnSignUp_Click(object sender, EventArgs e) 
        {
            if (Page.IsValid)
            {

            }
        }

        protected void BtnLogIn_Click(object sender, EventArgs e) 
        {
            Response.Redirect("~/Login.aspx");
        }

        private byte[] GetHash(string pw)
        {
            using (HashAlgorithm algorithm = SHA256.Create()) return algorithm.ComputeHash(Encoding.UTF8.GetBytes(pw));
        }

        private string getHashString(string pw)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(pw)) sb.Append(b.ToString("X2"));
            return sb.ToString();
        }
    }
}