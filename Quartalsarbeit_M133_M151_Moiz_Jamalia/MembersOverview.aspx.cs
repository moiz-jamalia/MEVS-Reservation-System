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
    public partial class MembersOverview : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");

            if (Session["isAdmin"].ToString() == "False")
            {
                lbSignUpRequests.Visible = false;
                GvSignUps.Visible = false;
                GvMembers.Columns[0].Visible = false;
                GvMembers.Columns[6].Visible = false;
                GvMembers.Columns[8].Visible = false;  
            }

            string userEmail = Session["email"].ToString();

            if (!IsPostBack) GvBindAll();
        }

        private void GvBindAll()
        {
            GvBindMembers();
            GvBindSignUps();
        }

        protected void GvBindMembers()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd;
            
            con.Open();

            if (Session["isAdmin"].ToString() == "False")
            {
                cmd = new SqlCommand("sp_SelectMember", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters["@eMail"].Value = Session["email"].ToString();
            }
            else
            {
                cmd = new SqlCommand("sp_SelectMembers", con)
                { 
                    CommandType = CommandType.StoredProcedure 
                };
            }

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0) 
            {
                GvMembers.DataSource = dt;
                GvMembers.DataBind();
            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                GvMembers.DataSource = dt;
                GvMembers.DataBind();
                int Columns = GvMembers.Rows[0].Cells.Count;
                GvMembers.Rows[0].Cells.Clear();
                GvMembers.Rows[0].Cells.Add(new TableCell());
                GvMembers.Rows[0].Cells[0].ColumnSpan = Columns;
                GvMembers.Rows[0].Cells[0].Text = "No members registered.";
            }
        }

        protected void GvBindSignUps()
        {

        }

        protected void BtnLogOut_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] != null) Response.Cookies["secureCookie"].Expires = DateTime.Now.AddDays(-1);
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void GvSignUps_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void GvSignUps_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void GvMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void GvMembers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void GvMembers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GvMembers_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GvMembers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GvMembers_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
}