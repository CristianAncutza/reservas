<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView1_DataBind();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1_DataBind();
    }

    protected void GridView1_CancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        GridView1_DataBind();
    }
    
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
            try
            {
                switch (e.CommandName)
                {
                    case "Insert":
                        GridView1_Insert();
                        break;

                    case "Update":
                        GridView1_Update();
                        break;
                }

                GridView1.DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
    }
    
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (TableCell tc in e.Row.Cells)
        {
            tc.Attributes["style"] = "border-color: #c3cecc;";
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l = (LinkButton)e.Row.FindControl("LinkDelete");
            l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID") + "')");
        }
    }

    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
        }
    }
    
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridView1_Delete(Convert.ToString(GridView1.DataKeys[e.RowIndex].Values[0]));
            GridView1_DataBind();
            lbMessage.Text = "";
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GridView1_DataBind();
        GridView1_EditRowFill();
    }
    
    private void GridView1_EditRowFill()
    {
        EVENTO vEVENTO = new EVENTO();
        vEVENTO.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

        ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TITULO")).Text = Convert.ToString(vEVENTO.TITULO);
    }
    
    protected void GridView1_RowUpdated(Object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
        }
    }
    
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView1_DataBind();
    }
    
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        GridView1_OrderBy = e.SortExpression;
        GridView1_DataBind();
    }
    
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

    private DataView GridSort(DataTable dt, string pOrderField)
    {
        DataView dv = new DataView(dt);
        dv.Sort = pOrderField;
        return dv;
    }
    
    protected void GridView1_Insert()
    {
        try
        {
            EVENTO vEVENTO = new EVENTO();
            vEVENTO.TITULO = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TITULO")).Text.ToString());

            vEVENTO.Create();
            GridView1_DataBind();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    
    protected void GridView1_Update()
    {
        try
        {
            EVENTO vEVENTO = new EVENTO();
            vEVENTO.ID = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
            vEVENTO.TITULO = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TITULO")).Text.ToString());
            vEVENTO.FECHA_INICIO = String.Format ("{0:yyyy-MM-dd}", ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).Text);
            vEVENTO.FECHA_FIN = String.Format("{0:yyyy-MM-dd}", ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_FIN")).Text);
            vEVENTO.DESCRIPCION = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("DESCRIPCION")).Text);
            vEVENTO.Update();
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }

        GridView1.EditIndex = -1;
    }
    
    protected void GridView1_Delete(string pID)
    {
        try
        {
            EVENTO.Delete(pID);
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
        }
    }
    
    private string GridView1_OrderBy
    {
            get
            {
                if (ViewState["GridView1_OrderBy"] == null)
                    return "ID DESC";
                return (string)ViewState["GridView1_OrderBy"];
            }
            set
            {
                ViewState["GridView1_OrderBy"] = value;
            }
    }
    
    private void GridView1_DataBind()
    {
        DataTable dt = this.DataSource();

        if (dt.Rows.Count == 0)
            dt.Rows.Add(dt.NewRow());

        GridView1.DataSource = GridSort(dt, GridView1_OrderBy);
        GridView1.DataBind();

        GridView1_AddRowFill();
    }

    private DataTable DataSource()
    {
        return EVENTO.GetAll();
    }

    private void GridView1_AddRowFill()
    {
        EVENTO vEVENTO = new EVENTO();
        vEVENTO.New();
        ((TextBox)GridView1.FooterRow.FindControl("TITULO")).Text = Convert.ToString(vEVENTO.TITULO);

    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%"><tr><td align="center" Width="100%">

    <table width="90%"><tr><td><h3>EVENTOS</h3></td></tr><tr><td>
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

    OnPageIndexChanging="GridView1_PageIndexChanging"
    OnRowCancelingEdit = "GridView1_CancelingEdit" 
    OnRowCommand = "GridView1_RowCommand" 
    OnRowDataBound="GridView1_RowDataBound" 
    OnRowDeleted = "GridView1_RowDeleted"
    OnRowDeleting = "GridView1_RowDeleting" 
    OnRowEditing = "GridView1_RowEditing"
    OnRowUpdated = "GridView1_RowUpdated"           
    OnRowUpdating = "GridView1_RowUpdating" 
    OnSorting = "GridView1_Sorting" BackColor="White" BorderColor="White" 
            BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" Width="50%">

            <RowStyle ForeColor="Black" BackColor="#DEDFDE" />
        <Columns>
            
			<asp:CommandField ShowEditButton="True" ButtonType="Link" EditText ="EDITAR" UpdateText="ACTUALIZAR" CancelText="CANCELAR" />
			
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkDelete" runat="server" CausesValidation="False" CommandName="Delete" ToolTip="Eliminar Registro" Text="ELIMINAR"></asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="Create" CommandName="Insert" runat="server" ToolTip="Agregar Registro" Text="AGREGAR" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="TITULO" SortExpression="TITULO">
                <ItemTemplate><%# Eval("TITULO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TITULO" Text='<%# Eval("TITULO") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TITULO" Text='' runat="server" Width="100%"/>        
                </FooterTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="FECHA_INICIO" SortExpression="FECHA_INICIO">
                <ItemTemplate><%# Eval("FECHA_INICIO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="FECHA_INICIO" Text='<%# Eval("FECHA_INICIO") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="FECHA_INICIO" Text='' runat="server" Width="100%"/>        
                </FooterTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="FECHA_FIN" SortExpression="FECHA_FIN">
                <ItemTemplate><%# Eval("FECHA_FIN")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="FECHA_FIN" Text='<%# Eval("FECHA_FIN") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="FECHA_FIN" Text='' runat="server" Width="100%"/>        
                </FooterTemplate>
            </asp:TemplateField> 
            
            <asp:TemplateField HeaderText="DESCRIPCION" SortExpression="DESCRIPCION">
                <ItemTemplate><%# Eval("DESCRIPCION")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="DESCRIPCION" Text='<%# Eval("DESCRIPCION") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="DESCRIPCION" Text='' runat="server" Width="100%"/>        
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
      <asp:Label runat="server" ID="lbMessage" Font-Bold="True" Font-Size="Medium" ForeColor="Red" />
                        </td></tr><tr><td></td></tr></table>
                        
        </td></tr></table>

</asp:Content>

