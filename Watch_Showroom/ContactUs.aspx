<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Watch_Showroom.ContactUs" %>
<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <div class="col-xs-12 table-responsive">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Number/Address</th>
                        <th>Extension</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>General</td><td>555-555-5555</td><td>0</td>
                    </tr>
                    <tr>
                        <td>Customer Service</td><td>555-555-5555</td><td>10</td>
                    </tr>
                    <tr>
                        <td>Billing & Accounts</td><td>555-555-5555</td><td>20</td>
                    </tr>
                    <tr>
                        <td>Mailing Address</td><td>001, Foxhunt Road, Waterloo</td><td></td>
                    </tr>
                    <tr>
                        <td>Email Address</td><td>info@watches.com</td><td></td>
                    </tr>
                    <tr>
                        <td>FaceWatch</td><td>www.faceWatch.com/watches</td><td></td>
                    </tr>
                    <tr>
                        <td>Twitter</td><td>www.twitter.com/watches</td><td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
