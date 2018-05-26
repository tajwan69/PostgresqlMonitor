<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="PostgresqlMonitor.MainPage" %>
<%@ Register TagPrefix="custom" TagName="LeftMenu" Src="~/Controls/LeftMenuControl.ascx" %>
<%@ Register TagPrefix="custom" TagName="Chart" Src="~/Controls/ChartControl.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <custom:LeftMenu ID="LeftMenu" runat="server" />

            <asp:Timer ID="RefreshMainGridViewTimer" runat="server" Interval="30000" OnTick="RefreshMainGridViewTimer_Tick" />

            <custom:Chart ID="Chart" runat="server" Visible="false" />

            <asp:Panel ID="GridPanel" runat="server">
                <div id="main">
                
                    <div class="grid">
                        <asp:GridView ID="MainGridView" runat="server" CssClass="table table-striped table-bordered table-hover custom-table" 
                            AutoGenerateColumns="false" AllowPaging="true" AllowCustomPaging="true" PageSize="10" AllowSorting="true"
                            OnPageIndexChanging="MainGridView_PageIndexChanging" OnSorting="MainGridView_Sorting" OnRowDataBound="MainGridView_RowDataBound">
                            <Columns>
                                <asp:TemplateField SortExpression="userid">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="UserId" CommandName="Sort" ForeColor="White" CommandArgument="userid" ToolTip="OID of user who executed the statement">
                                            <asp:Image ID="useridImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png" />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="UserIdLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="dbid">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="DbId" CommandName="Sort" ForeColor="White" CommandArgument="dbid" ToolTip="OID of database in which the statement was executed">
                                            <asp:Image ID="dbidImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="DbIdLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="queryid">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="QueryId" CommandName="Sort" ForeColor="White" CommandArgument="queryid" ToolTip="Internal hash code, computed from the statement's parse tree">
                                            <asp:Image ID="queryidImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="QueryIdLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="query">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Query" CommandName="Sort" ForeColor="White" CommandArgument="query" ToolTip="Text of a representative statement">
                                            <asp:Image ID="queryImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="QueryLabel" class="query-label" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="calls">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Calls" CommandName="Sort" ForeColor="White" CommandArgument="calls" ToolTip="Number of times executed">
                                            <asp:Image ID="callsImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="CallsLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="total_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Total time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="total_time" ToolTip="Total time spent in the statement, in milliseconds">
                                            <asp:Image ID="total_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="TotalTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="min_time"> 
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Min time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="min_time">
                                            <asp:Image ID="min_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="MinTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="max_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Max time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="max_time">
                                            <asp:Image ID="max_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="MaxTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="mean_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Mean time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="mean_time">
                                            <asp:Image ID="mean_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="MeanTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="stddev_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Stddev time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="stddev_time" ToolTip="Total time spent in the statement, in milliseconds">
                                            <asp:Image ID="stddev_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="StddevTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="rows">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Rows" CommandName="Sort" ForeColor="White" CommandArgument="rows" ToolTip="Total number of rows retrieved or affected by the statement">
                                            <asp:Image ID="rowsImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="RowsLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="shared_blks_hit">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Shared Blks Hit" CommandName="Sort" ForeColor="White" CommandArgument="shared_blks_hit" ToolTip="Total number of shared block cache hits by the statement">
                                            <asp:Image ID="shared_blks_hitImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="SharedBlksHitLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="shared_blks_read">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Shared Blks Read" CommandName="Sort" ForeColor="White" CommandArgument="shared_blks_read" ToolTip="Total number of shared blocks read by the statement">
                                            <asp:Image ID="shared_blks_readImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="SharedBlksReadLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="shared_blks_dirtied">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Shared Blks Dirtied" CommandName="Sort" ForeColor="White" CommandArgument="shared_blks_dirtied" ToolTip="Total number of shared blocks dirtied by the statement">
                                            <asp:Image ID="shared_blks_dirtiedImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="SharedBlksDirtiedLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="shared_blks_written">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Shared Blks Written" CommandName="Sort" ForeColor="White" CommandArgument="shared_blks_written" ToolTip="Total number of shared blocks written by the statement">
                                            <asp:Image ID="shared_blks_writtenImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="SharedBlksWrittenLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="local_blks_hit">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Local Blks Hit" CommandName="Sort" ForeColor="White" CommandArgument="local_blks_hit" ToolTip="Total number of local block cache hits by the statement">
                                            <asp:Image ID="local_blks_hitImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="LocalBlksHitLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="local_blks_read">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Local Blks Read" CommandName="Sort" ForeColor="White" CommandArgument="local_blks_read" ToolTip="Total number of local blocks read by the statement">
                                            <asp:Image ID="local_blks_readImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="LocalBlksReadLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="local_blks_dirtied">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Local Blks Dirtied" CommandName="Sort" ForeColor="White" CommandArgument="local_blks_dirtied" ToolTip="Total number of local blocks dirtied by the statement">
                                            <asp:Image ID="local_blks_dirtiedImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="LocalBlksDirtiedLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="local_blks_written">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Local Blks Written" CommandName="Sort" ForeColor="White" CommandArgument="local_blks_written" ToolTip="Total number of local blocks written by the statement">
                                            <asp:Image ID="local_blks_writtenImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="LocalBlksWrittenLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="temp_blks_read">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Temp Blks Read" CommandName="Sort" ForeColor="White" CommandArgument="temp_blks_read" ToolTip="Total number of temp blocks read by the statement">
                                            <asp:Image ID="temp_blks_readImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="TempBlksReadLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="temp_blks_written">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Temp Blks Written" CommandName="Sort" ForeColor="White" CommandArgument="temp_blks_written" ToolTip="Total number of temp blocks written by the statement">
                                            <asp:Image ID="temp_blks_writtenImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="TempBlksWrittenLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="blk_read_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Blk Read Time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="blk_read_time" ToolTip="Total time the statement spent reading blocks, in milliseconds (if track_io_timing is enabled, otherwise zero)">
                                            <asp:Image ID="blk_read_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="BlkReadTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField SortExpression="blk_write_time">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" Text="Blk Write Time [ms]" CommandName="Sort" ForeColor="White" CommandArgument="blk_write_time" ToolTip="Total time the statement spent writing blocks, in milliseconds (if track_io_timing is enabled, otherwise zero)">
                                            <asp:Image ID="blk_write_timeImage" runat="server" ImageUrl="~/Content/Icons/arrow_right.png"   />
                                        </asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="BlkWriteTimeLabel" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="SteelBlue" ForeColor="White" />
                            <PagerStyle HorizontalAlign="Right" />
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>
            <asp:HiddenField ID="ChartLabelsHiddenField" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="ChartDataHiddenField" ClientIDMode="Static" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
