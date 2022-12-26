using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia.App_Code
{
    public class GlobalDBConnection
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
        private static readonly SqlConnection con = new(connectionString);

        public static SqlConnection GetConnection()
        {
            return con;
        }
    }
}