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

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {

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