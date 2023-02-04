using System;
using System.Data;

public class USUARIO
{
    public string ID;
    public string NOMBRE;
    public string IGG;

    public void New()
    {
        ID = "-1";
        NOMBRE = "";
        IGG = "";
        
    }
    public void Create()
    {
        string vSql = "INSERT INTO USUARIO (NOMBRE, IGG) VALUES (@NOMBRE, @IGG)";


        string vParamNames = "@NOMBRE|@IGG";
        string vParamValues = NOMBRE + "|" + IGG ;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM USUARIO WHERE ID = @ID";

        string vParamNames = "@ID";
        string vParamValues = pID;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));

    }
    public void Update()
    {
        string vSql = @"UPDATE USUARIO SET NOMBRE= @NOMBRE, 
                                                  LOGIN= @IGG, 
                                                  WHERE ID= @ID";

        string vParamNames = "@NOMBRE|@IGG";
        string vParamValues = NOMBRE + "|" + IGG;

        sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = sqlserver.Get("SELECT * FROM USUARIO WHERE ID=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID = Convert.ToString(dt.Rows[0]["ID"]);
            this.NOMBRE = Convert.ToString(dt.Rows[0]["NOMBRE"]);
            this.IGG = Convert.ToString(dt.Rows[0]["IGG"]);
        }
    }
    public static DataTable GetAll()
    {
        //"SELECT S.ID_SECTOR, S.ID_GERENCIA, S.DESCRIPCION AS DES_USUARIO, G.DESCRIPCION AS DES_GERENCIA FROM USUARIO S INNER JOIN GERENCIA G ON (S.ID_GERENCIA = G.ID_GERENCIA
        return sqlserver.Get("SELECT ID,* FROM USUARIO ");
    }
}
