﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teste.aspx.cs" Inherits="ProjCronoAnalise.Teste" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>    
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Bilheteria</title>
</head>    
<body>   
    <form id="form1" runat="server">
        <div>

            <asp:TextBox ID="TextBox1" runat="server" TextMode="multiline" Height="53px" Width="365px">bariu</asp:TextBox>
            <br />
            <textarea id="TextArea1" cols="40" rows="2">blauuu</textarea>
            <br />
            <asp:TextBox ID="desconto" runat="server" Width="100px">000</asp:TextBox>
            <script type="text/javascript" src="js/jquery.mask.min.js"></script>
            <script type="text/javascript">
                $(document).ready(function () {
                    $("#desconto").mask("0000,00", { reverse: true })
                })
			            </script>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" IDDataSource="ComboBox"></asp:DropDownList>
            <br />
            <div class="dropdown">
              <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Dropdown button</button>
              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                
              </div>
            </div>
            <br />
            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <asp:GridView ID="GDVUsuario" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="recnum" HeaderText="Id" />
                                <asp:BoundField DataField="login" HeaderText="Login" />
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
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
