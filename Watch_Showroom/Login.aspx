<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Watch_Showroom.Login" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">

    <div class="col-sm-6">
        <h3 class="col-sm-9 text-center">Customer</h3>
        <div class="form-group col-sm-12">
            <label class="control-label col-sm-3">First Name:</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-4">
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                    ErrorMessage="Required" CssClass="text-danger"
                    ValidationGroup="CustomerValidation"
                    Display="Dynamic" ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="form-group col-sm-12">
            <label class="control-label col-sm-3">Last Name:</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-4">
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                    ErrorMessage="Required" CssClass="text-danger"
                    ValidationGroup="CustomerValidation"
                    Display="Dynamic" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-offset-3 col-sm-9" style="margin-bottom: 20px;">
        <asp:Label ID="Label2" runat="server" CssClass="text-danger"></asp:Label>
    </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <asp:Button ID="btnContinue" runat="server" Text="Login" CssClass="btn btn-success"
                    OnClick="btnContinue_Click" ValidationGroup="CustomerValidation" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-danger"
                    OnClick="btnLogout_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn"
                    CausesValidation="False" PostBackUrl="~/Order.aspx" />

            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <h3 class="col-sm-9 text-center">Admin</h3>
        <div class="form-group col-sm-12">
            <label class="control-label col-sm-3">User Name:</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-4">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ErrorMessage="Required" CssClass="text-danger"
                    ValidationGroup="AdminValidation"
                    Display="Dynamic" ControlToValidate="txtUserName"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div id="divPassword" class="form-group col-sm-12" runat="server">
            <label class="control-label col-sm-3">Password:</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-4">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ErrorMessage="Required" CssClass="text-danger"
                    ValidationGroup="AdminValidation"
                    Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-offset-3 col-sm-9" style="margin-bottom: 20px;">
                <asp:Label ID="lblAdminLoginError" runat="server" CssClass="text-danger"></asp:Label>
            </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <asp:Button ID="btnContinueAdmin" runat="server" Text="Login" CssClass="btn btn-success"
                    OnClick="btnContinueAdmin_Click" ValidationGroup="AdminValidation" />
                <asp:Button ID="btnLogoutAdmin" runat="server" Text="Logout" CssClass="btn btn-danger"
                    OnClick="btnLogoutAdmin_Click" />
                <asp:Button ID="btnCancelAdmin" runat="server" Text="Cancel" CssClass="btn btn"
                    CausesValidation="False" PostBackUrl="~/Order.aspx" />

            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:Watch_ShowroomConnection %>"
        SelectCommand="SELECT * FROM Adminuser WHERE UserName = @UserName AND Password = @Password">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="UserName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtPassword" Name="Password" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

