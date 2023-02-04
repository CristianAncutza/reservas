using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
 
public class sqlserver
{
    public static DataTable Get(string pSql)
    {
        DataView dv = new DataView();
        DataSet ds = new DataSet();
        SqlConnection cn = new SqlConnection();

        cn.ConnectionString = ConfigurationSettings.AppSettings["ConnectionString"];
        cn.Open();

        SqlDataAdapter da = new SqlDataAdapter(pSql, cn);
        
        da.Fill(ds);
        da.Dispose();
        
        cn.Close();
        cn.Dispose();

        return ds.Tables[0];
    }

    public static void Execute(string pSql, string[] pParamNames, string[] pParamValues)
    {
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = ConfigurationSettings.AppSettings["ConnectionString"];
        cn.Open();
        SqlCommand cmd = new SqlCommand(pSql, cn);
 
        for (int i = 0; i < pParamNames.Length; i++)
        {
            SqlParameter vSqlPar = new SqlParameter(pParamNames[i], pParamValues[i].Replace("\"", "'"));
            cmd.Parameters.Add(vSqlPar);
        }
        try
        {
             cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        { 
            cn.Close();
            cn.Dispose();
        }
    }

}