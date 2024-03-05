<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Watch_Showroom.Cart" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">


                <div class="row">
                    <%-- row 1 --%>
                    <div class="col-sm-12">
                        <h1>Your shopping cart</h1>
                    </div>
                    <div class="col-sm-6">
                        <%-- cart display column --%>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <asp:ListBox ID="lstCart" runat="server" CssClass="form-control"></asp:ListBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <%-- cart edit buttons column --%>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <asp:Button ID="btnRemove" runat="server" Text="Remove Item" OnClick="btnRemove_Click" CssClass="btn" />
                            </div>
                            <div class="col-sm-12">
                                <asp:Button ID="btnEmpty" runat="server" Text="Empty Cart" OnClick="btnEmpty_Click" CssClass="btn" />
                            </div>
                        </div>
                    </div>
                </div>
                <%-- end of row 1 --%>

                <div class="row">
                    <%-- row 2 --%>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <%-- message label --%>
                            <asp:Label ID="lblMessage" runat="server" EnableViewState="False" CssClass="text-info col-sm-12"></asp:Label>
                        </div>
                        <div class="form-group">
                            <%-- buttons --%>
                            <div class="col-sm-6 cls-button">
                                <asp:Button ID="btnContinue" runat="server" PostBackUrl="~/Order.aspx" Text="Continue Shopping" CssClass="btn btn-success" />
                                <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" OnClick="btnCheckOut_Click" CssClass="btn btn-success" />
                            </div>
                            <div class="col-sm-6">
                                <strong><asp:Label ID="lblTotal" runat="server" EnableViewState="False" CssClass="control-label">Total:</asp:Label></strong>
                                <asp:Label ID="lblTotalCart" runat="server" EnableViewState="False" CssClass="control-label"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- end of row 2 --%>
</asp:Content>