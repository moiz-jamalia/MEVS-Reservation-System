using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class TrainComponentOverview : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
            else if (Session["isAdmin"].ToString() == "False") gvTrainComponentsAdmins.Visible = false;
            else gvTrainComponentsMembers.Visible = false;
            if (!IsPostBack) GvTrainComponents();
        }

        private void GvTrainComponents()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_SelectAllTrainComponents", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(gvTrainComponentsAdmins, dt, "No Train Components registered.");
            CheckIfTableEmpty(gvTrainComponentsMembers, dt, "No Train Components registered.");
        }

        private void CheckIfTableEmpty(GridView gv, DataTable dt, string msg)
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
                int Columns = gv.Rows[0].Cells.Count;
                gv.Rows[0].Cells.Clear();
                gv.Rows[0].Cells.Add(new TableCell());
                gv.Rows[0].Cells[0].ColumnSpan = Columns;
                gv.Rows[0].Cells[0].Text = msg;
            }
        }

        protected void GvTrainComponents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }


        protected void GvTrainComponents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GvTrainComponents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTrainComponentsAdmins.PageIndex = e.NewPageIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrainComponentsAdmins.EditIndex = -1;
            GvTrainComponents();
        }

        protected void GvTrainComponents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrainComponentsAdmins.EditIndex = e.NewEditIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponentsMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void GvTrainComponentsMembers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void GvTrainComponentsMembers_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
    }
}