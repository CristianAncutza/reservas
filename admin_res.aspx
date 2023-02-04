<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>

<script runat="server">

    public string ID_RESERVA
        
    {
        get
        {
            if (ViewState["ID_"] != null)
                return Convert.ToString(ViewState["ID_RESERVA"]);
            return "-1";
        }
        set
        {
            ViewState["ID_RESERVA"] = value;
        }
    }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                               
                ID.DataSource = sqlserver.Get("SELECT * FROM RESERVA");
                ID.DataTextField = "ID";
                ID.DataValueField = "ID";
                ID.DataBind();

                HyperLink1.NavigateUrl = "reserva.aspx?REP=1&ID=" + ID.SelectedValue;
                HyperLink2.NavigateUrl = "publicar.aspx?pub=http://RESERVAS/" + ID.Items.FindByValue (ID.SelectedValue).Text;

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
            ADMIN_RES vADMIN_RES = new ADMIN_RES();
            vADMIN_RES.New(ID.SelectedValue);

            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).DataSource = sqlserver.Get("SELECT * FROM EVENTO");
            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).DataTextField = "TITULO";
            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).SelectedValue = "-1";

            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).DataSource = sqlserver.Get("SELECT * FROM EVENTO");
            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).DataTextField = "FECHA_INICIO";
            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).SelectedValue = "-1";
            
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).DataSource = sqlserver.Get("SELECT * FROM BANDA");
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).DataTextField = "HORARIO_INICIO";
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).SelectedValue = "-1";

            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).DataSource = sqlserver.Get("SELECT * FROM BANDA");
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).DataTextField = "HORARIO_FIN";
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).SelectedValue = "-1";

            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).DataSource = sqlserver.Get("SELECT * FROM SALA");
            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).DataTextField = "NOMBRE";
            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("SALA")).SelectedValue = "-1";

            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).DataSource = sqlserver.Get("SELECT * FROM SALA");
            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).DataTextField = "CUPO";
            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).DataValueField = "ID";
            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).SelectedValue = "-1";

        }
        private void GridView1_EditRowFill()
        {
            RESERVA vADMIN_RES = new RESERVA();
            vADMIN_RES.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).DataSource = sqlserver.Get("SELECT * FROM EVENTO");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).DataTextField = "TITULO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).SelectedValue = Convert.ToString(vADMIN_RES.EVENTOID);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).DataSource = sqlserver.Get("SELECT * FROM EVENTO");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).DataTextField = "FECHA_INICIO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).SelectedValue = Convert.ToString(vADMIN_RES.EVENTOID);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).DataSource = sqlserver.Get("SELECT * FROM BANDA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).DataTextField = "HORARIO_INICIO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).SelectedValue = Convert.ToString(vADMIN_RES.BANDAID);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).DataSource = sqlserver.Get("SELECT * FROM BANDA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).DataTextField = "HORARIO_FIN";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).SelectedValue = Convert.ToString(vADMIN_RES.BANDAID);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).DataSource = sqlserver.Get("SELECT * FROM SALA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).DataTextField = "NOMBRE";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).SelectedValue = Convert.ToString(vADMIN_RES.SALAID);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).DataSource = sqlserver.Get("SELECT * FROM SALA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).DataTextField = "CUPO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).DataValueField = "ID";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).SelectedValue = Convert.ToString(vADMIN_RES.SALAID);

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

        private void GridView1_DataBind()
        {
            string vSql = "SELECT R.ID, E.TITULO AS EVENTOID, E.FECHA_INICIO AS FECHA, B.HORARIO_INICIO AS INICIO, B.HORARIO_FIN AS FIN, S.NOMBRE AS SALAID, S.CUPO AS CUPO FROM RESERVA R INNER JOIN EVENTO E ON E.ID = R.EVENTOID INNER JOIN  BANDA B ON B.ID = R.BANDAID INNER JOIN SALA S ON S.ID = R.SALAID ";

            GridView1.DataSource = sqlserver.Get(vSql);
            
            /*DataTable dt = this.DataSource();

            if (dt.Rows.Count == 0)
                dt.Rows.Add(dt.NewRow());

            GridView1.DataSource = dt;
            GridView1.DataBind();
            */
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
            return ADMIN_RES.GetByID(ID.SelectedValue);
        }
        private void GridView1_Insert()
        {
            try
            {
                ADMIN_RES vADMIN_RES = new ADMIN_RES();
                
                vADMIN_RES.ID = ID.SelectedValue;
                vADMIN_RES.EVENTOID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("EVENTOID")).SelectedValue);
                vADMIN_RES.EVENTOID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("FECHA_INICIO")).SelectedValue);
                vADMIN_RES.BANDAID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("HORARIO_INICIO")).SelectedValue);
                vADMIN_RES.BANDAID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("HORARIO_FIN")).SelectedValue);
                vADMIN_RES.SALAID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("SALA")).SelectedValue);
                vADMIN_RES.SALAID = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("SALA_CUPO")).SelectedValue);
                
                vADMIN_RES.Create();
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
                ADMIN_RES vADMIN_RES = new ADMIN_RES();

                vADMIN_RES.ID = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
                vADMIN_RES.ID = ID.SelectedValue;

                vADMIN_RES.EVENTOID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("EVENTOID")).SelectedValue);
                vADMIN_RES.EVENTOID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_INICIO")).SelectedValue);
                vADMIN_RES.BANDAID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_INICIO")).SelectedValue);
                vADMIN_RES.BANDAID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("HORARIO_FIN")).SelectedValue);
                vADMIN_RES.SALAID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA")).SelectedValue);
                vADMIN_RES.SALAID = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("SALA_CUPO")).SelectedValue);
                                
                vADMIN_RES.Update();
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
                ADMIN_RES.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void ID_SelectedIndexChanged(object sender, EventArgs e)
        {
            HyperLink1.NavigateUrl = "reserva.aspx?REP=1&ID=" + ID.SelectedValue;
            HyperLink2.NavigateUrl = "publicar.aspx?pub=http://encuentas/" + ID.Items.FindByValue(ID.SelectedValue).Text;
            
            GridView1_DataBind();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.ID_RESERVA = GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString();      
        }
      

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%"><tr><td align="center" Width="100%">
 
        <table width="90%"><tr><td><h3>ADMINISTRACION DE RESERVAS</h3></td></tr>
        
        <tr><td>
            
            <table border="1"><tr><td>RESERVA:</td><td><asp:DropDownList ID="ID" runat="server" 
                onselectedindexchanged="ID_SelectedIndexChanged" AutoPostBack="True"/></td><td> 
                    
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">VER RESERVA</asp:HyperLink>

                </td><td> <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank">PUBLICAR RESERVA</asp:HyperLink></td></tr>

            </table>

            </td></tr>
        
        <tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID"
        AllowPaging="True" 
        AllowSorting="False" 
        AutoGenerateColumns="False" 
        FooterStyle-BackColor="White" 
        CssClass="datagrid datagridBig" 
        GridLines="None" 
        runat="server"
        ShowFooter="True"
        PageSize="50" 
        
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowCancelingEdit = "GridView1_CancelingEdit" 
        OnRowCommand = "GridView1_RowCommand" 
        OnRowDataBound="GridView1_RowDataBound" 
        OnRowDeleted = "GridView1_RowDeleted"
        OnRowDeleting = "GridView1_RowDeleting" 
        OnRowEditing = "GridView1_RowEditing"
        OnRowUpdated = "GridView1_RowUpdated"           
        OnRowUpdating = "GridView1_RowUpdating" 
        BackColor="White" BorderColor="White" 
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            
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

            <asp:TemplateField HeaderText="EVENTO" SortExpression="EVENTO">
                <ItemTemplate><%# Eval("EVENTOID")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="EVENTOID" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="EVENTOID" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="FECHA_INICIO" SortExpression="FECHA_INICIO">
                <ItemTemplate><%# Eval("FECHA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="FECHA_INICIO" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="FECHA_INICIO" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="HORARIO_INICIO" SortExpression="HORARIO_INICIO">
                <ItemTemplate><%# Eval("INICIO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="HORARIO_INICIO" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="HORARIO_INICIO" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="HORARIO_FIN" SortExpression="HORARIO_FIN">
                <ItemTemplate><%# Eval("FIN")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="HORARIO_FIN" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="HORARIO_FIN" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="SALA" SortExpression="SALA">
                <ItemTemplate><%# Eval("SALAID")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="SALA" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="SALA" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>
           
             <asp:TemplateField HeaderText="SALA_CUPO" SortExpression="SALA_CUPO">
                <ItemTemplate><%# Eval("CUPO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="SALA_CUPO" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="SALA_CUPO" runat="server" Width="150px"/>
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
    <hr/>
                <asp:Label runat="server" ID="Label1" Font-Bold="True" Font-Size="Medium" ForeColor="Red" />
   <br/>
                        
                        
        </td></tr></table>


</asp:Content>
