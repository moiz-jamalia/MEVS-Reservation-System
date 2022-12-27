using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] != null)
            {
                Response.Cookies["SecureCookie"].Expires = DateTime.Now.AddDays(-1);
            }
        }

        bool IsEmailValid(String email)
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

        protected void Email_validation(object sender, ServerValidateEventArgs args)
        {
            String email = args.Value.ToString();
            args.IsValid = args != null && IsEmailValid(email) && !String.IsNullOrEmpty(email) && (email != "");
        }

        protected void BtnLogIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

            }
            else
            {
                lbInvalidLogin.Text = "The login data entered is incorrect.";
            }
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SignUp.aspx");
        }
    }
}