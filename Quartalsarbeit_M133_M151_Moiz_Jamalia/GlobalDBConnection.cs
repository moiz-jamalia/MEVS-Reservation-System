using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Quartalsarbeit_M133_M151_Moiz_Jamalia
{
    public static class GlobalDBConnection
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
        private static readonly SqlConnection con = new SqlConnection(connectionString);

        public static SqlConnection GetConnection()
        {
            return con;
        }
    }
}