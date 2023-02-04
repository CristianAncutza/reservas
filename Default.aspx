<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <table width="100%">

    <tr><td align="center">

        <table border="1" >
                <tr><td class="auto-style1">01</td><td align="left"><a href="evento.aspx">EVENTO<br/>Define eventos para luego ser utilizados en reservas.</a></td></tr>    
                <tr><td class="auto-style1">02</td><td align="left"><a href="sala.aspx">SALA<br/>Define salas para luego ser utilizadas en reservas.</a></td></tr>
                <tr><td class="auto-style1">03</td><td align="left"><a href="banda.aspx">BANDA<br/>Define la banda horaria de cada evento.</a></td></tr>
                <tr><td class="auto-style1">04</td><td align="left"><a href="evento_sala.aspx">EVENTO_SALA<br/>Define las salas para cada evento.</a></td></tr>
                <tr><td class="auto-style1">05</td><td align="left"><a href="admin_res.aspx">RESERVA<br/>Administracion de reservas.</a></td></tr>
                <tr><td class="auto-style1">06</td><td align="left"><a href="usuario.aspx">USUARIO<br/>Define pefiles de usuarios.</a></td></tr>                                
        </table>

        </td></tr></table>

</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            width: 49px;
        }
    </style>
</asp:Content>
