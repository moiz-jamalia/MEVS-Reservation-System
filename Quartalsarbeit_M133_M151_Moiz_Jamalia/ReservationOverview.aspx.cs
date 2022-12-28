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
    public partial class Reservation : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");

            if (!IsPostBack) GvAllReservations();
        }

        private void GvAllReservations()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd;

            if (Session["isAdmin"].ToString() == "False")
            {
                cmd = new SqlCommand("", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters["@eMail"].Value = Session["email"].ToString();
            }
            else
            {
                cmd = new SqlCommand("", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
            }

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(dt);

            if (Session["isAdmin"].ToString() == "False") GvBindAllRes();
        }

        private void GvBindAllRes()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(dt);
        }

        private void CheckIfTableEmpty(DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                gvReservations.DataSource = dt;
                gvReservations.DataBind();
            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                gvReservations.DataSource = dt;
                gvReservations.DataBind();
                int Column = gvReservations.Rows[0].Cells.Count;
                gvReservations.Rows[0].Cells.Clear();
                gvReservations.Rows[0].Cells.Add(new TableCell());
                gvReservations.Rows[0].Cells[0].ColumnSpan = Column;
                gvReservations.Rows[0].Cells[0].Text = "No reservations available.";
            }
        }

        protected void GvReservations_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvReservations.PageIndex = e.NewPageIndex;
            GvAllReservations();
        }

        protected void GvReservations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReservations.EditIndex = -1;
            GvAllReservations();
        }

        protected void GvReservations_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GvReservations_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReservations.EditIndex = e.NewEditIndex;
            GvAllReservations();
        }

        protected void GvReservations_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GvReservations_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        private DataTable GetTable()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();
            return dt;
        }

        protected void BtnCreateReservation_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CreateReservation.aspx");
        }
    }
}