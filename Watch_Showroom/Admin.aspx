<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Watch_Showroom.Admin" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <details open="open" class="cls-details">
        <summary class="cls-summary">Part 1</summary>
        <div class="form-group">
            <label id="lblType" for="ddlType"
                class="col-xs-4 col-sm-offset-1 col-sm-3 control-label">
                Choose a Type:</label>
            <div class="col-xs-8 col-sm-5">
                <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true"
                    DataSourceID="SqlDataSource11" DataTextField="LongName"
                    DataValueField="TypeID" CssClass="form-control">
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="SqlDataSource11"
                    ConnectionString='<%$ ConnectionStrings:Watch_ShowroomConnection %>'
                    SelectCommand="SELECT [TypeID], [LongName] FROM [Type] 
                ORDER BY [LongName]"></asp:SqlDataSource>
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-12 col-sm-offset-1 col-sm-9">
                <asp:DataList ID="dlWatch" runat="server"
                    DataKeyField="WatchID" DataSourceID="SqlDataSource12"
                    CssClass="table table-bordered table-striped table-condensed">
                    <HeaderTemplate>
                        <span class="col-xs-3">ID</span>
                        <span class="col-xs-3">Watch</span>
                        <span class="col-xs-3 text-right">Unit Price</span>
                        <span class="col-xs-3 text-right">On Hand</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("WatchID") %>' CssClass="col-xs-3" />
                        <asp:Label ID="lblName" runat="server"
                            Text='<%# Eval("Name") %>' CssClass="col-xs-3" />
                        <asp:Label ID="lblUnitPrice" runat="server"
                            Text='<%# Eval("UnitPrice", "{0:C}") %>' CssClass="col-xs-3 text-right" />
                        <asp:Label ID="lblOnHand" runat="server"
                            Text='<%# Eval("OnHand") %>' CssClass="col-xs-3 text-right" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="bg-halloween" />
                </asp:DataList>
                <asp:SqlDataSource ID="SqlDataSource12" runat="server"
                    ConnectionString="<%$ ConnectionStrings:Watch_ShowroomConnection %>"
                    SelectCommand="SELECT [WatchID], [Name], [UnitPrice], [OnHand] 
                FROM [Watch] WHERE ([TypeID] = @TypeID) 
                ORDER BY [WatchID]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlType" Name="TypeID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>

    </details>
    <details open="open" class="cls-details">
        <summary class="cls-summary">Part 2</summary>
        <div class="form-group">
            <div class="col-xs-12 table-responsive">
                <h1>Type Maintenance</h1>
                <asp:GridView ID="grdCategories" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="TypeID"
                    DataSourceID="SqlDataSource21"
                    CssClass="table table-bordered table-condensed"
                    OnPreRender="grdCategories_PreRender"
                    OnRowDeleted="grdCategories_RowDeleted"
                    OnRowUpdated="grdCategories_RowUpdated">
                    <Columns>
                        <asp:BoundField DataField="TypeID" HeaderText="ID"
                            ReadOnly="True">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Short Name">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox ID="txtGridShortName" runat="server"
                                        MaxLength="15" CssClass="form-control"
                                        Text='<%# Bind("ShortName") %>'></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3GridShortName" runat="server"
                                    ControlToValidate="txtGridShortName" SetFocusOnError="true" ValidationGroup="Edit2"
                                    ErrorMessage="Short Name is a required field" Text="*"
                                    CssClass="text-danger"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblGridShortName" runat="server"
                                    Text='<%# Bind("ShortName") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="col-xs-4" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Long Name">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox ID="txtGridLongName" runat="server"
                                        MaxLength="50" CssClass="form-control"
                                        Text='<%# Bind("LongName") %>'></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3GridLongName" runat="server"
                                    ControlToValidate="txtGridLongName" SetFocusOnError="true" ValidationGroup="Edit2"
                                    Text="*" ErrorMessage="Long Name is a required field"
                                    CssClass="text-danger"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblGridLongName" runat="server"
                                    Text='<%# Bind("LongName") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="col-xs-5" />
                        </asp:TemplateField>
                        <asp:CommandField CausesValidation="True"
                            ShowEditButton="True"  ValidationGroup="Edit2">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:CommandField>
                        <asp:CommandField ShowDeleteButton="True">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle CssClass="bg-halloween" />
                    <AlternatingRowStyle CssClass="altRow" />
                    <EditRowStyle CssClass="warning" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource21" runat="server"
                    ConnectionString="<%$ ConnectionStrings:Watch_ShowroomConnection %>"
                    ConflictDetection="CompareAllValues"
                    OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [TypeID], [ShortName], [LongName] 
             FROM [Type]"
                    DeleteCommand="DELETE FROM [Type] 
             WHERE [TypeID] = @original_TypeID 
               AND [ShortName] = @original_ShortName 
               AND [LongName] = @original_LongName"
                    InsertCommand="INSERT INTO [Type] 
             ([TypeID], [ShortName], [LongName]) 
             VALUES (@TypeID, @ShortName, @LongName)"
                    UpdateCommand="UPDATE [Type] 
               SET [ShortName] = @ShortName, 
                   [LongName] = @LongName 
             WHERE [TypeID] = @original_CategoryID 
               AND [ShortName] = @original_ShortName 
               AND [LongName] = @original_LongName">
                    <DeleteParameters>
                        <asp:Parameter Name="original_CategoryID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_LongName" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TypeID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="LongName" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="LongName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_CategoryID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_LongName" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                    HeaderText="Please correct the following errors:"
                    SetFocusOnError="true" ValidationGroup="Edit2" CssClass="text-danger" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-xs-12">
                <p>
                    To create a new Type, enter the Type information 
         and click Add New Type
                </p>
                <p>
                    <asp:Label ID="Label1" runat="server" EnableViewState="false"
                        CssClass="text-danger"></asp:Label>
                </p>

                <div class="form-group">
                    <label for="txtID2" class="col-sm-2">ID</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtID2" runat="server" MaxLength="10"
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-offset-3 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvID" runat="server"
                            ControlToValidate="txtID2" CssClass="text-danger"
                            SetFocusOnError="true" ValidationGroup="Edit22"
                            ErrorMessage="ID is a mandatory field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="txtShortName2" class="col-sm-2">Short Name</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtShortName2" runat="server" MaxLength="15"
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-offset-2 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvShortName" runat="server"
                            ControlToValidate="txtShortName2" CssClass="text-danger"
                            SetFocusOnError="true" ValidationGroup="Edit22"
                            ErrorMessage="Short Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="txtLongName2" class="col-sm-2">Long Name</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLongName2" runat="server" MaxLength="50"
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvLongName" runat="server"
                            ControlToValidate="txtLongName2" CssClass="text-danger"
                            SetFocusOnError="true" ValidationGroup="Edit22"
                            ErrorMessage="Long Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>

                <asp:Button ID="btnAdd" runat="server" Text="Add New Type" SetFocusOnError="true" ValidationGroup="Edit22"
                    CssClass="btn" OnClick="btnAdd_Click" />
            </div>

            <asp:ValidationSummary ID="ValidationSummary3" runat="server"
                HeaderText="Please correct the following errors:"
                SetFocusOnError="true" ValidationGroup="Edit22" CssClass="text-danger" />
        </div>
    </details>
    <details open="open" class="cls-details">
        <summary class="cls-summary">Part 3</summary>
        <div class="form-group">
            <div class="col-sm-6 table-responsive">
                <asp:GridView ID="grdWatch" runat="server" SelectedIndex="0" PageSize="5"
                    AutoGenerateColumns="False" DataKeyNames="WatchID"
                    DataSourceID="SqlDataSource31" AllowPaging="True"
                    CssClass="table table-bordered table-striped table-condensed"
                    OnPreRender="grdWatch_PreRender" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="WatchID" HeaderText="ID" SortExpression="WatchID"
                            ReadOnly="True">
                            <ItemStyle CssClass="col-xs-2" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                            <ItemStyle CssClass="col-xs-6" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TypeID" HeaderText="Type" SortExpression="TypeID">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Link" ShowSelectButton="true">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle CssClass="bg-halloween" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle CssClass="pagerStyle"
                        BackColor="#8c8c8c" HorizontalAlign="Center" />
                    <SelectedRowStyle CssClass="warning" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource31" runat="server"
                    ConnectionString="<%$ ConnectionStrings:Watch_ShowroomConnection %>"
                    SelectCommand="SELECT [WatchID], [Name], [TypeID], 
        [UnitPrice], [OnHand] FROM [Watch] ORDER BY [Name]"></asp:SqlDataSource>
            </div>

            <div class="col-sm-6">
                <asp:DetailsView ID="dvWatch" runat="server"
                    DataSourceID="SqlDataSource32" DataKeyNames="WatchID"
                    AutoGenerateRows="False"
                    CssClass="table table-bordered table-condensed"
                    OnItemDeleted="dvWatch_ItemDeleted"
                    OnItemDeleting="dvWatch_ItemDeleting"
                    OnItemInserted="dvWatch_ItemInserted"
                    OnItemUpdated="dvWatch_ItemUpdated">
                    <Fields>
                        <asp:TemplateField HeaderText="Watch ID">
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblWatchID"
                                    Text='<%# Eval("WatchID") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtWatchID"
                                        Text='<%# Bind("WatchID") %>' MaxLength="10"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3WatchID" runat="server"
                                    ControlToValidate="txtWatchID" CssClass="text-danger"
                                    SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="WatchID is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblWatchID"
                                    Text='<%# Bind("WatchID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="col-xs-4" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtName"
                                        Text='<%# Bind("Name") %>' MaxLength="50"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3Name" runat="server"
                                    ControlToValidate="txtName" CssClass="text-danger"
                                    SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Name is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtName"
                                        Text='<%# Bind("Name") %>' MaxLength="50"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3Name" runat="server"
                                    ControlToValidate="txtName" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Name is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblName"
                                    Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Short Description">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtShortDesc"
                                        Text='<%# Bind("ShortDescription") %>' MaxLength="250"
                                        TextMode="MultiLine" Rows="4"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3ShortDesc" runat="server"
                                    ControlToValidate="txtShortDesc" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Short Description is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtShortDesc"
                                        Text='<%# Bind("ShortDescription") %>' MaxLength="250"
                                        TextMode="MultiLine" Rows="4"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3ShortDesc" runat="server"
                                    ControlToValidate="txtShortDesc" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Short Description is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblShortDesc"
                                    Text='<%# Bind("ShortDescription") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Long Description">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtLongDesc"
                                        Text='<%# Bind("LongDescription") %>' MaxLength="2000"
                                        TextMode="MultiLine" Rows="4"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3LongDesc" runat="server"
                                    ControlToValidate="txtLongDesc" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Long Description is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtLongDesc"
                                        Text='<%# Bind("LongDescription") %>' MaxLength="2000"
                                        TextMode="MultiLine" Rows="4"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3LongDesc" runat="server"
                                    ControlToValidate="txtLongDesc" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Long Description is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLongDesc"
                                    Text='<%# Bind("LongDescription") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:DropDownList runat="server" ID="ddlType"
                                        DataSourceID="SqlDataSource33"
                                        DataTextField="LongName" DataValueField="TypeID"
                                        SelectedValue='<%# Bind("TypeID") %>'
                                        CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:DropDownList runat="server" ID="ddlType"
                                        DataSourceID="SqlDataSource33"
                                        DataTextField="LongName" DataValueField="TypeID"
                                        SelectedValue='<%# Bind("TypeID") %>'
                                        CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblType"
                                    Text='<%# Bind("TypeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ImageFile">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtImageFile"
                                        Text='<%# Bind("ImageFile") %>' MaxLength="30"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtImageFile"
                                        Text='<%# Bind("ImageFile") %>' MaxLength="30"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblImageFile"
                                    Text='<%# Bind("ImageFile") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit Price">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtUnitPrice"
                                        Text='<%# Bind("UnitPrice") %>'
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3UnitPrice" runat="server"
                                    ControlToValidate="txtUnitPrice" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Unit Price is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvUnitPrice" runat="server"
                                    ControlToValidate="txtUnitPrice" Type="Double" Operator="GreaterThan" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Unit Price must be a decimal value greater than 0." Text="*"
                                    CssClass="text-danger" ValueToCompare="0.00"></asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtUnitPrice"
                                        Text='<%# Bind("UnitPrice") %>'
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3UnitPrice" runat="server"
                                    ControlToValidate="txtUnitPrice" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="Unit Price is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvUnitPrice" runat="server"
                                    ControlToValidate="txtUnitPrice" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    Type="Currency" Operator="DataTypeCheck"
                                    ErrorMessage="Unit Price must be numeric." Text="*">
                                </asp:CompareValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUnitPrice"
                                    Text='<%# Bind("UnitPrice", "{0:C}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="On Hand">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:TextBox runat="server" ID="txtOnHand"
                                        Text='<%# Bind("OnHand") %>'
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3OnHand" runat="server"
                                    ControlToValidate="txtOnHand" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="On Hand is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvOnHand" runat="server"
                                    ControlToValidate="txtOnHand" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    Type="Integer" Operator="DataTypeCheck"
                                    ErrorMessage="On Hand must be numeric." Text="*">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:TextBox runat="server" ID="txtOnHand"
                                        Text='<%# Bind("OnHand") %>'
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv3OnHand" runat="server"
                                    ControlToValidate="txtOnHand" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    ErrorMessage="On Hand is a required field." Text="*">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvOnHand" runat="server"
                                    ControlToValidate="txtOnHand" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="Edit3"
                                    Type="Integer" Operator="DataTypeCheck"
                                    ErrorMessage="On Hand must be numeric." Text="*">
                                </asp:CompareValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblOnHand"
                                    Text='<%# Bind("OnHand") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Link"
                            ShowDeleteButton="true"
                            ShowEditButton="true"
                            ShowInsertButton="true" ValidationGroup="Edit3"/>
                    </Fields>
                    <RowStyle BackColor="#e7e7e7" />
                    <CommandRowStyle BackColor="#8c8c8c" ForeColor="white" />
                </asp:DetailsView>
                <asp:SqlDataSource ID="SqlDataSource32" runat="server"
                    ConnectionString="<%$ ConnectionStrings:Watch_ShowroomConnection %>"
                    ConflictDetection="CompareAllValues"
                    OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [WatchID], [Name], [ShortDescription], 
            [LongDescription], [TypeID], [ImageFile], 
            [UnitPrice], [OnHand] 
        FROM [Watch] 
        WHERE ([WatchID] = @WatchID)"
                    DeleteCommand="DELETE FROM [Watch] 
        WHERE [WatchID] = @original_WatchID 
          AND [Name] = @original_Name 
          AND [ShortDescription] = @original_ShortDescription 
          AND [LongDescription] = @original_LongDescription 
          AND [TypeID] = @original_TypeID 
          AND (([ImageFile] = @original_ImageFile) 
           OR ([ImageFile] IS NULL AND @original_ImageFile IS NULL))
          AND [UnitPrice] = @original_UnitPrice 
          AND [OnHand] = @original_OnHand"
                    InsertCommand="INSERT INTO [Watch] ([WatchID], [Name], 
          [ShortDescription], [LongDescription], [TypeID], 
          [ImageFile], [UnitPrice], [OnHand]) 
        VALUES (@WatchID, @Name, @ShortDescription, 
          @LongDescription, @TypeID, @ImageFile,  
          @UnitPrice, @OnHand)"
                    UpdateCommand="UPDATE [Watch] SET [Name] = @Name, 
          [ShortDescription] = @ShortDescription, 
          [LongDescription] = @LongDescription, 
          [TypeID] = @TypeID, 
          [ImageFile] = @ImageFile, 
          [UnitPrice] = @UnitPrice, 
          [OnHand] = @OnHand 
        WHERE [WatchID] = @original_WatchID 
          AND [Name] = @original_Name 
          AND [ShortDescription] = @original_ShortDescription 
          AND [LongDescription] = @original_LongDescription
          AND [TypeID] = @original_TypeID 
          AND (([ImageFile] = @original_ImageFile) 
           OR ([ImageFile] IS NULL AND @original_ImageFile IS NULL))
          AND [UnitPrice] = @original_UnitPrice 
          AND [OnHand] = @original_OnHand">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="grdWatch" Name="WatchID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="original_WatchID" Type="String" />
                        <asp:Parameter Name="original_Name" Type="String" />
                        <asp:Parameter Name="original_ShortDescription" Type="String" />
                        <asp:Parameter Name="original_LongDescription" Type="String" />
                        <asp:Parameter Name="original_TypeID" Type="String" />
                        <asp:Parameter Name="original_ImageFile" Type="String" />
                        <asp:Parameter Name="original_UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="original_OnHand" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="ShortDescription" Type="String" />
                        <asp:Parameter Name="LongDescription" Type="String" />
                        <asp:Parameter Name="TypeID" Type="String" />
                        <asp:Parameter Name="ImageFile" Type="String" />
                        <asp:Parameter Name="UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="OnHand" Type="Int32" />
                        <asp:Parameter Name="original_WatchID" Type="String" />
                        <asp:Parameter Name="original_Name" Type="String" />
                        <asp:Parameter Name="original_ShortDescription" Type="String" />
                        <asp:Parameter Name="original_LongDescription" Type="String" />
                        <asp:Parameter Name="original_TypeID" Type="String" />
                        <asp:Parameter Name="original_ImageFile" Type="String" />
                        <asp:Parameter Name="original_UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="original_OnHand" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="WatchID" Type="String" />
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="ShortDescription" Type="String" />
                        <asp:Parameter Name="LongDescription" Type="String" />
                        <asp:Parameter Name="TypeID" Type="String" />
                        <asp:Parameter Name="ImageFile" Type="String" />
                        <asp:Parameter Name="UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="OnHand" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource33" runat="server"
                    ConnectionString='<%$ ConnectionStrings:Watch_ShowroomConnection %>'
                    SelectCommand="SELECT [TypeID], [LongName] 
        FROM [Type] ORDER BY [LongName]"></asp:SqlDataSource>

                <p>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                        HeaderText="Please correct the following errors:" SetFocusOnError="true" ValidationGroup="Edit3"
                        CssClass="text-danger" />
                </p>
                <p>
                    <asp:Label ID="lblError" runat="server"
                        EnableViewState="false" CssClass="text-danger"></asp:Label>
                </p>
            </div>
        </div>
    </details>

</asp:Content>
