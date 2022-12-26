using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class Site : System.Web.UI.MasterPage
    {
        private readonly string name = "MEVS Reservation System";
        protected void Page_Load(object sender, EventArgs e)
        {
            footer.Text = CopyRight();
            title.Text = Header.InnerText = name;
        }

        private string CopyRight()
        {
            string copyRight = "&#169 CopyRight Moiz Jamalia 2022";
            int year = DateTime.Now.Year;
            if (year != 2022) copyRight += " - " + year;
            return copyRight;
        }
    }
}