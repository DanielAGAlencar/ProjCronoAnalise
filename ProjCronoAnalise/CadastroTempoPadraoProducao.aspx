<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CadastroTempoPadraoProducao.aspx.cs" Inherits="ProjCronoAnalise.CadastroTempoPadraoProducao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> >
    <hr />
    <div class="row" runat="server" width="1200px">
        &nbsp;<div class="col-sm">
            <label for="TxtRef">Referência</label>
            <asp:TextBox ID="TxtReferencia" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtDescP">Descrição Produto</label>
            <asp:TextBox ID="TxtDescricaoProduto" CssClass="form-control" runat="server" Width="500px"></asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtDescV">Descrição variação</label>
            <asp:TextBox ID="TxtDescricaoVariacao" CssClass="form-control" runat="server" Width="350px"></asp:TextBox>
        </div>
        <div class="col-sm">
            <label for="TxtIDVar">ID Variação</label>
            <asp:TextBox ID="TxtIDVariacao" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
        </div>
    </div>
    <br />
    &nbsp;<asp:Button ID="BtnFiltrar" runat="server" CssClass="btn btn-primary" OnClick="BtnFiltrar_Click" Text="Filtrar" Width="80px" />
    <br />
    <br />
    <asp:GridView ID="GDVProduto" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" OnRowCommand="GDVTempoPadrao_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="referencia" HeaderText="Referência">
                <HeaderStyle Width="70px" />
            </asp:BoundField>
            <asp:BoundField DataField="id_variacao" HeaderText="ID da Variação">
                <HeaderStyle Width="70px" />
            </asp:BoundField>
            <asp:BoundField DataField="desc_produto" HeaderText="Produto" />
            <asp:BoundField DataField="desc_variacao" HeaderText="Variação" />
            <asp:BoundField DataField="id_tempopadrao" HeaderText="ID Tempo" />
            <asp:BoundField DataField="desc_operacao" HeaderText="Operação" />
            <asp:BoundField DataField="tempo" HeaderText="Tempo Padrão">
                <HeaderStyle Width="70px" />
            </asp:BoundField>            
            <asp:ButtonField ButtonType="Image" Visible="true" CommandName="A" ImageUrl="~/img/DocumentEdit_40924.png" Text="Alterar" />
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
    <div>

         <%----------------------------Modal Escolha de Ação------------------------------%>
                <div class="modal fade" id="modalTempoPadraoEscolhaAcao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Cadastro de Tempo Padrão</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblMensagemAcao" runat="server">O que deseja fazer?</asp:Label>                  
                    </div>
                    <div class="modal-footer">                        
                         <asp:Button ID="bntNovoCadastroTempo" CssClass="btn btn-primary" runat="server" Text="Novo Cadastro" Width="130px" OnClick="btnNovoCadastroTempo_Click" />
                        <asp:Button ID="bntAlterarDeletar" CssClass="btn btn-secondary" runat="server" Text="Alterar" Width="130px" OnClick="btnAlterarDeletar_Click" />
                        <asp:Button ID="bntCancelarAcao" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="130px" />
                    </div>
                </div>
            </div>
        </div>

        <%----------------------------Modal Cadastrar------------------------------%>
        <div class="modal fade" id="modalTempoPadraoCadastrar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel2">Cadastro de Tempo Padrão</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblTempoPadrao" runat="server" Text="Label">Tempo Padrão</asp:Label>
                        <asp:TextBox ID="TxtTempo" runat="server" Width="100px">0.0</asp:TextBox>
                        <script type="text/javascript" src="js/jquery.mask.min.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $("#TxtTempo").mask("0000.00", { reverse: true })
                            })
			            </script>
                        <br />
                        <asp:Label ID="LabelVariacaoCadastro" runat="server">ID Variação: </asp:Label>
                        <asp:Label ID="lblIDVariacao" runat="server"></asp:Label> 
                        <br />                        
                        <asp:Label ID="LabelOperacaoCadastro" runat="server">Operação: </asp:Label>
                        <asp:DropDownList ID="TxtOperacao" runat="server" Width="200px" ></asp:DropDownList>
                        
                    </div>
                    <div class="modal-footer">                         
                        <asp:Button ID="btnConfirm" CssClass="btn btn-primary" runat="server" Text="Confirmar" Width="130px" OnClick="btnConfirm_Click" />
                        <asp:Button ID="bntCancelar" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="130px" />
                    </div>
                </div>
            </div>
        </div>

        <%----------------------------Modal Alterar/Deletar------------------------------%>
        <div class="modal fade" id="modalTempoPadraoAlterarDeletar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel3">Alterar ou Deletar Tempo Padrão</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblTempoPadraoAlterarDeletar" runat="server" Text="Label">Tempo Padrão</asp:Label>
                        <asp:TextBox ID="TxtTempoAlterarDeletar" runat="server" Width="100px"></asp:TextBox>
                        <script type="text/javascript" src="js/jquery.mask.min.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $("#TxtTempo").mask("0000.00", { reverse: true })
                            })
			            </script>
                        <br />
                        <asp:Label ID="LabelIDTempoAlterarCancelar" runat="server">ID Tempo: </asp:Label>
                        <asp:Label ID="lblIDTempo" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="LabelIDVariacaoAlterarCancelar" runat="server">ID Variação: </asp:Label>
                        <asp:Label ID="lblIDVariacaoAlterarDeletar" runat="server"></asp:Label> 
                        <br />                        
                        <asp:Label ID="LabelOperacaoAlterarCancelar" runat="server">Operação: </asp:Label>
                        <asp:Label ID="lblOperacaoAlterarDeletar" runat="server"></asp:Label>
                        
                    </div>
                    <div class="modal-footer">                   
                        <asp:Button ID="bntAlterar" CssClass="btn btn-primary" runat="server" Text="Alterar" Width="130px" OnClick="btnAlterar_Click" />
                        <asp:Button ID="bntDeletar" CssClass="btn btn-warning" runat="server" Text="Deletar" Width="130px" OnClick="btnDeletar_Click" />
                        <asp:Button ID="bntCancelarAlterarDeletar" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="130px" />
                    </div>
                </div>
            </div>
        </div>

        <%----------------------------Modal Mensagem--------------------------------%>
        <div class="modal fade" id="modalMsg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabelMsg">Messagem!</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="modal-footer">
                        <asp:Button ID="bntOk" CssClass="btn btn-primary" runat="server" Text="Ok" Width="130px" />
                    </div>
                        </div>
                    </div>
                </div>
    </div>
</asp:Content>
