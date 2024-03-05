<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Watch_Showroom.Products" EnableEventValidation="false"%>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="col-sm-4 cls-Watch">
                    <div class="thumbnail">
                        <img src='/Images/Watch/<%# Eval("ImageFile") %>' 
                            alt='<%# Eval("Name") %>' />
                        <div class="caption">
                            <h3><%# Eval("Name") %></h3>
                            <p><b>Price: <%# Eval("UnitPrice", "{0:c}") %></b>
                            <br><br><%# Eval("LongDescription") %></p>
                        </div>
                        <div class="cls-button">
                             <asp:Button ID="btnBuyProduct" runat="server" Text="Buy" CssClass="btn btn-success" OnClick="btnBuyProduct_Click" CommandArgument='<%# Eval("WatchID") %>' />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceByCategory"
        ConnectionString='<%$ ConnectionStrings:Watch_ShowroomConnection %>'
        SelectCommand="SELECT [WatchID], [Name], [LongDescription], 
        [UnitPrice], [ImageFile] FROM [Watch] 
        WHERE ([TypeID] = @TypeID) ORDER BY [Name]">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="TypeID" 
                Name="TypeID" Type="String"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceAll"
        ConnectionString='<%$ ConnectionStrings:Watch_ShowroomConnection %>'
        SelectCommand="SELECT [WatchID], [Name], [LongDescription], 
        [UnitPrice], [ImageFile] FROM [Watch] ORDER BY [Name]">
    </asp:SqlDataSource>
    
</asp:Content>
