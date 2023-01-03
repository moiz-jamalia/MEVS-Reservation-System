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

    <asp:Label Text="Add new Train Component" runat="server" 
        style="font-size: 3.7vh; font-weight: bold; position: absolute; top: 20%; left: 50%; transform: translate(-50%, -50%);"/>

    <div style="position: absolute; top: 25vh; left: 50%; transform: translate(-50%); height: auto; width: 50vw;" >
        
        <asp:Label Text="Manufacturer:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;"/>

        <asp:DropDownList ID="ddl_Manufacturer" runat="server" CssClass="input tbDateStyle"/>
        <asp:RequiredFieldValidator ID="reqFieldVal14" ErrorMessage="!" ControlToValidate="ddl_Manufacturer" runat="server" CssClass="validator"
            Display="Dynamic" />
        <br />

        <asp:Label Text="Seller:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />

        <asp:TextBox ID="tbSellerFirstName" runat="server" placeholder="Seller First Name" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal15" ErrorMessage="!" ControlToValidate="tbSellerFirstName" runat="server" CssClass="validator" 
            Display="Dynamic"  />
        <br />

        <asp:TextBox ID="tbSellerLastName" runat="server" placeholder="Seller Last Name" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal16" ErrorMessage="!" ControlToValidate="tbSellerLastName" runat="server" CssClass="validator" 
            Display="Dynamic" />
        <br />

        <asp:TextBox ID="tbSellerAddress" runat="server" placeholder="Seller Address" CssClass="tbDateStyle input" />
        <br />
        <asp:TextBox ID="tbSellerEmail" runat="server" placeholder="Seller E-Mail" CssClass="tbDateStyle input" />
        <br />
        <asp:TextBox ID="tbSellerPhone" runat="server" placeholder="Seller Phone Number" CssClass="tbDateStyle input" />
        <br />
        <br />
        <asp:TextBox ID="tbSellerComment" runat="server" TextMode="MultiLine" placeholder="Comment" CssClass="textarea has-fixed-size" />
        <br />
        
        <asp:Label Text="Railway Company:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:DropDownList ID="ddl_RailWayCompany" runat="server" CssClass="input tbDateStyle" />
        <asp:RequiredFieldValidator ID="reqFieldVal17" ErrorMessage="!" ControlToValidate="ddl_RailWayCompany" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Model Designation:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:DropDownList ID="ddl_Model" runat="server" CssClass="input tbDateStyle" />
        <asp:RequiredFieldValidator ID="reqFieldVal18" ErrorMessage="!" ControlToValidate="ddl_Model" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Type Designation:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbTypeDesignation" runat="server" placeholder="Type designation" CssClass="tbDateStyle input"/>
        <asp:RequiredFieldValidator ID="reqFieldVal29" ErrorMessage="!" ControlToValidate="tbTypeDesignation" runat="server" CssClass="validator" Display="Dynamic" />

        <asp:Label Text="No.:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;"/>
        <asp:TextBox ID="tbNo" runat="server" placeholder="No." CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal19" ErrorMessage="!" ControlToValidate="tbNo" runat="server" CssClass="validator" Display="Dynamic" />
        <br />
        
        <asp:Label Text="Description:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbDescription" runat="server" placeholder="description" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal20" ErrorMessage="!" ControlToValidate="tbDescription" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Purchase Price:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbPurchasePrice" runat="server" placeholder="Purchase Price" CssClass="tbDateStyle input" />
        <asp:RegularExpressionValidator ID="regexVal4" ErrorMessage="!" ControlToValidate="tbPurchasePrice" ValidationExpression="^(?:\d{0,14}\.\d{1,4})$|^\d{0,14}$" runat="server" CssClass="validator" Display="Dynamic" />
        <asp:RequiredFieldValidator ID="reqFieldVal21" ErrorMessage="!" ControlToValidate="tbPurchasePrice" runat="server" CssClass ="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="In Possession:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbInPossession" runat="server" placeholder="In Possession" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal22" ErrorMessage="!" ControlToValidate="tbInPossession" runat="server" CssClass="validator" Display="Dynamic" />
        <br />
        <br />

        <asp:CheckBox ID="cbOccasion" Text="Occasion" runat="server" CssClass="input" />
        <asp:CustomValidator ID="customVal1" ErrorMessage="!" OnServerValidate="OccasionValidate" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Publication:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbPublication" runat="server" placeholder="Publication" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal24" ErrorMessage="!" ControlToValidate="tbPublication" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Art No.:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbArtNo" runat="server" placeholder="Art No." CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal25" ErrorMessage="!" ControlToValidate="tbArtNo" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Set No.:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbSetNo" runat="server" placeholder="Set No." CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal26" ErrorMessage="!" ControlToValidate="tbSetNo" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Color:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbColor" runat="server" placeholder="Color" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal27" ErrorMessage="!" ControlToValidate="tbColor" runat="server" CssClass="validator" Display="Dynamic" />
        <br />

        <asp:Label Text="Comment:" runat="server" style="margin-right: 2vh; margin-top: 10vh; font-size: 2vh;" />
        <asp:TextBox ID="tbComment" runat="server" placeholder="Comment" CssClass="tbDateStyle input" />
        <asp:RequiredFieldValidator ID="reqFieldVal28" ErrorMessage="!" ControlToValidate="tbComment" runat="server" CssClass="validator" Display="Dynamic" />
        <br />
        <br />

        <asp:CheckBox ID="cbRelease" Text="Release for Train formation" runat="server" CssClass="input" />
        <asp:CustomValidator ID="customVal2" ErrorMessage="!" OnServerValidate="ReleaseValidate" runat="server" CssClass="validator" Display="Dynamic" />

        <div style="position: absolute; right: 0; margin-top: 2vh;">
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" OnClick="BtnCancel_Click" CssClass="button is-danger is-rounded" />
            <asp:Button ID="btnCreate" Text="Create" runat="server" OnClick="BtnCreate_Click" CssClass="button is-success is-rounded" />
        </div>

    </div>
</asp:Content>
