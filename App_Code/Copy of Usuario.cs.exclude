using System;
using System.Data;
using System.Security;

public class Usuario
{
    public static string getReservaGral()
    {
        string vResult ="";
        string vSql = "SELECT turno+', tiene notebook: '+tienenotebook+'<br/>hecha el '+CONVERT(varchar, usercreate) AS reserva FROM RESERVASWAT_GRAL WHERE userdelete is null AND igg='" + Usuario.getIGG() + "'";
        DataTable dt = sqlserver_whowho.Get(vSql);
        if (dt.Rows.Count > 0)
            vResult = Convert.ToString(dt.Rows[0][0]);
        return vResult;
    }

    public static string getReservaAsistente()
    {
        string vResult ="";
        string vSql = "SELECT turno+','+'<br/>hecha el '+CONVERT(varchar, usercreate) AS reserva FROM RESERVASWAT_ASISTENTE WHERE userdelete is null AND igg='" + Usuario.getIGG() + "'";
        DataTable dt = sqlserver_whowho.Get(vSql);
        if (dt.Rows.Count > 0)
            vResult = Convert.ToString(dt.Rows[0][0]);
        return vResult;
    }

    public static string getName()
    {
        string vResult = Usuario.getIGG();
        string vSql = "SELECT '['+igg+']'+Apellido+','+Nombres AS Name FROM USUARIOS WHERE igg='" + vResult + "'";
        DataTable dt = sqlserver_whowho.Get(vSql);
        if (dt.Rows.Count > 0)
            vResult = Convert.ToString (dt.Rows[0][0]);
        return vResult;
    }

    public static string getIGG()
    {
        return Convert.ToString(System.Security.Principal.WindowsIdentity.GetCurrent().Name).Split('\\')[1];
    }

}