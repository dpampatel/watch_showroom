<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Watch_Showroom.Confirmation" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">


        
        <div class="form-group">
          <asp:TextBox ID="txtData" runat="server" TextMode="MultiLine" CssClass="form-control" Columns="50" Rows="25"></asp:TextBox>
        </div>

        <div class="form-group cls-buttons">
          <asp:Button ID="btnContinue" runat="server" CssClass="btn btn-success" PostBackUrl="~/Order.aspx" Text="Continue Shopping" />
        </div>

 </asp:Content>