<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label1.Text = Usuario.getName();
                GridView1_DataBind();
            }
        }
        private void GridView1_DataBind()        
        {
            string vSql = @"SELECT DISTINCT INV.IGG, USU.NOMBRES AS 'NOMBRE',USU.APELLIDO 'APELLIDO',USU.MAIL 'E-MAIL', (USU.ID_GERENCIA + '-' + USU.ID_DEPARTAMENTO + '-' + USU.ID_SERVICIO) AS 'DIRECCION',
                                INV.TURNO, INV.TIENENOTEBOOK, INV.USERCREATE FECHARESERVA
                                FROM RESERVASWAT_ASISTENTE INV LEFT JOIN USUARIOS USU ON USU.IGG = INV.IGG WHERE INV.USERDELETE IS NULL";

            GridView1.DataSource = sqlserver.Get(vSql);
            GridView1.DataBind();

            
            vSql = @"SELECT DISTINCT INV.IGG, USU.NOMBRES AS 'NOMBRE',USU.APELLIDO 'APELLIDO',USU.MAIL 'E-MAIL', (USU.ID_GERENCIA + '-' + USU.ID_DEPARTAMENTO + '-' + USU.ID_SERVICIO) AS 'DIRECCION',
                                INV.TURNO, INV.TIENENOTEBOOK, INV.USERCREATE FECHARESERVA
                                FROM RESERVASWAT_GRAL INV LEFT JOIN USUARIOS USU ON USU.IGG = INV.IGG WHERE INV.USERDELETE IS NULL";

            GridView2.DataSource = sqlserver.Get(vSql);
            GridView2.DataBind();            
        }

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br/><asp:Label ID="Label1" runat="server" Text=""></asp:Label><br/>
    <br />
    <b>Asistente</b><br/><br/>
      <asp:GridView ID="GridView1" runat="server" Width="90%">
        </asp:GridView>
    <br />
    <b>Publico General</b><br />
    <br />
      <asp:GridView ID="GridView2" runat="server" Width="90%">
        </asp:GridView>
    <br />
    </asp:Content>


