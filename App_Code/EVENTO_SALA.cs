using System;
using System.Data;
using System.Data.SqlClient;

public class EVENTO_SALA
{
	public string ID;
    public string EVENTOID;
    public string SALAID;

    public void New()
    {
        ID = "-1";
        SALAID = "";
        EVENTOID = "";
      
    }

    public void Create()
    {
        string vSql = "INSERT INTO EVENTO_SALA (EVENTOID, SALAID) VALUES(@EVENTOID, @SALAID)";

        string vParamNames = "@EVENTOID|@SALAID";
        string vParamValues = EVENTOID + "|" + SALAID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

        
    public static void Delete(string pID) 
    {
        string vSql = "DELETE FROM EVENTO_SALA WHERE ID = @ID" ;

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }


    public void Fill(string pID)
    {
        DataTable dt = sqlserver.Get("SELECT * FROM EVENTO_SALA WHERE ID =" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID = Convert.ToString(dt.Rows[0]["ID"]);
            this.EVENTOID = Convert.ToString(dt.Rows[0]["EVENTOID"]);
            this.SALAID = Convert.ToString(dt.Rows[0]["SALAID"]);
        }
    }

    public static DataTable GetAll()
    {
        return sqlserver.Get("SELECT * FROM EVENTO_SALA ");
    }



}