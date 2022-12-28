<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Quartalsarbeit_M133_M151_Moiz_Jamalia.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHeader" runat="server">
    <link media="screen" href="registration.css" rel="stylesheet" />
    <link media="screen" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css" rel="stylesheet">
    <link media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div class="registration">
        <asp:Label Text="First Name" runat="server" /> <br />

        <asp:TextBox ID="tbFirstName" runat="server" CssClass="input input-box" placeholder="enter first name..." />
        <asp:RequiredFieldValidator ID="reqFieldVal1" ErrorMessage="!" ControlToValidate="tbFirstName" runat="server" CssClass="validator" Display="Dynamic" /> <br />

        <asp:Label Text="Last Name" runat="server" /> <br />

        <asp:TextBox ID="tbLastName" runat="server" CssClass="input input-box" placeholder="enter last name..." />
        <asp:RequiredFieldValidator ID="reqFieldVal2" ErrorMessage="!" ControlToValidate="tbLastName" runat="server" CssClass="validator" Display="Dynamic" /> <br />

        <asp:Label Text="Password" runat="server" /> <br />

        <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" CssClass="input input-box" placeholder="enter password..." />
        <asp:RegularExpressionValidator ID="regFieldVal1" ErrorMessage="Your password needs at least 8 characters." ControlToValidate="tbPassword" runat="server" ValidationExpression="^[\s\S]{8,}$" CssClass="validator" Display="Dynamic" />
        <asp:RequiredFieldValidator ID="reqFieldVal3" ErrorMessage="!" ControlToValidate="tbPassword" runat="server" CssClass="validator" Display="Dynamic" /> <br />

        <asp:Label Text="Confirm Password" runat="server" /> <br />

        <asp:TextBox ID="tbConfirmPassword" TextMode="Password" runat="server" CssClass="input input-box" placeholder="enter password again..." />
        <asp:RequiredFieldValidator ID="reqFieldVal4" ErrorMessage="!" ControlToValidate="tbConfirmPassword" runat="server" CssClass="validator" Display="Dynamic" />
        <asp:CompareValidator ID="compVal1" ErrorMessage="!" ControlToCompare="tbPassword" ControlToValidate="tbConfirmPassword" runat="server" CssClass="validator" Display="Dynamic" /> <br />

        <div class="contact">
            <asp:Label Text="E-Mail" runat="server" /> <br />

            <asp:TextBox ID="tbEmail" runat="server" CssClass="input input-box" placeholder="enter E-Mail..." />
            <asp:RequiredFieldValidator ID="reqFieldVal5" ErrorMessage="!" ControlToValidate="tbEmail" runat="server" CssClass="validator" Display="Dynamic" />
            <asp:CustomValidator ID="duplicateEmailVal" ErrorMessage="There is already an account with this E-Mail address." ControlToValidate="tbEmail" runat="server" CssClass="validator" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="regFieldVal2" ErrorMessage="Please enter a valid email address" ControlToValidate="tbEmail" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validator" Display="Dynamic" /> <br />

            <asp:Label Text="Mobile Number" runat="server" /> <br />

            <asp:TextBox ID="tbMobileNumber" TextMode="Phone" runat="server" CssClass="input input-box" placeholder="enter Mobile Number..." />
            <asp:RequiredFieldValidator ID="reqFieldVal6" ErrorMessage="!" ControlToValidate="tbMobileNumber" runat="server" CssClass="validator" Display="Dynamic" />
        </div> <br />

        <asp:Label ID="lbMessage" runat="server" ForeColor="Green" /> <br />

        <div class="submit">
            <asp:Button ID="btnSignUp" Text="Sign Up" UseSubmitBehavior="true" OnClick="BtnSignUp_Click" runat="server" CssClass="button is-link is-rounded button_background_color" />
            <asp:Button ID="btnLogIn" Text="Log In" UseSubmitBehavior="false" OnClick="BtnLogIn_Click" CausesValidation="false" runat="server" CssClass="button is-text is-rounded" />
        </div>
    </div>

</asp:Content>
