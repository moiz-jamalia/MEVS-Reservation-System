using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class CreateReservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ReservationOverview.aspx");
        }

        protected void BtnCreate_Click(object sender, EventArgs e)
        {

        }
    }
}