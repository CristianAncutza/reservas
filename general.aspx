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
        lbReserva.Text = Usuario.getReservaGral();

        if (lbReserva.Text.Length > 0)
        {
            PanelReserva.Visible = true;
            btnBANDA1Hora1.Enabled = false;
            btnBANDA1Hora2.Enabled = false;
            btnBANDA1Hora3.Enabled = false;
        }
        else
        {
            PanelReserva.Visible = false;
            btnBANDA1Hora1.Enabled = true;
            btnBANDA1Hora2.Enabled = true;
            btnBANDA1Hora3.Enabled = true;
        }
    }
    protected void btnBANDA1Hora1_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarFECHA(20, lbBANDA1Hora1.Text);
            string vTieneNotebook = "NO";
            if (rbBANDA1Hora1_SI.Checked)
                vTieneNotebook = "SI";

            string vSql = "INSERT INTO RESERVASWAT_GRAL (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbBANDA1Hora1.Text + "',null,'" + vTieneNotebook + "',getdate(),null)";
            sqlserver_whowho.Execute(vSql);
            PanelReserva_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }   
    }
    protected void btnBANDA1Hora2_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarFECHA(20, lbBANDA1Hora2.Text);
            string vTieneNotebook = "NO";
            if (rbBANDA1Hora2_SI.Checked)
                vTieneNotebook = "SI";

            string vSql = "INSERT INTO RESERVASWAT_GRAL (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbBANDA1Hora2.Text + "',null,'" + vTieneNotebook + "',getdate(),null)";
            sqlserver_whowho.Execute(vSql);
            PanelReserva_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }   
    }
    protected void btnBANDA1Hora3_Click(object sender, EventArgs e)
    {
        try
        {
            ValidarFECHA(20, lbBANDA1Hora3.Text);
            string vTieneNotebook = "NO";
            if (rbBANDA1Hora3_SI.Checked)
                vTieneNotebook = "SI";

            string vSql = "INSERT INTO RESERVASWAT_GRAL (IGG,turno,salon,tienenotebook,usercreate,userdelete) VALUES ('" + Usuario.getIGG() + "','" + lbBANDA1Hora3.Text + "',null,'" + vTieneNotebook + "',getdate(),null)";
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
        string vSql = "UPDATE RESERVASWAT_GRAL SET userdelete=getdate() WHERE igg='" + Usuario.getIGG() + "'";
        sqlserver_whowho.Execute(vSql);
        PanelReserva_DataBind();
    }
    private void ValidarFECHA(int pFECHA, string pTurno)
    {
        string vSql = "SELECT COUNT(1) FROM RESERVASWAT_GRAL WHERE userdelete is null AND turno='" + pTurno + "'";
        DataTable dt = sqlserver_whowho.Get(vSql);
        if (Convert.ToInt32(dt.Rows[0][0]) >= pFECHA)
            throw new Exception("FECHA completo para " + pTurno);
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
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;" >
                                Tiene Notebook?</td>
                            <td style="border-bottom: 1px solid #ddd; font-weight: bold; text-align: center;">                                
                                &nbsp;</td>
                        </tr>               
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                               <asp:Label ID="lbBANDA1Hora1" Font-Bold="True" runat="server" Text="Martes 11/10 – 11 hs – BANDA Grande | Piso 20"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd;">
                                <asp:RadioButton ID="rbBANDA1Hora1_SI" runat="server" Text="SI" GroupName="BANDA1Hora1" />
                                <asp:RadioButton ID="rbBANDA1Hora1_NO" runat="server" Text="NO" GroupName="BANDA1Hora1" Checked="True" />
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnBANDA1Hora1" runat="server" OnClick="btnBANDA1Hora1_Click" 
                                    OnClientClick="if(!confirm('Reservar: Martes 11/10 – 11 hs – BANDA Grande | Piso 20 ¿Esta Seguro?'))return false;" 
                                    Text="Reservar" Width="130px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                               <asp:Label ID="lbBANDA1Hora2" Font-Bold="True" runat="server" Text="Martes 11/10 – 15 hs - BANDA Grande | Piso 21"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd;">
                                <asp:RadioButton ID="rbBANDA1Hora2_SI" runat="server" Text="SI" GroupName="BANDA1Hora2"  />
                                <asp:RadioButton ID="rbBANDA1Hora2_NO" runat="server" Text="NO" GroupName="BANDA1Hora2" Checked="True" />    
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnBANDA1Hora2" runat="server" OnClick="btnBANDA1Hora2_Click" 
                                    OnClientClick="if(!confirm('Reservar: Martes 11/10 – 15 hs - BANDA Grande | Piso 21 ¿Esta Seguro?'))return false;" 
                                    Text="Reservar" Width="130px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px solid #ddd;">
                                <asp:Label ID="lbBANDA1Hora3" Font-Bold="True" runat="server" Text="Miércoles 12/10 – 10hs - BANDA Grande | Piso 21"></asp:Label> 
                            </td>
                            <td style="border-bottom: 1px solid #ddd;">
                                <asp:RadioButton ID="rbBANDA1Hora3_SI" runat="server" Text="SI" GroupName="BANDA1Hora3" />
                                <asp:RadioButton ID="rbBANDA1Hora3_NO" runat="server" Text="NO" GroupName="BANDA1Hora3" Checked="True" />                                
                            </td>
                            <td style="border-bottom: 1px solid #ddd; text-align:center">
                                <br />
                                <asp:Button ID="btnBANDA1Hora3" runat="server" OnClick="btnBANDA1Hora3_Click" 
                                    OnClientClick="if(!confirm('Reservar: Miércoles 12/10 – 10hs - BANDA Grande | Piso 21 ¿Esta Seguro?'))return false;" 
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
    gral
</asp:Content>

