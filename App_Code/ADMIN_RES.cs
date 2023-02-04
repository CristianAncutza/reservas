using System;
using System.Data;
using System.Data.SqlClient;

public class ADMIN_RES
{
    public string ID;
    public string IGG;
    public string EVENTOID;
    public string SALAID;
    public string BANDAID;

    public void New(string pID)
    {
        ID = "-1";
        IGG = "";
        EVENTOID = "-1";
        SALAID = "-1";
        BANDAID = "-1";
    }


    public void Create()
    {
        string vSql = "INSERT INTO RESERVA (IGG, EVENTOID, SALAID, BANDAID) VALUES(@IGG, @EVENTOID, @SALAID, @BANDAID)";

        string vParamNames = "@IGG|@EVENTOID|@SALAID|@BANDAID";
        string vParamValues = IGG + "|" + EVENTOID + "|" + SALAID + "|" + BANDAID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM RESERVA WHERE ID = @ID";

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Update()
    {
        string vSql = "UPDATE RESERVA SET IGG=@IGG, EVENTOID=@EVENTOID, SALAID=@SALAID, BANDAID=@BANDAID WHERE ID=@ID";

        string vParamNames = "@IGG|@EVENTOID|@SALAID|@BANDAID|@ID";
        string vParamValues = IGG + "|" + EVENTOID + "|" + SALAID + "|" + BANDAID + "|" + ID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Fill(string pID)
    {
        DataTable dt = sqlserver.Get("SELECT * FROM RESERVA WHERE ID =" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID = Convert.ToString(dt.Rows[0]["ID"]);
            this.IGG = Convert.ToString(dt.Rows[0]["IGG"]);
            this.EVENTOID = Convert.ToString(dt.Rows[0]["EVENTOID"]);
            this.SALAID = Convert.ToString(dt.Rows[0]["SALAID"]);
            this.BANDAID = Convert.ToString(dt.Rows[0]["BANDAID"]);
        }
    }

    public static DataTable GetAll()
    {
        return sqlserver.Get("SELECT * FROM RESERVA ");
        //return sqlserver.Get("SELECT E.ID, E.IGG, E.EVENTOID, E.SALAID, E.BANDAID FROM RESERVA E INNER JOIN RESERVA R ON (E.ID = R.RESERVAID)");
    }
    public static int GetByTitle(string pTitle)
    {
        int vResult = -1;
        try
        {
            vResult = Convert.ToInt32(sqlserver.Get("SELECT ID FROM RESERVA WHERE UPPER(BANDAID)=UPPER('" + pTitle + "')").Rows[0][0]);
        }
        catch { }
        return vResult;
    }

    public static DataTable GetByID(string pID)
    {
        return sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + pID);
    }
}