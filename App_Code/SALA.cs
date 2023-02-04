using System;
using System.Data;

public class SALA
{

    public string ID;
    public string NOMBRE;
    public string UBICACION;
    public string CUPO;
    
    public void New() 
    {
        ID = "-1";
        NOMBRE = "";
        UBICACION = "";
        CUPO = "";
    }

    public void Create() 
    {
        string vSql = "INSERT INTO SALA (CUPO, NOMBRE, UBICACION) VALUES(@CUPO, @NOMBRE, @UBICACION)";

        string vParamNames = "@CUPO|@NOMBRE|@UBICACION";
        string vParamValues = CUPO + "|" + NOMBRE + "|" + UBICACION;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public static void Delete(string pID) 
    {
        string vSql = "DELETE FROM SALA WHERE ID = @ID";

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Update()
    {
        string vSql = "UPDATE SALA SET CUPO = @CUPO, NOMBRE = @NOMBRE, UBICACION = @UBICACION WHERE ID = @ID";

        string vParamNames = "@CUPO|@NOMBRE|@UBICACION|@ID";
        string vParamValues = CUPO + "|" + NOMBRE + "|" + UBICACION + "|" + ID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Fill(string pID)
    {
        DataTable dt = sqlserver.Get("SELECT * FROM SALA WHERE ID =" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID= Convert.ToString(dt.Rows[0]["ID"]);
            this.NOMBRE = Convert.ToString(dt.Rows[0]["NOMBRE"]);
            this.UBICACION = Convert.ToString(dt.Rows[0]["UBICACION"]);
            this.CUPO = Convert.ToString(dt.Rows[0]["CUPO"]);
        }
    }

    public static DataTable GetAll() 
    { 
        return sqlserver.Get("SELECT * FROM SALA ");
    }
    public static int GetByTitle(string pTitle)
    {
        int vResult = -1;
        try
        {
            vResult = Convert.ToInt32(sqlserver.Get("SELECT ID FROM SALA WHERE UPPER(NOMBRE)=UPPER('" + pTitle + "')").Rows[0][0]);
        }
        catch { }
        return vResult;
    }
}