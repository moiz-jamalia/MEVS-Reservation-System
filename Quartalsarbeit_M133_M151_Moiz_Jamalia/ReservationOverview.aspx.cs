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

            if (Session["isAdmin"].ToString() == "True")
            {
                gvAllReservations.Visible = false;
                lbAllReservations.Visible = false;
                lbReservations.Text = "All Reservations";
            }
            else lbReservations.Text = "Reservations";
            
            if (!IsPostBack) GvAllReservations();
        }

        private void GvAllReservations()
        {
            DataTable dt = new DataTable();

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

            con.Open();
            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(gvReservations, dt);

            if (Session["isAdmin"].ToString() == "False") GvBindAllRes();
        }

        private void GvBindAllRes()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_SelectAllReservations", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            con.Open();
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
            GridViewRow Row = gvReservations.Rows[e.RowIndex];

            SqlCommand cmd = new SqlCommand("sp_DeleteReservation", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@trainDesignation", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@TrainDesignationID", SqlDbType.Int));

            cmd.Parameters["@FirstName"].Value = Row.Cells[1].Text;
            cmd.Parameters["@LastName"].Value = Row.Cells[2].Text;
            cmd.Parameters["@trainDesignation"].Value = Row.Cells[3].Text;
            cmd.Parameters["@TrainDesignationID"].Value = Row.Cells[0].Text;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            GvAllReservations();
        }

        protected void GvReservations_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReservations.EditIndex = e.NewEditIndex;
            GvAllReservations();
        }

        protected void GvReservations_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow Row = gvReservations.Rows[e.RowIndex];
            gvReservations.EditIndex = -1;

            SqlCommand cmd = new SqlCommand("sp_UpdateReservation", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@oldTrainDesignationID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@firstName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@lastName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@newTrainDesignation", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@newTrainComponentID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@fromDate", SqlDbType.DateTime2));
            cmd.Parameters.Add(new SqlParameter("@toDate", SqlDbType.DateTime2));
            cmd.Parameters.Add(new SqlParameter("@comment", SqlDbType.NVarChar, 255));

            cmd.Parameters["@oldTrainDesignationID"].Value = Row.Cells[0].Text;
            cmd.Parameters["@firstName"].Value = Row.Cells[2].Text;
            cmd.Parameters["@lastName"].Value = Row.Cells[1].Text;
            cmd.Parameters["@newTrainDesignation"].Value = (Row.Cells[3].Controls[0] as TextBox).Text;
            cmd.Parameters["@newTrainComponentID"].Value = (Row.FindControl("ddl_TrainComponent") as DropDownList).SelectedValue;
            cmd.Parameters["@fromDate"].Value = (Row.Cells[5].Controls[0] as TextBox).Text;
            cmd.Parameters["@toDate"].Value = (Row.Cells[6].Controls[0] as TextBox).Text;
            cmd.Parameters["@comment"].Value = (Row.Cells[7].Controls[0] as TextBox).Text;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            GvAllReservations();
        }

        protected void GvReservations_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddl = e.Row.FindControl("ddl_TrainComponent") as DropDownList;

                    DataTable dt = GetTrainComponentTable();
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Rollmaterial";
                    ddl.DataValueField = "RollmaterialID";
                    ddl.DataBind();

                    DataRowView drv = e.Row.DataItem as DataRowView;
                    ddl.SelectedValue = drv["ID"].ToString();
                }
            }
        }

        private DataTable GetTrainComponentTable()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_SelectTrainComponents", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
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