<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainComponentOverview.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.TrainComponentOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Blocking Rolling Stock" NavigateUrl="~/BlockingRollingStockOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="GVStyle">

        <asp:Label Text="Train Component Overview" runat="server" CssClass="labelStyle" />

        <asp:GridView ID="gvTrainComponents" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="GvTrainComponents_PageIndexChanging" 
            OnRowCancelingEdit="GvTrainComponents_RowCancelingEdit" OnRowDeleting="GvTrainComponents_RowDeleting" OnRowEditing="GvTrainComponents_RowEditing"
            OnRowUpdating="GvTrainComponents_RowUpdating">

            <Columns>


                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />
            </Columns>

        </asp:GridView>

</asp:Content>
