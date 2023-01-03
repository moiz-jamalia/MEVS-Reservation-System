<%@ Page Title="MEVS - Add Manufacturer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddManufacturer.aspx.cs"
    Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.AddManufacturer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <span class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </span>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="GVStyle">

    <asp:Label Text="Manufacturers" runat="server" CssClass="labelStyle" />

    <asp:GridView ID="gvManufacturers" runat="server" CssClass="table--centered table table is-striped" HeaderStyle-CssClass="thead" 
        RowStyle-CssClass="tr" AutoGenerateColumns="false" OnRowCancelingEdit="GvManufacturers_RowCancelingEdit" 
        OnRowDeleting="GvManufacturers_RowDeleting" OnRowEditing="GvManufacturers_RowEditing" >

        <Columns>

            <asp:BoundField DataField="ID" HeaderText="ID" />
            <asp:BoundField DataField="Bezeichnung" HeaderText="Designation" />

            <asp:CommandField ShowEditButton="true" />
            <asp:CommandField ShowDeleteButton="true" />
        </Columns>

    </asp:GridView>
    <br />
    <br />

    <asp:TextBox ID="tbaddManufacturers" runat="server" placeholder="Manufacturer Designation" style="max-width: 27.5vh !important;" CssClass="input" />
    <asp:RequiredFieldValidator ID="reqFieldVal30" ErrorMessage="!" ControlToValidate="tbaddManufacturers" runat="server" CssClass="validator" Display="Dynamic" />
    <asp:Button ID="btnAddManufacturer" Text="Add Manufacturer" runat="server" OnClick="BtnAddManufacturer_Click" style="margin-top: 2vh !important;"
        CssClass="button_background_color button is-rounded is-link" />

    </div>
</asp:Content>
