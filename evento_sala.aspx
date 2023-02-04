<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {     
        if (!Page.IsPostBack)
        {
            dropEvento_Fill();
            dropSala_Fill();
            dropFiltro_Fill();
            GridDataBind();
        }
    }

    public void GridDataBind()
    {
        string vSql = "SELECT A.ID, B.TITULO AS EVENTO, C.NOMBRE AS SALA FROM eventosala A INNER JOIN EVENTO B ON (A.EVENTOID=B.ID) INNER JOIN SALA C ON (A.SALAID=C.ID) ";
        if (dropFiltro.SelectedValue != "-1")
            vSql += " WHERE A.EVENTOID=" + dropFiltro.SelectedValue;
        
        GridView1.DataSource = sqlserver.Get(vSql);
        GridView1.DataBind();
    }


    public void dropEvento_Fill()
    {
        dropEvento.DataSource = sqlserver.Get("SELECT * FROM EVENTO");
        dropEvento.DataTextField = "TITULO";
        dropEvento.DataValueField = "ID";
        dropEvento.DataBind();

        dropEvento.Items.Add(new ListItem("EVENTO", "-1"));
        dropEvento.SelectedValue = "-1";
    }

    public void dropSala_Fill()
    {
        dropSala.DataSource = sqlserver.Get("SELECT * FROM SALA");
        dropSala.DataTextField = "NOMBRE";
        dropSala.DataValueField = "ID";
        dropSala.DataBind();
        
        dropSala.Items.Add(new ListItem("SALA", "-1"));
        dropSala.SelectedValue = "-1";
    }

    public void dropFiltro_Fill()
    {
        dropFiltro.DataSource = sqlserver.Get("SELECT * FROM EVENTO");
        dropFiltro.DataTextField = "TITULO";
        dropFiltro.DataValueField = "ID";
        dropFiltro.DataBind();

        dropFiltro.Items.Add(new ListItem("TODOS", "-1"));
        dropFiltro.SelectedValue = "-1";
    }
    
    protected void GridView1_Delete(string pID)
    {
        try
        {
            EVENTOSALA.Delete(pID);
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (dropEvento.SelectedValue == "-1" || dropSala.SelectedValue == "-1")
                throw new Exception("Debe seleccionar un EVENTO y una SALA para asociar.");

            EVENTOSALA vEVENTO_SALA = new EVENTOSALA();            
            vEVENTO_SALA.EVENTOID = dropEvento.SelectedValue;
            vEVENTO_SALA.SALAID = dropSala.SelectedValue;
            vEVENTO_SALA.Create();

            //dropSala.SelectedValue = "-1";
            
            GridDataBind();      
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridView1_Delete(Convert.ToString(GridView1.DataKeys[e.RowIndex].Values[0]));
            GridDataBind();
            lbMessage.Text = "";
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }

    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
        }
    }
    
    private void GridView1_AddRowFill()
    {
        EVENTOSALA vEVENTO_SALA = new EVENTOSALA();
        vEVENTO_SALA.New();
        ((TextBox)GridView1.FooterRow.FindControl("EVENTOID")).Text = Convert.ToString(vEVENTO_SALA.EVENTOID);
        ((TextBox)GridView1.FooterRow.FindControl("SALAID")).Text = Convert.ToString(vEVENTO_SALA.SALAID);
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridDataBind();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridDataBind();
            lbMessage.Text = "";
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }

    protected void dropFiltro_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridDataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%"><tr><td align="center" Width="100%">

        <h3>eventosala</h3>
    
    <hr/>

         FILTRAR EVENTO: <asp:DropDownList ID="dropFiltro" runat="server" OnSelectedIndexChanged="dropFiltro_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>

    <asp:GridView  ID="GridView1" 
    runat="server"
    DataKeyNames = "ID"
    Allowpaging ="true"
    AllowSorting="true"
    AutoGenerateColumns ="false"
    FooterStyle-Backcolor ="White"
    CssClass ="datagrid datagridBig"
    GridLines="None"
    ShowFooter ="true"
    
    OnRowCommand = "GridView1_RowCommand"
    OnPageIndexChanging="GridView1_PageIndexChanging"
    OnRowDeleted = "GridView1_RowDeleted"
    OnRowDeleting = "GridView1_RowDeleting"

   BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" Width="50%">

            <RowStyle ForeColor="Black" BackColor="#DEDFDE" />
        <Columns>
            
					
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkDelete" runat="server" CausesValidation="False" CommandName="Delete" ToolTip="Eliminar Registro" Text="ELIMINAR"></asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText ="EVENTO">
                <ItemTemplate><%# Eval("EVENTO")%></ItemTemplate>
                <EditItemTemplate>
                </EditItemTemplate>
                <FooterTemplate>
           
                </FooterTemplate>
            </asp:TemplateField>
                        
            <asp:TemplateField HeaderText="SALA" >
                <ItemTemplate><%# Eval("SALA")%></ItemTemplate>
                <EditItemTemplate>
                </EditItemTemplate>
                <FooterTemplate>
                     
                </FooterTemplate>
            </asp:TemplateField>          
                                                                
		</Columns>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" 
            HorizontalAlign="Left" Font-Size="Small" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />

            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />

    </asp:GridView>  
        <br />
   

    <table>
        <tr>
        <td>EVENTO:</td><td><asp:DropDownList ID="dropEvento" runat="server" ></asp:DropDownList></td>
        <td>SALA:</td><td><asp:DropDownList ID="dropSala" runat="server"></asp:DropDownList></td>
        <td><asp:Button ID="Create" CommandName="Insert" runat="server" Text="Agregar" OnClick="Button1_Click" /></td>
            </tr>
        </table>
                              
        <br />
        <asp:Label ID="lbMessage" runat="server" Text="" ForeColor="Red" Font-Size="15"></asp:Label>
                              
        </td></tr></table>

</asp:Content>



