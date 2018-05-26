<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuControl.ascx.cs" Inherits="PostgresqlMonitor.Controls.LeftMenuControl" %>

<script type="text/javascript" src="Scripts/bootstrap-multiselect.js"></script>
<link rel="stylesheet" href="Content/bootstrap-multiselect.css" type="text/css"/>
<script src="Scripts/LeftMenu.js"></script>
<link href="Content/LeftMenu.css" rel="stylesheet">

<div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="title" onclick="closeNav()">Settings</a>
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>

    <div class="columns-div">
        <span class="span">Columns in grid:</span>
        <asp:ListBox ID="ColumnsListBox" runat="server" SelectionMode="Multiple" />
        <br />
        <span class="span">Filter (Db Id):</span>
        <asp:DropDownList ID="DbIdsDropDownList" runat="server" CssClass="form-control" />
        <br /><br />
        <asp:Button ID="RefreshGridViewButton" runat="server" CssClass="btn btn-success" Text="Refresh Grid" OnClick="RefreshGridViewButton_Click" Width="100%" />
        <br /><br />
        <asp:Button ID="ShowChartButton" runat="server" CssClass="btn btn-alert" Text="Show/Hide Chart" OnClick="ShowChartButton_Click" Width="100%" />
    </div>
</div>

<!-- Use any element to open the sidenav -->
<div style="display: inline-block;">
    <img src="../Content/Icons/menu.png" onclick="openNav()" class="menu-icon"></img>
    <span class="app-title">PostgreSQL Monitor</span>
</div>