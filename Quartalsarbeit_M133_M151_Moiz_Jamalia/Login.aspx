<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">
    <link media="screen" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css" rel="stylesheet">
    <link media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="login">
        <asp:Label Text="E-Mail" runat="server" /><br />

        <asp:TextBox ID="tbEmail" runat="server" CssClass="input input-box" placeholder="enter E-Mail..." />
        <asp:RequiredFieldValidator ID="reqFieldVal7" ErrorMessage="!" ControlToValidate="tbEmail" runat="server" CssClass="validator" Display="Dynamic" />
        <asp:RegularExpressionValidator ID="regexVal1" ErrorMessage="!" ControlToValidate="tbEmail" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validator" Display="Dynamic" /> <br />

        <asp:Label Text="Password" runat="server" /><br />

        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" CssClass="input input-box" placeholder="enter Password..." />
        <asp:RequiredFieldValidator ID="reqFieldVal8" ErrorMessage="!" ControlToValidate="tbPassword" runat="server" CssClass="validator" Display="Dynamic" /><br />

        <asp:Label ID="lbInvalidLogin" runat="server" CssClass="validator" /><br />

        <div class="submit">
            <asp:Button ID="btnLogIn" Text="Log In" type="submit" OnClick="BtnLogIn_Click" runat="server" CssClass="button is-link is-rounded" />
            <asp:Button ID="btnSignUp" Text="Sign Up" type="submit" OnClick="BtnSignUp_Click" CausesValidation="false" runat="server" CssClass="button is-text is-rounded" />
        </div>
    </div>

</asp:Content>
