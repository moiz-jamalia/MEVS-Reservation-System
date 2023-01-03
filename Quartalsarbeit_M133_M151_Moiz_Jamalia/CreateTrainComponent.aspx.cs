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
    public partial class CreateTrainComponent : System.Web.UI.Page
    {
        private readonly SqlConnection con = GlobalDBConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["secureCookie"] == null) Response.Redirect("~/Login.aspx");
            if (!IsPostBack)
            {
                DDLBind(ddl_Manufacturer, GetManufacturer(), "Bezeichnung", "ID");
                DDLBind(ddl_RailWayCompany, GetRailWayCompany(), "Abbrevation", "ID");
                DDLBind(ddl_Model, GetModel(), "Model", "ID");
            }
        }

        private void DDLBind(DropDownList DDL, DataTable Datatable, string DataTextField, string DataValueField)
        {
            DropDownList ddl = DDL;
            DataTable dt = Datatable;
            ddl.DataSource = dt;
            ddl.DataTextField = DataTextField;
            ddl.DataValueField = DataValueField;
            ddl.DataBind();
        }

        private DataTable GetManufacturer()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_ddlSelectManufacturer", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();
            return dt;
        }

        private DataTable GetRailWayCompany()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_ddlSelectRailwayCompany", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();
            return dt;
        }

        private DataTable GetModel()
        {
            DataTable dt = new DataTable();

            SqlCommand cmd = new SqlCommand("sp_ddlSelectModel", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            SqlDataAdapter dap = new SqlDataAdapter(cmd);

            con.Open();
            dap.Fill(dt);
            con.Close();
            return dt;
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/TrainComponent.aspx");
        }

        protected void BtnCreate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlCommand cmd = new SqlCommand("sp_InsertTrainComponent", con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add(new SqlParameter("@FKHersteller", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferVorname", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferNachname", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferAddresse", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferEMail", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferHandy", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@VerkaeuferBemerkung", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@FKBahngesellschaft", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@FKTyp", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@typenbezeichnung", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@rollNr", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@beschreibung", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@kaufpreis", SqlDbType.Money));
                cmd.Parameters.Add(new SqlParameter("@imBesitz", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@occasion", SqlDbType.Bit));
                cmd.Parameters.Add(new SqlParameter("@veröffentlichung", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@artNr", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@setNr", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@farbe", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@bemerkung", SqlDbType.NVarChar, 255));
                cmd.Parameters.Add(new SqlParameter("@freigabe", SqlDbType.Bit));

                cmd.Parameters["@FKHersteller"].Value = ddl_Manufacturer.SelectedValue;
                cmd.Parameters["@VerkaeuferVorname"].Value = tbSellerFirstName.Text;
                cmd.Parameters["@VerkaeuferNachname"].Value = tbSellerLastName.Text;
                cmd.Parameters["@VerkaeuferAddresse"].Value = tbSellerAddress.Text;
                cmd.Parameters["@VerkaeuferEMail"].Value = tbSellerEmail.Text;
                cmd.Parameters["@VerkaeuferHandy"].Value = tbSellerPhone.Text;
                cmd.Parameters["@VerkaeuferBemerkung"].Value = tbSellerComment.Text;
                cmd.Parameters["@FKBahngesellschaft"].Value = ddl_RailWayCompany.SelectedValue;
                cmd.Parameters["@FKTyp"].Value = ddl_Model.SelectedValue;
                cmd.Parameters["@typenbezeichnung"].Value = tbTypeDesignation.Text;
                cmd.Parameters["@rollNr"].Value = tbNo.Text;
                cmd.Parameters["@beschreibung"].Value = tbDescription.Text;
                cmd.Parameters["@kaufpreis"].Value = tbPurchasePrice.Text;
                cmd.Parameters["@imBesitz"].Value = tbInPossession.Text;
                cmd.Parameters["@occasion"].Value = cbOccasion.Checked;
                cmd.Parameters["@veröffentlichung"].Value = tbPublication.Text;
                cmd.Parameters["@artNr"].Value = tbArtNo.Text;
                cmd.Parameters["@setNr"].Value = tbSetNo.Text;
                cmd.Parameters["@farbe"].Value = tbColor.Text;
                cmd.Parameters["@bemerkung"].Value = tbComment.Text;
                cmd.Parameters["@freigabe"].Value = cbRelease.Checked;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("~/TrainComponentOverview.aspx");
            }
        }

        protected void OccasionValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbOccasion.Checked;
        }

        protected void ReleaseValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbRelease.Checked; 
        }
    }
}