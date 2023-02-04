using System;
using System.Data;

public class BANDA
{

    public string ID;
    public string FECHA;
    public string HORARIO_INICIO;
    public string HORARIO_FIN;

    public void New()
    {
        ID = "-1";
        FECHA = "";
        HORARIO_INICIO = "";
        HORARIO_FIN = "";
    }

    public void Create()
    {
        string vSql = "INSERT INTO BANDA (FECHA, HORARIO_INICIO, HORARIO_FIN) VALUES(@FECHA, @HORARIO_INICIO, @HORARIO_FIN)";

        string vParamNames = "@FECHA|@HORARIO_INICIO|@HORARIO_FIN";
        string vParamValues = FECHA + "|" + HORARIO_INICIO + "|" + HORARIO_FIN;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM BANDA WHERE ID = @ID";

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Update()
    {
        string vSql = "UPDATE BANDA SET FECHA = @FECHA, HORARIO_INICIO = @HORARIO_INICIO, HORARIO_FIN = @HORARIO_FIN WHERE ID = @ID";

        string vParamNames = "@FECHA|@HORARIO_INICIO|@HORARIO_FIN|@ID";
        string vParamValues = FECHA + "|" + HORARIO_INICIO + "|" + HORARIO_FIN + "|" + ID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Fill(string pID)
    {
        DataTable dt = sqlserver.Get("SELECT * FROM BANDA WHERE ID =" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID = Convert.ToString(dt.Rows[0]["ID"]);
            this.HORARIO_INICIO = Convert.ToString(dt.Rows[0]["HORARIO_INICIO"]);
            this.HORARIO_FIN = Convert.ToString(dt.Rows[0]["HORARIO_FIN"]);
            this.FECHA = Convert.ToString(dt.Rows[0]["FECHA"]);
        }
    }

    public static DataTable GetAll()
    {
        return sqlserver.Get("SELECT * FROM BANDA ");
    }
    public static int GetByTitle(string pTitle)
    {
        int vResult = -1;
        try
        {
            vResult = Convert.ToInt32(sqlserver.Get("SELECT ID FROM BANDA WHERE UPPER(HORARIO_INICIO)=UPPER('" + pTitle + "')").Rows[0][0]);
        }
        catch { }
        return vResult;
    }
}