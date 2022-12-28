<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReservationOverview.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.Reservation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="styles.css" /> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    
    <div>
        
        <asp:Label ID="lbReservations" Text="Reservations" runat="server" />

        <asp:GridView ID="gvReservations" runat="server">

        </asp:GridView>

    </div>

    <asp:Button Text="create Reservation" runat="server" CssClass="button is-link is-rounded"/>

</asp:Content>
