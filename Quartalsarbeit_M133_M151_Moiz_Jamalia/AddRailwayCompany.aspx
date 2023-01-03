<%@ Page Title="MEVS - Add Railway Company" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddRailwayCompany.aspx.cs"
    Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.AddRailwayCompany" %>

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

    <asp:Label Text="Railway Companies" runat="server" />

    <asp:GridView ID="gvRailwayCompanies" runat="server" AutoGenerateColumns="false" >

    </asp:GridView>

</asp:Content>
