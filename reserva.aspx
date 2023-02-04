<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Security" %>


<script runat="server">

    public string ID
    {
        get
        {
            if (ViewState["ID"] != null)
                return Convert.ToString(ViewState["ID"]);
            return "-1";
        }
        set
        {
            ViewState["ID"] = value;
        }
    }

    public string PRESENT_LOGIN
    {
        get
        {
            return Convert.ToString(System.Security.Principal.WindowsIdentity.GetCurrent().Name);
        }
    }
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["ID"] == null)
                Response.Redirect ("alert.aspx?message=DEBE DEFINIR UNA RESERVA.");
            
            if (Request.QueryString["ID"] == null && EsRepetido(Convert.ToString (Request.QueryString["ID"])))
                 Response.Redirect ("alert.aspx?message=UD YA COMPLETO LA RESERVA.");
                
            if (Request.QueryString["ID"] != null)
            {
                this.ID = Convert.ToString(Request.QueryString["ID"]);
                PrintRESERVA();
            }
        }
    }
    private void PrintRESERVA()
    {
        try
        {
            string vControlHtml = "";

            Label1.Text = BuildTable(this.ID);

            DataTable dtRESERVA = sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + this.ID);

            string vTitulo = Convert.ToString(dtRESERVA.Rows[0][0]).Replace("_", "&nbsp;");
            
            /// TITULO RESERVA ///
            Label1.Text = Label1.Text.Replace("[TITULO]", vTitulo);

            DataTable dtreserva = sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + this.ID + " ORDER BY ORDEN");

            for (int res = 0; res < dtreserva.Rows.Count; res++)
            {

                /// PRINT RESERVA
                if (Convert.ToInt32(dtreserva.Rows[res]["ID"]) == 1)
                {
                    vControlHtml = "<TEXTAREA NAME='ID" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "' ROWS='4' COLS='50'></TEXTAREA>";
                    Label1.Text = Label1.Text.Replace("[RESERVA" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "]", vControlHtml);
                }
                else
                {
                    //DataTable dtRES = sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + Convert.ToString(dtreserva.Rows[res]["ID"]) + " ORDER BY ORDEN");

                    if (dtreserva.Rows.Count > 0)
                    {
                        if (Convert.ToInt32(dtreserva.Rows[res]["ID"]) == 2)
                        {
                            vControlHtml = "<SELECT NAME='ID" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "'>";
                            for (int i = 0; i < dtreserva.Rows.Count; i++)
                                vControlHtml += "<OPTION VALUE='" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "'>" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "</OPTION>";
                            vControlHtml += "</SELECT>";
                        }
                        if (Convert.ToInt32(dtreserva.Rows[res]["ID"]) == 3)
                        {
                            vControlHtml = "";
                            for (int i = 0; i < dtreserva.Rows.Count; i++)
                                vControlHtml += "<INPUT TYPE='checkbox' NAME='ID" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "' VALUE='" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "'>" + Convert.ToString(dtreserva.Rows[i]["TEXTO_RESP"]);
                        }
                        if (Convert.ToInt32(dtreserva.Rows[res]["ID"]) == 4)
                        {
                            vControlHtml = "<div class='acidjs-rating-stars' id='" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "'>";
                            for (int i = 0; i < dtreserva.Rows.Count; i++)
                                vControlHtml += "<input type='radio' name='ID" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "' id='ID" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "-1-" + Convert.ToString(i) + "' value='" + Convert.ToString(dtreserva.Rows.Count - i) + "' /><label for='ID" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "-1-" + Convert.ToString(i) + "'></label>";
                            vControlHtml += "</div>";
                        }                        
                        Label1.Text = Label1.Text.Replace("[RESERVA" + Convert.ToString(dtreserva.Rows[res]["ID"]) + "]", vControlHtml);
                    }
                }
            }
        }
        catch //(Exception ex)
        {
            Response.Redirect("alert.aspx?message=ERROR: La reserva no puede ser desplegada.");
        }
        
    }
    private string BuildTable(string pID)
    {
        string vResult = "";
        DataTable dtreserva = sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + pID + " ORDER BY ORDEN");
        vResult += "<TABLE class= titulo><TR><TD><H2>[TITULO]<H2/></TD></TR></TABLE>";
        vResult += "<TABLE class=contenedor CELLSPACING='5' CELLPADDING='5'>";
        for (int i = 0; i < dtreserva.Rows.Count; i++)
        {
            vResult += "<TR class= border_bottom td><TD><b>[RESERVA" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "]</b><br/>[RESERVA" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "]<br/></TD><TD valign='top'>[RESERVA_" + Convert.ToString(dtreserva.Rows[i]["ID"]) + "]</TD></TR>";
        }
        vResult += "</TABLE>";
        return vResult;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string ID, IGG, EVENTOID, BANDAID, SALAID;
        
        DataTable dtreserva = sqlserver.Get("SELECT * FROM RESERVA WHERE ID=" + this.ID + " ORDER BY ORDEN");
        
        
        for (int res = 0; res < dtreserva.Rows.Count; res++)
        {
            ID = Convert.ToString(dtreserva.Rows[res]["ID"]);
            try
            {
                ID = Convert.ToString (Convert.ToInt32(Request.Form["ID" + Convert.ToString(dtreserva.Rows[res]["ID"])]));
            }
            catch
            {
                ID = "-1";
            }
            
          //  string vSql = "INSERT INTO RESERVA (IGG, EVENTOID, BANDAID, SALAID) VALUES (@IGG, @EVENTOID, @BANDAID, @SALAID)";
           // string vParamNames = "@EVENTOID|@BANDAID|@SALAID";
            //string vParamValues = EVENTOID + "|" + BANDAID + "|" + SALAID;
            
            /*R = Convert.ToString (Request.Form["ID" + Convert.ToString(dtreserva.Rows[res]["ID"])]);*/
           // FECHA = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            
          //  sqlserver.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
        }

        Response.Redirect("alert.aspx?message=GRACIAS POR COMPLETAR LA RESERVA!");
    }
    private bool EsRepetido(string pID)
    {
        string vSql = "SELECT COUNT(1) FROM RESERVA R WHERE R.ID=" + pID + " AND R.IGG='" + this.PRESENT_LOGIN + "'";
        DataTable dt = sqlserver.Get(vSql);
        return (Convert.ToInt32(dt.Rows[0][0]) > 0);
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<html>

<head id="Head1"> 
     <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="Content/total.css" rel="stylesheet" />
    <link href="Styles/start.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />
    <link href="Content/jquery-ui-custom.css" rel="stylesheet" />
    <link href="Content/ui.jqgrid.css" rel="stylesheet" />
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
    <div>
                    <div class="title">
                <table width="100%"><tr><td>
                <table width="100%"><tr><td width="1"><img src="Styles/logo.png" /></td><td>
                   </td></tr>
                </table>                
                    </td></tr></table>                
            </div>
        <table width="100%">
            <tr>
                <td width="100%" align="center">
                            <table >
                                <tr><td align="center">
                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                        <br />
                                        <asp:Button CssClass="btn" ID="Button1" runat="server" Text="FINALIZAR RESERVA" OnClick="Button1_Click" />
                                        <br />                                        
                                    </td>
                                    </tr>
                                </table>
                    </td>
                </tr>
            </table>
    </div>
    </form>
</body>
</html>
</asp:Content>
