<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReservationOverview.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.Reservation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="styles.css" /> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Blocking Time" NavigateUrl="~/BlockingTimesOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    
    <div runat="server" class="GVStyle">
        
        <asp:Label ID="lbReservations" Text="Reservations" runat="server" CssClass="labelStyle"/>

        <asp:GridView ID="gvReservations" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="GvReservations_PageIndexChanging" OnRowCancelingEdit="GvReservations_RowCancelingEdit"
            OnRowDeleting="GvReservations_RowDeleting" OnRowEditing="GvReservations_RowEditing" OnRowUpdating="GvReservations_RowUpdating" OnRowDataBound="GvReservations_RowDataBound">

            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                <asp:BoundField DataField="Name" HeaderText="Last Name" ReadOnly="true" />
                <asp:BoundField DataField="Vorname" HeaderText="First Name" ReadOnly="true" />

                <asp:TemplateField HeaderText="Train designation">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddl_Train" runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbTrain" Text='<%# Eval("Zugbezeichnung") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Train Components">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddl_TrainComponent" runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbTrainComponent" Text='<%# Eval("Rollmaterial") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
              
                <asp:BoundField DataField="Von" HeaderText="From" ReadOnly="true" />
                <asp:BoundField DataField="Bis" HeaderText="To" ReadOnly="true" />

                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />
            </Columns>

        </asp:GridView>

        <asp:Label ID="lbAllReservations" Text="All Reservations" runat="server" CssClass="labelStyle"/>

        <asp:GridView ID="gvAllReservations" runat="server" AutoGenerateColumns="false">

            <Columns>

                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                <asp:BoundField DataField="Name" HeaderText="Last Name" ReadOnly="true" />
                <asp:BoundField DataField="Vorname" HeaderText="First Name" ReadOnly="true" />
                <asp:BoundField DataField="Zugbezeichnung" HeaderText="Train designation" ReadOnly="true" />
                <asp:BoundField DataField="Rollmaterial" HeaderText="Train Components" ReadOnly="true" />
                <asp:BoundField DataField="Von" HeaderText="From" ReadOnly="true" />
                <asp:BoundField DataField="Bis" HeaderText="To" ReadOnly="true" />

            </Columns>

        </asp:GridView>

    </div>

    <asp:Button ID="btnCreateReservation" Text="Create Reservation" OnClick="BtnCreateReservation_Click" runat="server" CssClass="button is-link is-rounded button_background_color"/>

</asp:Content>