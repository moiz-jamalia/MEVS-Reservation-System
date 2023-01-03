<%@ Page Title="MEVS - Reserve Train Component" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateReservation.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.CreateReservation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">

    <link rel="stylesheet" runat="server" media="screen" href="/styles.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

    <span class="navbar_overview">
        <asp:HyperLink Text="Train Components" NavigateUrl="~/TrainComponentOverview.aspx" runat="server" CssClass="navbar_text" />
        <asp:HyperLink Text="Reservations" NavigateUrl="~/ReservationOverview.aspx" runat="server" CssClass="active navbar_text"/>
        <asp:HyperLink Text="Member Administration" NavigateUrl="~/MembersOverview.aspx" runat="server" CssClass="navbar_text"/>
    </span>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <asp:Label Text="Reserve Train Component" runat="server" style="font-size: 3.7vh; font-weight: bold; position: absolute; top: 20%; left: 50%; transform: translate(-50%, -50%);" />

    <div style="position: absolute; top: 25vh; left: 50%; transform: translate(-50%); height: auto; width: 50vw;">

        <asp:Label Text="Train:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2.5vh;"/>
        <asp:TextBox ID="tbCreateTrain" runat="server" placeholder="Enter Train name..." CssClass="input tbDateStyle"/>
        <asp:RequiredFieldValidator ID="reqFieldVal13" ErrorMessage="!" ControlToValidate="tbCreateTrain" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Rolling Stock:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2.5vh;" />
        <asp:DropDownList ID="ddl_RollingStock" runat="server" CssClass="input tbDateStyle" />
        <asp:RequiredFieldValidator ID="reqField12" ErrorMessage="!" ControlToValidate="ddl_RollingStock" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="From:" runat="server" style="font-size: 2vh;"/>

        <asp:TextBox ID="tbFromDate" runat="server" TextMode="Date" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal8" ErrorMessage="!" ControlToValidate="tbFromDate" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:TextBox ID="tbFromTime" runat="server" TextMode="Time" CssClass="tbTimeStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal9" ErrorMessage="!" ControlToValidate="tbFromTime" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:Label Text="To:" runat="server" style="font-size: 2vh;"/>

        <asp:TextBox ID="tbToDate" runat="server" TextMode="Date" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal10" ErrorMessage="!" ControlToValidate="tbToDate" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:TextBox ID="tbToTime" runat="server" TextMode="Time" CssClass="tbTimeStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal11" ErrorMessage="!" ControlToValidate="tbToTime" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:TextBox ID="tbComment" runat="server" TextMode="MultiLine" placeholder="Comment..." CssClass="textarea has-fixed-size" style="width: 10vw; margin-top: 1vh;" />

        <asp:Label ID="lbResError" runat="server" CssClass="validator"/>

        <div style="position: absolute; right: 0; margin-top: 2vh;">
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" OnClick="BtnCancel_Click" CssClass="button is-danger is-rounded" />
            <asp:Button ID="btnCreate" Text="Create" runat="server" OnClick="BtnCreate_Click" CssClass="button is-success is-rounded" />
        </div>

    </div>

</asp:Content>