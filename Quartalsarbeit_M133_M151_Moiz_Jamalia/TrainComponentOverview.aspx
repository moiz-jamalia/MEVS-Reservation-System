<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainComponentOverview.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.TrainComponentOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="GVStyle" style="top: 10% !important;">

        <asp:Label Text="Train Component Overview" runat="server" CssClass="labelStyle" />

        <asp:GridView ID="gvTrainComponentsAdmins" runat="server" CssClass="table--centered table table is-striped" HeaderStyle-CssClass="thead" RowStyle-CssClass="tr"
            AutoGenerateColumns="false" OnPageIndexChanging="GvTrainComponentsAdmins_PageIndexChanging" OnRowCancelingEdit="GvTrainComponentsAdmins_RowCancelingEdit"
            OnRowDeleting="GvTrainComponentsAdmins_RowDeleting" OnRowEditing="GvTrainComponentsAdmins_RowEditing" OnRowUpdating="GvTrainComponentsAdmins_RowUpdating"
            OnRowDataBound="GvTrainComponentsAdmins_RowDataBound" >

            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
                <asp:BoundField DataField="Seller" HeaderText="Seller" />
                <asp:BoundField DataField="RailwayCompany" HeaderText="Railway Company" />
                <asp:BoundField DataField="Model" HeaderText="Model" />
                <asp:BoundField DataField="Typenbezeichnung" HeaderText="Type designation" />
                <asp:BoundField DataField="Nr" HeaderText="No." />
                <asp:BoundField DataField="Beschreibung" HeaderText="Description" />
                <asp:BoundField DataField="Kaufpreis" HeaderText="Purchase Price" />
                <asp:BoundField DataField="ImBesitz" HeaderText="In Possession Since" />
                <asp:CheckBoxField DataField="Occasion" HeaderText="Occasion" />
                <asp:BoundField DataField="Veröffentlichung" HeaderText="Publication" />
                <asp:BoundField DataField="ArtNr" HeaderText="Art. No." />
                <asp:BoundField DataField="SetNr" HeaderText="Set No." />
                <asp:BoundField DataField="Farbe" HeaderText="Color" />
                <asp:BoundField DataField="Bemerkung" HeaderText="Comment" />
                <asp:CheckBoxField DataField="FreigabeFuerZugbildung" HeaderText="Release for train formation" />

                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />

            </Columns>

            <RowStyle Width="150px"/>

        </asp:GridView>

        <asp:GridView ID="gvTrainComponentsMembers" runat="server" CssClass="table--centered table table is-striped" HeaderStyle-CssClass="thead" RowStyle-CssClass="tr"
            AutoGenerateColumns="false" OnPageIndexChanging="GvTrainComponentsMembers_PageIndexChanging" OnRowCancelingEdit="GvTrainComponentsMembers_RowCancelingEdit"
            OnRowEditing="GvTrainComponentsMembers_RowEditing" OnRowUpdating="GvTrainComponentsMembers_RowUpdating" OnRowDataBound="GvTrainComponentsMembers_RowDataBound">

            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true"/>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="true" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="true" />
                <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" ReadOnly="true" />
                <asp:BoundField DataField="Seller" HeaderText="Seller" ReadOnly="true" />
                <asp:BoundField DataField="RailwayCompany" HeaderText="Railway Company" ReadOnly="true" />
                <asp:BoundField DataField="Model" HeaderText="Model" ReadOnly="true" />
                <asp:BoundField DataField="Typenbezeichnung" HeaderText="Type designation" ReadOnly="true" />
                <asp:BoundField DataField="Nr" HeaderText="No." ReadOnly="true" />
                <asp:BoundField DataField="Beschreibung" HeaderText="Description" ReadOnly="true" />
                <asp:BoundField DataField="Kaufpreis" HeaderText="Purchase Price" ReadOnly="true" />
                <asp:BoundField DataField="ImBesitz" HeaderText="In Possession Since" ReadOnly="true" />
                <asp:CheckBoxField DataField="Occasion" HeaderText="Occasion" ReadOnly="true" />
                <asp:BoundField DataField="Veröffentlichung" HeaderText="Publication" ReadOnly="true" />
                <asp:BoundField DataField="ArtNr" HeaderText="Art. No." ReadOnly="true" />
                <asp:BoundField DataField="SetNr" HeaderText="Set No." ReadOnly="true" />
                <asp:BoundField DataField="Farbe" HeaderText="Color" ReadOnly="true" />
                <asp:BoundField DataField="Bemerkung" HeaderText="Comment" ReadOnly="true" />
                <asp:BoundField DataField="FreigabeFuerZugbildung" HeaderText="Release for train formation" />

                <asp:CommandField ShowEditButton="true" />

            </Columns>

        </asp:GridView>

        <asp:Label ID="lbtest" Text="tEST" runat="server" />

        </div>
        <div>
            <asp:Button ID="createComponent" Text="Create Train Component" runat="server" style="font-weight: bold; bottom: 0; left: 0; position: fixed; margin: 2vh; font-size: 2.5vh;" CssClass="button is-link is-rounded button_background_color"/>
        </div>

</asp:Content>
