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
                gvTrainComponents.Columns[0].Visible = false;
            }

            if (!IsPostBack)
            {
                GvTrainComponents();
            }
        }

        private void GvTrainComponents()
        {
            DataSet ds = new DataSet();

            con.Open();

            SqlCommand cmd = new SqlCommand("", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void GvTrainComponents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }


        protected void GvTrainComponents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GvTrainComponents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTrainComponents.PageIndex = e.NewPageIndex;
            GvTrainComponents();
        }

        protected void GvTrainComponents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrainComponents.EditIndex = -1;
            GvTrainComponents();
        }

        protected void GvTrainComponents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrainComponents.EditIndex = e.NewEditIndex;
            GvTrainComponents();
        }
    }
}