<%@ Page Title="Reservas" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lbLogin.Text = Usuario.getName();
            PanelReserva_DataBind();
        }
    }
    private void PanelReserva_DataBind()
    {
        lbReserva.Text = Usuario.getReservaAsistente();

        if (lbReserva.Text.Length > 0)
        {
            PanelReserva.Visible = true;
            btnSala1Hora1.Enabled = false;
            btnSala1Hora2.Enabled = false;
            btnSala1Hora3.Enabled = false;
        }
        else
        {
            PanelReserva.Visible = false;
            btnSala1Hora1.Enabled = true;
            btnSala1Hora2.Enabled = true;
            btnSala1Hora3.Enabled = true;
        }
    }
    protected void btnSala1Hora1_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarCupo(9, lbSala1Hora1.Text);
            string vSql = "INSERT INTO RESERVASWAT_ASISTENTE (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbSala1Hora1.Text + "',null,null,getdate(),null)";
            sqlserver_whowho.Execute(vSql);
            PanelReserva_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    protected void btnSala1Hora2_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarCupo(9, lbSala1Hora2.Text);
            string vSql = "INSERT INTO RESERVASWAT_ASISTENTE (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbSala1Hora2.Text + "',null,null,getdate(),null)";
            sqlserver_whowho.Execute(vSql);
            PanelReserva_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    protected void btnSala1Hora3_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarCupo(9, lbSala1Hora3.Text);
            string vSql = "INSERT INTO RESERVASWAT_ASISTENTE (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbSala1Hora3.Text + "',null,null,getdate(),null)";
            sqlserver_whowho.Execute(vSql);
            PanelReserva_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }        
    }
    protected void btnCancelarReserva_Click(object sender, EventArgs e)
    {
        string vSql = "UPDATE RESERVASWAT_ASISTENTE SET userdelete=getdate() WHERE igg='" + Usuario.getIGG() + "'";
        sqlserver_whowho.Execute(vSql);
        PanelReserva_DataBind();
    }
    private void ValidarCupo(int pCupo, string pTurno)
    {
        string vSql = "SELECT COUNT(1) FROM RESERVASWAT_ASISTENTE WHERE userdelete is null AND turno='" + pTurno+"'";
        DataTable dt = sqlserver_whowho.Get (vSql);
        if (Convert.ToInt32(dt.Rows[0][0]) >= pCupo)
            throw new Exception("Cupo completo para " + pTurno);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><br/>
    <br/><asp:Label ID="lbLogin" runat="server" Text=""></asp:Label><br/><br/><br/>
    <table width="100%">
        <tr><td width="100%" align="center"><br/>
    <asp:Panel ID="PanelReserva" runat="server">
    
        <table style="margin: 0 auto; font-family: Verdana, Arial, Helvetica, sans-serif, Trebuchet MS;
                        padding: 0; width:930px; border:1px solid #ddd">
                        <tr style="height: 40px;">
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;" >
                                <asp:Label ID="lbReserva" runat="server" Text="" Font-Bold="true" ForeColor="Red" ></asp:Label></td>
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;">                                
                                         <asp:Button ID="btnCancelarReserva" runat="server" OnClick="btnCancelarReserva_Click" 
                                    OnClientClick="if(!confirm('Cancelar la reserva ¿Esta Seguro?'))return false;" 
                                    Text="Cancelar Reserva" Width="130px" />
                            </td>
                        </tr>               
        </table>

    </asp:Panel>
            </td>
            </tr>
        </table><br/>
    <table style="margin: 0 auto; font-family: Verdana, Arial, Helvetica, sans-serif, Trebuchet MS;
                        padding: 0; width:930px; border:1px solid #ddd">
                        <tr style="height: 40px; background-color: silver; color: white">
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;" >
                                Calendario del Evento</td>
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;">                                
                                &nbsp;</td>
                        </tr>               
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                               <asp:Label ID="lbSala1Hora1" Font-Bold="true" runat="server" Text="Jueves 29/09 - 10 Hs - Sala Grande | Piso 20"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnSala1Hora1" runat="server" OnClick="btnSala1Hora1_Click" 
                                    OnClientClick="if(!confirm('Reservar: Jueves 29/09 - 10 Hs - Sala Grande | Piso 20 ¿Esta Seguro?'))return false;" 
                                    Text="Reservar" Width="130px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                               <asp:Label ID="lbSala1Hora2" Font-Bold="true" runat="server" Text="Jueves 29/09 - 15 Hs - Sala Grande | Piso 20"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnSala1Hora2" runat="server" OnClick="btnSala1Hora2_Click" 
                                    OnClientClick="if(!confirm('Reservar: Jueves 29/09 - 15 Hs - Sala Grande | Piso 20 ¿Esta Seguro?'))return false;" 
                                    Text="Reservar" Width="130px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                                <asp:Label ID="lbSala1Hora3" Font-Bold="True" runat="server" Text="Viernes 30/09 - 10 Hs - Sala Grande | Piso 20"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnSala1Hora3" runat="server" OnClick="btnSala1Hora3_Click" 
                                    OnClientClick="if(!confirm('Reservar: Viernes 30/09 - 10 Hs - Sala Grande | Piso 20 ¿Esta Seguro?'))return false;" 
                                    Text="Reservar" Width="130px" />
                            </td>
                        </tr>
                    </table>
        <table width="100%">
        <tr><td width="100%" align="center">
    <asp:Label ID="lbMessage" runat="server" Text="" Font-Bold="true" ForeColor="Red" ></asp:Label>
            </td>
            </tr>
          </table>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><hr/>
    Asistentes
</asp:Content>

