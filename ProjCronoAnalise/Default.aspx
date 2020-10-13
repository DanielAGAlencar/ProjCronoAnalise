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
                <asp:ListItem>PAUSADO</asp:ListItem>
                <asp:ListItem>CANCELADO</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <br />
    &nbsp;<asp:Button ID="BtnFiltrar" runat="server" CssClass="btn btn-primary" OnClick="BtnFiltrar_Click" Text="Filtrar" Width="150px" />
    &nbsp;<asp:Button ID="BtnIniciar" runat="server" CssClass="btn btn-primary" OnClick="BtnIniciarProducao_Click" Text="Iniciar Produção" Width="150px" />
    <br />
    <br />
    <asp:GridView ID="GDVFichaTempo" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" OnRowCommand="GDVFichaTempo_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="recnum" HeaderText="Id" />
            <asp:BoundField DataField="ficha" HeaderText="Ficha" />
            <asp:BoundField DataField="operacao" HeaderText="Operação" />
            <asp:BoundField DataField="desc_produto" HeaderText="Produto" />
            <asp:BoundField DataField="inicio" HeaderText="Inicio" />
            <asp:BoundField DataField="fim" HeaderText="Fim" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" />
            <asp:BoundField DataField="observacao" HeaderText="Obsevação" />
            <asp:BoundField DataField="situacao" HeaderText="Situação" />
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
        <%----------------------------Modal Iniciar Produção------------------------------%>
        <div class="modal fade" id="modalIniciarProducao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
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

        <%----------------------------Modal Pausar Finalizar Cancelar Produção------------------------------%>
        <div class="modal fade" id="modalPausarFinalizarCancelarProducao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabelPausarCancelarProducao">Pausar/Cancelar Produção</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="LabelID" runat="server" Text="Label">ID: </asp:Label>
                        <asp:Label ID="lblIDPausarCancelar" runat="server" Text="Label"></asp:Label>
                        <br />
                        <asp:Label ID="LabelFicha" runat="server" Text="Label">Ficha: </asp:Label>
                        <asp:Label ID="lblFichaPausarCancelar" runat="server" Text="Label"></asp:Label>
                        <br />
                        <asp:Label ID="LabelOperacao" runat="server" Text="Label">Operação: </asp:Label>
                        <asp:Label ID="lblOperacaoPausarCancelar" runat="server" Text="Label"></asp:Label>
                        <br />
                        <asp:Label ID="LabelSituacao" runat="server" Text="Label">Situação: </asp:Label>
                        <asp:Label ID="lblSituacaoPausarCancelar" runat="server" Text="Label"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblObs2" runat="server" Text="Label">Observação: </asp:Label>
                        <br />
                        <asp:TextBox ID="lblObsPausarCancelar" runat="server" TextMode="multiline" Height="55px" Width="365px"></asp:TextBox>
                        <br />
                        <asp:Label ID="LabelDesconto" runat="server" Text="Label">Desconto: </asp:Label>
                        <asp:TextBox ID="lblDescontoPausarCancelar" runat="server" Width="100px">0.0</asp:TextBox>
                        </div>
                        <div class="modal-body">
                            <asp:Button ID="bntConfirmPausa" CssClass="btn btn-primary" runat="server" Text="Pausar Produção" Width="160px" OnClick="btnConfirmPausaProducao_Click" />
                            <asp:Button ID="bntConfirmFinalizarX" CssClass="btn btn-primary" runat="server" Text="Finalizar Produção" Width="160px" OnClick="btnConfirmFinalizarProducaoX_Click" />
                            <asp:Button ID="bntConfirmCancelar" CssClass="btn btn-primary" runat="server" Text="Cancelar Produção" Width="160px" OnClick="btnConfirmCancelarProducao_Click" />                            
                            <asp:Button ID="bntCancelar2" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="160px" />
                        </div>
                    </div>
                </div>
            </div>

            <%----------------------------Modal Finalizar Iniciar Cancelar------------------------------%>
            <div class="modal fade" id="modalFinalizarIniciarCancelarProducao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabelFinalizarCancelarProducao">Finalizar/Cancelar Produção</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="LabelIDX" runat="server" Text="Label">ID: </asp:Label>
                            <asp:Label ID="lblIDFinalizarCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabelFichaX" runat="server" Text="Label">Ficha: </asp:Label>
                            <asp:Label ID="lblFichaFinalizarCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabeloperacaoX" runat="server" Text="Label">Operação: </asp:Label>
                            <asp:Label ID="lblOperacaoFinalizarCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabelSituacaoX" runat="server" Text="Label">Situação: </asp:Label>
                            <asp:Label ID="lblSituacaoFinalizarCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <br />
                            <asp:Label ID="lblObs3" runat="server" Text="Label">Observação: </asp:Label>
                            <br />
                            <asp:TextBox ID="lblObsFinalizarCancelar" runat="server" TextMode="multiline" Height="55px" Width="365px"></asp:TextBox>
                            <br />
                            <asp:Label ID="lblDescontoX" runat="server" Text="Label">Desconto: </asp:Label>
                            <asp:TextBox ID="lblDescontoFinalizarCancelar" runat="server" Width="100px">0.0</asp:TextBox>
                        </div>
                        <div class="modal-body">
                            <asp:Button ID="bntConfirmFinalizar" CssClass="btn btn-primary" runat="server" Text="Finalizar Produção" Width="160px" OnClick="btnConfirmFinalizarProducao_Click" />
                            <asp:Button ID="bntConfirmReiniciar" CssClass="btn btn-primary" runat="server" Text="Reiniciar Produção" Width="160px" OnClick="btnConfirmReiniciarProducao_Click" />
                            <asp:Button ID="bntConfirmCancelar2" CssClass="btn btn-primary" runat="server" Text="Cancelar Produção" Width="160px" OnClick="btnConfirmCancelarProducao2_Click" />
                            <asp:Button ID="bntCancelar3" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="160px" />
                        </div>
                    </div>
                </div>
            </div>

                    <%----------------------------Modal Cancelar------------------------------%>
            <div class="modal fade" id="modalCancelarProducao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabelCancelarProducao">Finalizar/Cancelar Produção</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="LabelIDC" runat="server" Text="Label">ID: </asp:Label>
                            <asp:Label ID="lblIDCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabelFichaC" runat="server" Text="Label">Ficha: </asp:Label>
                            <asp:Label ID="lblFichaCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabelOperacaoC" runat="server" Text="Label">Operação: </asp:Label>
                            <asp:Label ID="lblOperacaoCancelar" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="LabelSituacaoC" runat="server" Text="Label">Situação: </asp:Label>
                            <asp:Label ID="lblSituacaoCancelar" runat="server" Text="Label"></asp:Label>
                            <br />                            
                            <br />
                            <asp:Label ID="LabelObservacaoC" runat="server" Text="Label">Observação: </asp:Label>
                            <br />
                            <asp:TextBox ID="lblObeservacaoCancelar" runat="server" TextMode="multiline" Height="55px" Width="365px"></asp:TextBox>
                        </div>
                        <div class="modal-body">
                            <asp:Button ID="bntCancelarProducao" CssClass="btn btn-primary" runat="server" Text="Cancelar Produção" Width="160px" OnClick="btnConfirmCancelarProducao3_Click" />
                            <asp:Button ID="bntCancelar4" CssClass="btn btn-danger" runat="server" Text="Cancelar" Width="160px" />
                        </div>
                    </div>
                </div>
            </div>

            <%----------------------------Modal Mensagem--------------------------------%>
            <div class="modal fade" id="modalMsgDefault" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
