using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class AddRailwayCompany : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
            if (Session["isAdmin"].ToString() == "False") Response.Redirect("~/TrainComponentOverview.aspx");
        }
    }
}