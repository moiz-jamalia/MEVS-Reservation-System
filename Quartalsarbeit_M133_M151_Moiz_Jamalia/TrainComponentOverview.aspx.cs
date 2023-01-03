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
                btnAddManufacturer.Visible = false;
                btnAddRailWayCompany.Visible = false;
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
            GridViewRow Row = gvTrainComponentsAdmins.Rows[e.RowIndex];

            SqlCommand cmd = new SqlCommand("sp_DeleteTrainComponent", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@trainComponentID", SqlDbType.Int));

            cmd.Parameters["@trainComponentID"].Value = Int32.Parse(Row.Cells[0].Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            GvTrainComponents();
        }


        protected void GvTrainComponentsAdmins_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow Row = gvTrainComponentsAdmins.Rows[e.RowIndex];
            gvTrainComponentsAdmins.EditIndex = -1;

            SqlCommand cmd = new SqlCommand("sp_UpdateTrainComponent", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@trainComponentID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@memberID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@manufacturerID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@sellerID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@railwayCompanyID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@modelID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@typeDesignation", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@no", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@description", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@purchasePrice", SqlDbType.Money));
            cmd.Parameters.Add(new SqlParameter("@inPossession", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@occasion", SqlDbType.Bit));
            cmd.Parameters.Add(new SqlParameter("@publication", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@articleNo", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@setNo", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@color", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@comment", SqlDbType.NVarChar, 255));
            cmd.Parameters.Add(new SqlParameter("@release", SqlDbType.Bit));

            cmd.Parameters["@trainComponentID"].Value = Int32.Parse(Row.Cells[0].Text);
            cmd.Parameters["@memberID"].Value = (Row.FindControl("ddl_member") as DropDownList).SelectedValue;
            cmd.Parameters["@manufacturerID"].Value = (Row.FindControl("ddl_Manufacturer") as DropDownList).SelectedValue;
            cmd.Parameters["@sellerID"].Value = (Row.FindControl("ddl_Seller") as DropDownList).SelectedValue;
            cmd.Parameters["@railwayCompanyID"].Value = (Row.FindControl("ddl_RailwayCompany") as DropDownList).SelectedValue;
            cmd.Parameters["@modelID"].Value = (Row.FindControl("ddl_Model") as DropDownList).SelectedValue;
            cmd.Parameters["@typeDesignation"].Value = (Row.Cells[6].Controls[0] as TextBox).Text;
            cmd.Parameters["@no"].Value = (Row.Cells[7].Controls[0] as TextBox).Text;
            cmd.Parameters["@description"].Value = (Row.Cells[8].Controls[0] as TextBox).Text;
            cmd.Parameters["@purchasePrice"].Value = (Row.Cells[9].Controls[0] as TextBox).Text;
            cmd.Parameters["@inPossession"].Value = (Row.Cells[10].Controls[0] as TextBox).Text;
            cmd.Parameters["@occasion"].Value = (Row.Cells[11].Controls[0] as CheckBox).Checked;
            cmd.Parameters["@publication"].Value = (Row.Cells[12].Controls[0] as TextBox).Text;
            cmd.Parameters["@articleNo"].Value = (Row.Cells[13].Controls[0] as TextBox).Text;
            cmd.Parameters["@setNo"].Value = (Row.Cells[14].Controls[0] as TextBox).Text;
            cmd.Parameters["@color"].Value = (Row.Cells[15].Controls[0] as TextBox).Text;
            cmd.Parameters["@comment"].Value = (Row.Cells[16].Controls[0] as TextBox).Text;
            cmd.Parameters["@release"].Value = (Row.Cells[17].Controls[0] as CheckBox).Checked;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            GvTrainComponents();
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
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddl = e.Row.FindControl("ddl_member") as DropDownList;

                    DataTable dt = GetDDLList("sp_ddlSelectMember");
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Member";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    DataRowView drv = e.Row.DataItem as DataRowView;
                    ddl.SelectedValue = drv["Member_ID"].ToString();

                    ddl = e.Row.FindControl("ddl_Manufacturer") as DropDownList;

                    dt = GetDDLList("sp_ddlSelectManufacturer");
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Bezeichnung";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    ddl.SelectedValue = drv["Manufacturer_ID"].ToString();

                    ddl = e.Row.FindControl("ddl_Seller") as DropDownList;

                    dt = GetDDLList("sp_ddlSelectSeller");
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Seller";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    ddl.SelectedValue = drv["Seller_ID"].ToString();

                    ddl = e.Row.FindControl("ddl_RailwayCompany") as DropDownList;

                    dt = GetDDLList("sp_ddlSelectRailWayCompany");
                    ddl.DataSource = dt;
                    ddl.DataTextField = "Abbrevation";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    ddl.SelectedValue = drv["RailwayCompany_ID"].ToString();

                    ddl = e.Row.FindControl("ddl_Model") as DropDownList;

                    dt = GetDDLList("sp_ddlselectModel");
                    ddl.DataSource= dt;
                    ddl.DataTextField = "Model";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    ddl.SelectedValue = drv["Model_ID"].ToString();
                }
            }
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
            GridViewRow Row = gvTrainComponentsMembers.Rows[e.RowIndex];
            gvTrainComponentsMembers.EditIndex = -1;

            SqlCommand cmd = new SqlCommand("sp_UpdateReleaseStatus", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.Add(new SqlParameter("@trainComponentID", SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@release", SqlDbType.Bit));

            cmd.Parameters["@trainComponentID"].Value = Int32.Parse(Row.Cells[0].Text);
            cmd.Parameters["@release"].Value = (Row.Cells[17].Controls[0] as CheckBox).Checked;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private DataTable GetDDLList(string sp) 
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand(sp, con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();
            return dt;
        }

        protected void CreateComponent_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CreateTrainComponent.aspx");
        }

        protected void BtnAddManufacturer_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddManufacturer.aspx");
        }

        protected void BtnAddRailWayCompany_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddRailwayCompany.aspx");
        }
    }
}