<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CadastroTempoPadraoProducao.aspx.cs" Inherits="ProjCronoAnalise.CadastroTempoPadraoProducao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <hr />
             <div class="row" runat="server" Width="1200px">
                 &nbsp;<div class="col-sm">
                  <label for="TxtRef">Referência</label>
                    <asp:TextBox ID="TxtReferencia" CssClass="form-control" runat="server" Width="322px"></asp:TextBox> 
                </div>
                <div class="col-sm">
                  <label for="TxtDesc">Descrição</label>
                    <asp:TextBox ID="TxtDescricao" CssClass="form-control" runat="server" Width="322px"></asp:TextBox>
                </div>
                <div class="col-sm">
                  <label for="TxtIDVar">ID Variação</label>
                    <asp:TextBox ID="TxtIDVariacao" CssClass="form-control" runat="server" Width="322px"></asp:TextBox>
                </div>            
            </div>
     <br />
    &nbsp;<asp:Button ID="BtnFiltrar" runat="server" CssClass="btn btn-primary" OnClick="BtnFiltrar_Click" Text="Filtrar" Width="80px" />
     <br />    
    <br />
    <asp:GridView ID="GDVProduto" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="referencia" HeaderText="Referencia do Produto" />
                                <asp:BoundField DataField="id_variacao" HeaderText="ID da Variação" />
                                <asp:BoundField DataField="desc_produto" HeaderText="Produto" />
                            </Columns>
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" Height="53px" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>
</asp:Content>
