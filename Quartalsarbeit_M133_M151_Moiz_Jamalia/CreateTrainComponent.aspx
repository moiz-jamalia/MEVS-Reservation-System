<%@ Page Title="MEVS - Create Train Component" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateTrainComponent.aspx.cs"
    Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.CreateTrainComponent" %>

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

    <asp:Label Text="Add new Train Component" runat="server" style="font-size: 3.7vh; font-weight: bold; position: absolute; top: 20%; left: 50%; transform: translate(-50%, -50%);"/>

    <div style="position: absolute; top: 25vh; left: 50%; transform: translate(-50%); height: auto; width: 50vw;" >
        
        <asp:Label Text="Manufacturer:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;"/>

        <asp:DropDownList ID="ddl_Manufacturer" runat="server" CssClass="input tbDateStyle"/>
        <asp:RequiredFieldValidator ID="reqFieldVal14" ErrorMessage="!" ControlToValidate="ddl_Manufacturer" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Seller:" runat="server" style="font-size: 2vh;" />

        <asp:TextBox ID="tbSellerFirstName" runat="server" placeholder="First Name*" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal15" ErrorMessage="!" ControlToValidate="tbSellerFirstName" runat="server" CssClass="validator" Display="Dynamic"  />

        <asp:TextBox ID="tbSellerLastName" runat="server" placeholder="Last Name*" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal16" ErrorMessage="!" ControlToValidate="tbSellerLastName" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:TextBox ID="tbSellerAddress" runat="server" placeholder="Address" CssClass="tbDateStyle input" />
        <asp:TextBox ID="tbSellerEmail" runat="server"  placeholder="E-Mail" CssClass="tbDateStyle input" />
        <asp:TextBox ID="tbSellerPhone" runat="server" placeholder="Phone Number" CssClass="tbDateStyle input" />
        <br />
        <br />
        <asp:TextBox ID="tbSellerComment" runat="server" TextMode="MultiLine" placeholder="Comment" CssClass="textarea has-fixed-size" />


        <asp:DropDownList ID="ddl_RailWayCompany" runat="server" CssClass="input tbDateStyle" />
          


    </div>
</asp:Content>
