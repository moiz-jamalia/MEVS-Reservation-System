using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class CreateReservation : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
            if (!IsPostBack) DDLRollingStockBind();
        }

        private void DDLRollingStockBind()
        {
            DropDownList ddl = ddl_RollingStock;
            
            DataTable dt = GetRollingStockTable();
            ddl.DataSource = dt;
            ddl.DataTextField = "Rollmaterial";
            ddl.DataValueField = "RollmaterialID";
            ddl.DataBind();
        }

        private DataTable GetRollingStockTable()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("sp_SelectTrainComponents", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();
            return dt;
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ReservationOverview.aspx");
        }

        protected void BtnCreate_Click(object sender, EventArgs e)
        {
            DateTime fromDate = Convert.ToDateTime(tbFromDate.Text + " " + tbFromTime.Text);
            DateTime toDate = Convert.ToDateTime(tbToDate.Text + " " + tbToTime.Text);

            if (fromDate >= toDate) lbResError.Text = "Please enter a valid Reservation span";
            else if (toDate < DateTime.Now) lbResError.Text = "The To Date shouldn't be in the past";
            else lbResError.Text = "Reservation is valid";
        }
    }
}