<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjCronoAnalise.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <div class="row" runat="server">
        &nbsp;<div class="col-sm">
            <label for="TxtF">Ficha</label>
            <asp:TextBox ID="TxtFicha_f" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtDescP">Descrição Produto</label>
            <asp:TextBox ID="TxtDescricaoProduto_f" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtDataC">Data de Criação</label>
            <asp:TextBox ID="TxtDataCriacao_f" CssClass="form-control" runat="server">01-01-2020</asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtSituacao">Situação</label>
            <br />
            <asp:DropDownList ID="TxtSituacao_f" runat="server" class="btn btn-light dropdown-toggle" Height="38px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>FINALIZADO</asp:ListItem>
                <asp:ListItem>INICIADO</asp:ListItem>
                <asp:ListItem>RASCUNHO</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <br />
    &nbsp;<asp:Button ID="BtnFiltrar" runat="server" CssClass="btn btn-primary" OnClick="BtnFiltrar_Click" Text="Filtrar" Width="130px" />
    &nbsp;<asp:Button ID="BtnIniciar" runat="server" CssClass="btn btn-primary" OnClick="BtnIniciarProducao_Click" Text="Iniciar Produção" Width="130px" />
    <br />
    <br />
    <asp:GridView ID="GDVFichaTempo" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="recnum" HeaderText="Id" />
            <asp:BoundField DataField="ficha" HeaderText="Ficha" />
            <asp:BoundField DataField="operacao" HeaderText="Operação" />
            <asp:BoundField DataField="desc_produto" HeaderText="Produto" />
            <asp:BoundField DataField="inicio" HeaderText="Inicio" />
            <asp:BoundField DataField="fim" HeaderText="Fim" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" />
            <asp:BoundField DataField="situacao" HeaderText="Situação" />
            <%--<asp:ButtonField ButtonType="Image" Visible="true" CommandName="A" ImageUrl="~/img/DocumentEdit_40924.png" Text="Alterar" />--%>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" Height="53px" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <%----------------------------Modal Cadastrar------------------------------%>
    <div class="modal fade" id="modalIniciarProducao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabelIniciar">Iniciar Produção</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblFicha" runat="server" Text="Label">Ficha</asp:Label>
                    <asp:TextBox ID="TxtFicha" runat="server" Width="100px"></asp:TextBox>
                    <br />
                    <asp:Label ID="LabelOperacaoCadastro" runat="server">Operação: </asp:Label>
                    <asp:DropDownList ID="TxtOperacao" runat="server" Width="200px"></asp:DropDownList>

                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnConfirmIniciarProducao" CssClass="btn btn-primary" runat="server" Text="Confirmar" Width="130px" OnClick="btnConfirmIniciarProducao_Click" />
                    <asp:Button ID="bntCancelar" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="130px" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
