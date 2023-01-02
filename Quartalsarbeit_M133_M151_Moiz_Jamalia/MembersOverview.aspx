<%@ Page Title="MEVS - Member Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MembersOverview.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.MembersOverview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <div class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="active navbar_text"/>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="GVStyle">

        <asp:Label ID="lbSignUpRequests" Text="Sign Up requests" runat="server" CssClass="labelStyle"/>

        <asp:GridView ID="GvSignUps" runat="server" CssClass="table--centered table table is-striped" HeaderStyle-CssClass="thead" RowStyle-CssClass="tr" AutoGenerateColumns="false" OnPageIndexChanging="GvSignUps_PageIndexChanging" OnRowCommand="GvSignUps_RowCommand" >

            <Columns>

                <asp:BoundField DataField="Name" HeaderText="Last Name" />
                <asp:BoundField DataField="Vorname" HeaderText="First Name" />
                <asp:BoundField DataField="eMail" HeaderText="E-Mail" />
                <asp:BoundField DataField="Handy" HeaderText="Handy" />
                <asp:ButtonField ButtonType="Button" Text="Accept" CommandName="accept" />
                <asp:ButtonField ButtonType="Button" Text="Decline" CommandName="decline" />

            </Columns>

        </asp:GridView>

        <asp:Label Text="Member Overview" runat="server" CssClass="labelStyle"/>

        <asp:GridView ID="GvMembers" runat="server" CssClass="table--centered table table is-striped" HeaderStyle-CssClass="thead" RowStyle-CssClass="tr" AutoGenerateColumns="false" OnPageIndexChanging="GvMembers_PageIndexChanging" OnRowCancelingEdit="GvMembers_RowCancelingEdit"
            OnRowDeleting="GvMembers_RowDeleting" OnRowEditing="GvMembers_RowEditing" OnRowUpdating="GvMembers_RowUpdating" OnRowDataBound="GvMembers_RowDataBound">
            <Columns>

                <asp:CheckBoxField DataField="IsAdmin" HeaderText="Admin" />
                <asp:BoundField DataField="Name" HeaderText="Last Name" />
                <asp:BoundField DataField="Vorname" HeaderText="First Name" />
                <asp:BoundField DataField="eMail" HeaderText="E-Mail" ReadOnly="true"/>
                <asp:BoundField DataField="Handy" HeaderText="Handy" />
                <asp:BoundField DataField="Bemerkung" HeaderText="Comment" />

                 <asp:TemplateField HeaderText="Status">

                     <EditItemTemplate>
                         <asp:DropDownList ID="ddl_Status" runat="server" />
                     </EditItemTemplate>

                     <ItemTemplate>
                         <asp:label runat="server" Text='<%# Eval("Status") %>'/>
                     </ItemTemplate>

                 </asp:TemplateField>

                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />

            </Columns>
        </asp:GridView>

    </div>

    <asp:Button ID="btnLogOut" Text="Log Out" runat="server" Style="font-weight: bold; bottom: 0; left: 0; position: fixed; margin: 2vh; font-size: 2.3vh" CssClass="button is-dark" OnClick="BtnLogOut_Click"/>

</asp:Content>