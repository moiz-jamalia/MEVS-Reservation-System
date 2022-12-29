using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class MembersOverview : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        private bool isAdmin;
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

            string eMail = Session["email"].ToString();

            if (!IsPostBack) GvBindAll();

            isAdmin = IsAdmin(eMail);
        }

        private void GvBindAll()
        {
            GvBindMembers();
            GvBindSignUps();
        }

        protected void BtnLogOut_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] != null) Response.Cookies["secureCookie"].Expires = DateTime.Now.AddDays(-1);
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
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

            CheckIfTableEmpty(GvMembers, dt, "No members registered.");
        }

        protected void GvBindSignUps()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("sp_SelectRegistrations", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(GvSignUps, dt, "There are no new registrations.");
        }

        private void CheckIfTableEmpty(GridView gv, DataTable dt, String msg)
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

        protected void GvSignUps_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GvSignUps.PageIndex = e.NewPageIndex;
            GvBindSignUps();
        }

        protected void GvSignUps_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow Row = GvSignUps.Rows[index] as GridViewRow;

            con.Open();

            SqlCommand cmd = new SqlCommand("sp_UpdateMemberStatus", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@newStatusID", SqlDbType.Int));
            cmd.Parameters["@eMail"].Value = Row.Cells[2].Text;

            if (e.CommandName == "accept") cmd.Parameters["@newStatusID"].Value = 2;
            else if (e.CommandName == "decline")
            {
                cmd = new SqlCommand("sp_DeleteMember", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters["@eMail"].Value = Row.Cells[2].Text;
            }
            else con.Close();

            cmd.ExecuteNonQuery();
            con.Close();

            GvBindAll();
        }

        protected void GvMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GvMembers.PageIndex = e.NewPageIndex;
            GvBindMembers();
        }

        protected void GvMembers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvMembers.EditIndex = -1;
            GvBindMembers();
        }

        protected void GvMembers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow Row = GvMembers.Rows[e.RowIndex] as GridViewRow;
            if (Row.Cells[3].Text != Session["email"].ToString() && !(IsAdmin(Row.Cells[3].Text)))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("sp_DeleteMember", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
                cmd.Parameters["@eMail"].Value = Row.Cells[3].Text;
                
                cmd.ExecuteNonQuery();
                con.Close();
                GvBindMembers();
            }
        }

        protected void GvMembers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvMembers.EditIndex = e.NewEditIndex;
            GvBindMembers();
        }

        protected void GvMembers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            con.Open();
            GridViewRow Row = GvMembers.Rows[e.RowIndex] as GridViewRow;

            GvMembers.EditIndex = -1;

            SqlCommand cmd = new SqlCommand("sp_UpdateMember", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@Status", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@CurrentEmail", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@Handy", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@IsAdmin", SqlDbType.Bit));
            cmd.Parameters.Add(new SqlParameter("@Comment", SqlDbType.NVarChar, 255));

            cmd.Parameters["@Status"].Value = (Row.FindControl("ddl_Status") as DropDownList).SelectedValue;
            if (isAdmin && Row.Cells[3].Text == Session["email"].ToString()) cmd.Parameters["@IsAdmin"].Value = true;
            else cmd.Parameters["@IsAdmin"].Value = (Row.Cells[0].Controls[0] as CheckBox).Checked;
            cmd.Parameters["@LastName"].Value = (Row.Cells[1].Controls[0] as TextBox).Text;
            cmd.Parameters["@FirstName"].Value = (Row.Cells[2].Controls[0] as TextBox).Text;
            cmd.Parameters["@CurrentEmail"].Value = Row.Cells[3].Text;
            cmd.Parameters["@Handy"].Value = (Row.Cells[4].Controls[0] as TextBox).Text;
            cmd.Parameters["@Comment"].Value = (Row.Cells[5].Controls[0] as TextBox).Text;
            
            cmd.ExecuteNonQuery();
            con.Close();
            GvBindAll();
        }

        private DataTable GetStatuses()
        {
            DataTable dt = new DataTable();

            con.Open();

            SqlCommand cmd = new SqlCommand("sp_SelectAllStatuses", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            dap.Fill(dt);
            con.Close();
            return dt;
        }

        protected void GvMembers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddl = e.Row.FindControl("ddl_Status") as DropDownList;

                    DataTable dt = GetStatuses();
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Status";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();
                }
            }
        }

        private bool IsAdmin(string eMail)
        {
            SqlCommand cmd = new SqlCommand("sp_SelectIsMemberAdmin", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@eMail", SqlDbType.NVarChar, 255));
            cmd.Parameters["@eMail"].Value = eMail;
           
            con.Open();
            bool IsAdmin = ((int)cmd.ExecuteScalar() >= 1);
            con.Close();
            return IsAdmin;
        }
    }
}