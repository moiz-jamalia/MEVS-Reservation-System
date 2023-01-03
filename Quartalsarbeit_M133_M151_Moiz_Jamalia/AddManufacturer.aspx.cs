using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public partial class AddManufacturer : System.Web.UI.Page
    {
        private static readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
            if (Session["isAdmin"].ToString() == "False") Response.Redirect("~/TrainComponentOverview.aspx");
            if (!IsPostBack) GvBindManufacturers();
        }

        private void GvBindManufacturers()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_SelectManufacturer", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();

            CheckIfTableEmpty(gvManufacturers, dt, "No Manufacturers registered.");
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

        protected void GvManufacturers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvManufacturers.EditIndex = -1;
            GvBindManufacturers();
        }

        protected void GvManufacturers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow Row = gvManufacturers.Rows[e.RowIndex];


        }

        protected void GvManufacturers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvManufacturers.EditIndex = e.NewEditIndex;
            GvBindManufacturers();
        }

        protected void BtnAddManufacturer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlCommand cmd = new SqlCommand("sp_InsertManufacturer", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@designation", SqlDbType.NVarChar, 255));
                cmd.Parameters["@designation"].Value = tbaddManufacturers.Text;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                GvBindManufacturers();
            }
        }
    }
}