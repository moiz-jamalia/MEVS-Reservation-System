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
            else if (Session["isAdmin"].ToString() == "False")
            {
                gvTrainComponentsAdmins.Visible = false;

                for (int Row = 0; Row < gvTrainComponentsMembers.Rows.Count; Row++)
                {
                    bool Release = gvTrainComponentsMembers.Rows[Row].Cells[18].ToString() == "False"; //if bit is 1

                    if (Release) for (int Row1 = 0; Row1 < gvTrainComponentsMembers.Rows.Count; Row1++) gvTrainComponentsMembers.Rows[Row1].Cells[18].Enabled = false;
                    else break;
                }
            }
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

                lbtest.Text = gv.Rows[1].Cells[18].Text;
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

        protected void GvTrainComponentsAdmins_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }


        protected void GvTrainComponentsAdmins_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GvTrainComponentsAdmins_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTrainComponentsAdmins.PageIndex = e.NewPageIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponentsAdmins_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrainComponentsAdmins.EditIndex = -1;
            GvTrainComponents();
        }

        protected void GvTrainComponentsAdmins_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrainComponentsAdmins.EditIndex = e.NewEditIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponentsAdmins_RowDataBound(object sender, GridViewRowEventArgs e)
        {
          
        }

        protected void GvTrainComponentsMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTrainComponentsMembers.PageIndex = e.NewPageIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponentsMembers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrainComponentsMembers.EditIndex = -1;
            GvTrainComponents();
        }

        protected void GvTrainComponentsMembers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrainComponentsMembers.EditIndex = e.NewEditIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponentsMembers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            
        }

        protected void GvTrainComponentsMembers_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
}