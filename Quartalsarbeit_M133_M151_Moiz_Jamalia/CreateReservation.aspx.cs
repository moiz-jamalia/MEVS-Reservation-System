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

            SqlCommand cmd = new SqlCommand("sp_SelectTrainComponents", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
            cmd.Parameters["@eMail"].Value = Session["email"].ToString();

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
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
            lbResError.Text = "";

            if (Page.IsValid)
            {
                try
                {
                    DateTime fromDate = Convert.ToDateTime(tbFromDate.Text + " " + tbFromTime.Text);
                    DateTime toDate = Convert.ToDateTime(tbToDate.Text + " " + tbToTime.Text);

                    if (fromDate >= toDate) lbResError.Text = "Please enter a valid time span";
                    else if (toDate < DateTime.Now) lbResError.Text = "The end date must not be in the past.";
                    else
                    {
                        int TrainComponentID = int.Parse(ddl_RollingStock.SelectedValue);
                        InsertReservation(Session["email"].ToString(), fromDate, toDate, tbComment.Text, TrainComponentID, tbCreateTrain.Text);
                        Response.Redirect("~/ReservationOverview.aspx");
                    }
                }
                catch
                {
                    lbResError.Text = "Please enter a valid time span";
                }
            }
        }

        private void InsertReservation(string EMail, DateTime FromDate, DateTime ToDate, string Comment, int TrainComponentID, string TrainDesignation)
        {
            SqlCommand cmd = new SqlCommand("sp_insertReservation", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@fromDate", SqlDbType.DateTime2));
            cmd.Parameters.Add(new SqlParameter("@toDate", SqlDbType.DateTime2));
            cmd.Parameters.Add(new SqlParameter("@comment", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@trainComponentID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@trainDesignation", SqlDbType.NVarChar, 255));

            cmd.Parameters["@eMail"].Value = EMail;
            cmd.Parameters["@fromDate"].Value = FromDate;
            cmd.Parameters["@toDate"].Value = ToDate;
            cmd.Parameters["@comment"].Value = Comment;
            cmd.Parameters["@trainComponentID"].Value = TrainComponentID;
            cmd.Parameters["@trainDesignation"].Value = TrainDesignation;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}