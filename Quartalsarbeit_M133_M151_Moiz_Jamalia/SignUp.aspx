<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">
    <link media="screen" href="registration.css" rel="stylesheet" />
    <link media="screen" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css" rel="stylesheet">
    <link media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="registration">
        <asp:Label Text="First Name" runat="server" />

        <asp:TextBox ID="tbFirstName" runat="server" CssClass="input input-box" placeholder="enter first name..." />
        <asp:RequiredFieldValidator ID="reqFieldVal1" ErrorMessage="!" ControlToValidate="tbFirstName" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:Label Text="Last Name" runat="server" />

        <asp:TextBox ID="tbLastName" runat="server" CssClass="input input-box" placeholder="enter last name..." />
        <asp:RequiredFieldValidator ID="reqFieldVal2" ErrorMessage="!" ControlToValidate="tbLastName" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:Label Text="Password" runat="server" />

        <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" CssClass="input input-box" placeholder="enter password..." />
        <asp:RequiredFieldValidator ID="reqFieldVal3" ErrorMessage="!" ControlToValidate="tbPassword" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:Label Text="Confirm Password" runat="server" />

        <asp:TextBox ID="tbConfirmPassword" TextMode="Password" runat="server" CssClass="input input-box" placeholder="enter password again..." />
        <asp:RequiredFieldValidator ID="reqFieldVal4" ErrorMessage="!" ControlToValidate="tbConfirmPassword" runat="server" CssClass="validator" Display="Dynamic" />
        <asp:CompareValidator ID="compVal1" ErrorMessage="!" ControlToCompare="tbPassword" ControlToValidate="tbConfirmPassword" runat="server" CssClass="validator" Display="Dynamic" />

        <div class="contact">
            <asp:Label Text="E-Mail" runat="server" />

            <asp:TextBox ID="tbEmail" runat="server" CssClass="input input-box" placeholder="enter E-Mail..." />
            <asp:RequiredFieldValidator ID="reqFieldVal5" ErrorMessage="!" ControlToValidate="tbEmail" runat="server" CssClass="validator" Display="Dynamic" />
            <asp:CustomValidator ID="dublicateEmailVal" ErrorMessage="There is already an account with this E-Mail address." ControlToValidate="tbEmail" runat="server" CssClass="validator" Display="Dynamic" />
            <asp:CustomValidator ID="customVal1" ErrorMessage="!" ControlToValidate="tbEmail" runat="server" OnServerValidate="Email_Validation" CssClass="validator" Display="Dynamic" />

            <asp:Label Text="Mobile Number" runat="server" />

            <asp:TextBox ID="tbMobileNumber" runat="server" CssClass="input input-box" placeholder="enter Mobile Number..." />
            <asp:RequiredFieldValidator ID="reqFieldVal6" ErrorMessage="!" ControlToValidate="tbMobileNumber" runat="server" CssClass="validator" Display="Dynamic" />
        </div>

        <asp:Label ID="lbMessage" runat="server" ForeColor="Green" />

        <div class="submit">
            <asp:Button ID="btnSignUp" Text="Sign Up" type="submit" OnClick="BtnSignUp_Click" runat="server" CssClass="button is-link is-rounded" />
            <asp:Button ID="btnLogIn" Text="Log In" type="submit" OnClick="BtnLogIn_Click" runat="server" CssClass="button is-text is-rounded" />
        </div>
    </div>

</asp:Content>
