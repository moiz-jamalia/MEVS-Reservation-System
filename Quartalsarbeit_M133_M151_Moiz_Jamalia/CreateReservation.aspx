<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateReservation.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.CreateReservation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <asp:Label Text="Reserve Train Component" runat="server" style="font-size: 3.7vh; font-weight: bold; position: absolute; top: 20%; left: 50%; transform: translate(-50%, -50%);" />

    <div>

        <asp:Label Text="Train:" runat="server" />
        <asp:DropDownList ID="ddl_Train" runat="server" />
        <br />

        <asp:Label Text="Rolling Stock: " runat="server" />
        <asp:DropDownList ID="ddl_RollingStock" runat="server" />
        <br />

        <asp:TextBox runat="server" />

        <asp:TextBox runat="server" />

        <div style="position: absolute; right: 0; margin-top: 2vh;">
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" OnClick="BtnCreate_Click" CssClass="button is-danger is-rounded" />
            <asp:Button ID="btnCreate" Text="Create" runat="server" OnClick="btnCreate_Click" CssClass="button is-success is-rounded" />
        </div>

    </div>

</asp:Content>
