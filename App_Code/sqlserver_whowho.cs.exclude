using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
 
public class sqlserver_whowho
{
    public static DataTable Get(string pSql)
    {
        DataView dv = new DataView();
        DataSet ds = new DataSet();
        SqlConnection cn = new SqlConnection();

        cn.ConnectionString = ConfigurationSettings.AppSettings["WhoWho_ConnectionString"];
        cn.Open();

        SqlDataAdapter da = new SqlDataAdapter(pSql, cn);
        
        da.Fill(ds);
        da.Dispose();
        
        cn.Close();
        cn.Dispose();

        return ds.Tables[0];
    }

    public static void Execute(string pSql)
    {
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = ConfigurationSettings.AppSettings["WhoWho_ConnectionString"];
        cn.Open();
        SqlCommand cmd = new SqlCommand(pSql, cn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();

        cn.Close();
        cn.Dispose();
    }

}