﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false" %>
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
        private void GridView1_AddRowFill()
        {
            BANDA vBANDA = new BANDA();
            vBANDA.New();

            ((TextBox)GridView1.FooterRow.FindControl("FECHA")).Text = Convert.ToString(vBANDA.FECHA);
            ((TextBox)GridView1.FooterRow.FindControl("HORARIO_INICIO")).Text = Convert.ToString(vBANDA.HORARIO_INICIO);
            ((TextBox)GridView1.FooterRow.FindControl("HORARIO_FIN")).Text = Convert.ToString(vBANDA.HORARIO_FIN);

        }
        private void GridView1_EditRowFill()
        {
            BANDA vBANDA = new BANDA();
            vBANDA.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA")).Text = Convert.ToString(vBANDA.FECHA);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).Text = Convert.ToString(vBANDA.HORARIO_INICIO);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).Text = Convert.ToString(vBANDA.HORARIO_FIN);
            
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

                GridView1_DataBind();
                lbMessage.Text = "";
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
                GridView1_DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
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
        protected void GridView1_CancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1_DataBind();
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
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridView1_OrderBy = e.SortExpression;
            GridView1_DataBind();
        }
        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1_DataBind();
            GridView1_EditRowFill();
        }
        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        private DataView GridSort(DataTable dt, string pOrderField)
        {
            DataView dv = new DataView(dt);
            dv.Sort = pOrderField;
            return dv;
        }
        private DataTable DataSource()
        {
            return BANDA.GetAll();
        }
        private void GridView1_Insert()
        {
            try
            {
                BANDA vBANDA = new BANDA();
                
                vBANDA.FECHA = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("FECHA")).Text.ToString());
                vBANDA.HORARIO_INICIO = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("HORARIO_INICIO")).Text.ToString());
                vBANDA.HORARIO_FIN = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("HORARIO_FIN")).Text.ToString());

                vBANDA.Create();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        private void GridView1_Update()
        {
            try
            {
                BANDA vBANDA = new BANDA();

                vBANDA.ID = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
                vBANDA.FECHA = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA")).Text.ToString());
                vBANDA.HORARIO_INICIO = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).Text.ToString());
                vBANDA.HORARIO_FIN = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).Text.ToString());
                
                vBANDA.Update();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }

            GridView1.EditIndex = -1;
        }
        private void GridView1_Delete(string pID)
        {
            try
            {
                BANDA.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        } 
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<table ><tr><td align="center" >

        <table width="90%"><tr><td><h3>BANDA</h3></td></tr><tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID"
        AllowPaging="True" 
        AllowSorting="True" 
        AutoGenerateColumns="False" 
        FooterStyle-BackColor="White" 
        CssClass="datagrid datagridBig" 
        GridLines="None" 
        runat="server"
        ShowFooter="True" 
        
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
            BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" >
            
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

             <asp:TemplateField HeaderText="FECHA" SortExpression="FECHA">
                <ItemTemplate><%# Eval("FECHA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="FECHA" Text='<%# Eval("FECHA") %>' runat="server" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="FECHA" Text='' runat="server" />        
                </FooterTemplate>
            </asp:TemplateField>          

             <asp:TemplateField HeaderText="HORARIO_INICIO" SortExpression="HORARIO_INICIO">
                <ItemTemplate><%# Eval("HORARIO_INICIO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="HORARIO_INICIO" Text='<%# Eval("HORARIO_INICIO") %>' runat="server" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="HORARIO_INICIO" Text='' runat="server" />        
                </FooterTemplate>
            </asp:TemplateField>          
            
                         <asp:TemplateField HeaderText="HORARIO_FIN" SortExpression="HORARIO_FIN">
                <ItemTemplate><%# Eval("HORARIO_FIN")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="HORARIO_FIN" Text='<%# Eval("HORARIO_FIN") %>' runat="server" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="HORARIO_FIN" Text='' runat="server" />        
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
