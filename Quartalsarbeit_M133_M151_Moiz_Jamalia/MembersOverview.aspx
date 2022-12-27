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

    <div>

        <asp:Label Text="Registrations requests" runat="server" />

        <asp:GridView runat="server" AutoGenerateColumns="false" >
            <Columns>

             <asp:TemplateField>

                 <EditItemTemplate>
                     <asp:DropDownList ID="ddl_Status" runat="server" />
                 </EditItemTemplate>

                 <ItemTemplate>
                     <asp:label runat="server" Text='<%# Eval("Status") %>''/>
                 </ItemTemplate>


             </asp:TemplateField>

                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />

            </Columns>
        </asp:GridView>

    </div>

    <asp:Button ID="btnLogOut" Text="Log Out" runat="server" />

</asp:Content>