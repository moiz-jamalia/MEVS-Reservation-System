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
                cmd = new SqlCommand("sp_SelectOwnReservations", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters["@eMail"].Value = Session["email"].ToString();
            }
            else
            {
                cmd = new SqlCommand("sp_SelectAllReservations", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
            }

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(gvReservations, dt);

            if (Session["isAdmin"].ToString() == "False") GvBindAllRes();
        }

        private void GvBindAllRes()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("sp_SelectAllReservations", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(gvAllReservations, dt);
        }

        private void CheckIfTableEmpty(GridView gv, DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                gv.DataSource = dt;
                gv.DataBind();
            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                gv.DataSource = dt;
                gv.DataBind();
                int Column = gv.Rows[0].Cells.Count;
                gv.Rows[0].Cells.Clear();
                gv.Rows[0].Cells.Add(new TableCell());
                gv.Rows[0].Cells[0].ColumnSpan = Column;
                gv.Rows[0].Cells[0].Text = "No reservations available.";
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