using System;
using System.Data;
using System.Data.SqlClient;

public class EVENTO
{
    public string ID;
    public string TITULO;
    public string FECHA_INICIO;
    public string FECHA_FIN;
    public string DESCRIPCION;


    public void New()
    {
        ID = "-1";
        TITULO = "";
        FECHA_INICIO = "";
        FECHA_FIN = "";
        DESCRIPCION = "";
    }


    public void Create() 
    {
        string vSql = "INSERT INTO EVENTO (TITULO, FECHA_INICIO, FECHA_FIN, DESCRIPCION) VALUES(@TITULO, @FECHA_INICIO, @FECHA_FIN, @DESCRIPCION)";

        string vParamNames = "@TITULO|@FECHA_INICIO|@FECHA_FIN|@DESCRIPCION";
        string vParamValues = TITULO + "|" + FECHA_INICIO + "|" + FECHA_FIN + "|" + DESCRIPCION;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public static void Delete(string pID) 
    {
        string vSql = "DELETE FROM EVENTO WHERE ID = @ID" ;

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Update() 
    {
        string vSql = "UPDATE EVENTO SET TITULO=@TITULO, FECHA_INICIO=@FECHA_INICIO, FECHA_FIN=@FECHA_FIN, DESCRIPCION=@DESCRIPCION WHERE ID=@ID";

        string vParamNames = "@TITULO|@FECHA_INICIO|@FECHA_FIN|@DESCRIPCION|@ID";
        string vParamValues = TITULO + "|" + FECHA_INICIO + "|" + FECHA_FIN + "|" + DESCRIPCION + "|" + ID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }

    public void Fill(string pID) 
    {
        DataTable dt = sqlserver.Get("SELECT * FROM EVENTO WHERE ID =" + pID);
        if(dt.Rows.Count > 0)
        {
            this.ID= Convert.ToString(dt.Rows[0]["ID"]);
            this.TITULO = Convert.ToString(dt.Rows[0]["TITULO"]);
            this.FECHA_INICIO = Convert.ToString(dt.Rows[0]["FECHA_INICIO"]);
            this.FECHA_FIN = Convert.ToString(dt.Rows[0]["FECHA_FIN"]);
            this.DESCRIPCION = Convert.ToString(dt.Rows[0]["DESCRIPCION"]);
        }
    }

    public static DataTable GetAll()
    {
        return sqlserver.Get("SELECT * FROM EVENTO ");
        //return sqlserver.Get("SELECT E.ID, E.TITULO, E.FECHA_INICIO, E.FECHA_FIN, E.DESCRIPCION FROM EVENTO E INNER JOIN RESERVA R ON (E.ID = R.EVENTOID)");
    }
    public static int GetByTitle(string pTitle)
    {
        int vResult = -1;
        try
        {
            vResult = Convert.ToInt32(sqlserver.Get("SELECT ID FROM EVENTO WHERE UPPER(TITULO)=UPPER('" + pTitle + "')").Rows[0][0]);
        }
        catch { }
        return vResult;
    }

}