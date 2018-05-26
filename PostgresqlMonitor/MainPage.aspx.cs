using PostgresqlMonitor.DB;
using PostgresqlMonitor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostgresqlMonitor
{
    public partial class MainPage : System.Web.UI.Page
    {
        public static readonly int[] defaultVisibleColumns = { 0, 1, 2, 3, 4, 5 };
        public static readonly string[] columnsNames = { "userid", "dbid", "queryid", "query", "calls", "total_time", "min_time", "max_time", "mean_time", "stddev_time", "rows", "shared_blks_hit",
            "shared_blks_read", "shared_blks_dirtied", "shared_blks_written", "local_blks_hit", "local_blks_read", "local_blks_dirtied", "local_blks_written", "temp_blks_read", "temp_blks_written",
            "blk_read_time", "blk_write_time"};

        private int PageNum
        {
            get
            {
                int pageNum = 0;
                int.TryParse(ViewState["PageNum"]?.ToString(), out pageNum);
                return pageNum;
            }
            set
            {
                ViewState["PageNum"] = value;
            }
        }

        private string GridSortDirection
        {
            get
            {
                return ViewState["GridSortDirection"]?.ToString();
            }
            set
            {
                ViewState["GridSortDirection"] = value;
            }
        }

        private string GridSortExpression
        {
            get
            {
                return ViewState["GridSortExpression"]?.ToString();
            }
            set
            {
                ViewState["GridSortExpression"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LeftMenu.RefreshGrid += LeftMenu_RefreshGrid;
            LeftMenu.ChangeChartVisible += LeftMenu_ChangeChartVisible;

            if (!IsPostBack)
            {
                ShowDefaultColumns();
                LoadDataToGrid(true);
            }
        }

        private void LeftMenu_RefreshGrid(object sender, List<int> visibleColumns)
        {
            for (int i = 0; i < MainGridView.Columns.Count; i++)
                MainGridView.Columns[i].Visible = visibleColumns.Contains(i);

            LoadDataToGrid(false);
        }

        private void LeftMenu_ChangeChartVisible(object sender, EventArgs e)
        {
            GridPanel.Visible = !GridPanel.Visible;
            Chart.Visible = !Chart.Visible;
        }

        private void ShowDefaultColumns()
        {
            for (int i = 0; i < MainGridView.Columns.Count; i++)
                MainGridView.Columns[i].Visible = defaultVisibleColumns.Contains(i);
        }

        private void LoadDataToGrid(bool useDefeultColumns)
        {
            using (PostgresEntities dbContext = new PostgresEntities())
            {
                List<int> columnsIds = useDefeultColumns ? defaultVisibleColumns.ToList() : LeftMenu.GetColumnsIds();
                if (columnsIds.Count == 0)
                    return;

                // select
                string sql = "SELECT ";
                foreach (int columnId in columnsIds)
                {
                    if (columnId == 0 || columnId == 1)
                        sql += "CAST(" + columnsNames[columnId].ToString() + " AS bigint), ";
                    else
                        sql += (columnsNames[columnId] + ", "); 
                }
                sql = sql.Substring(0, sql.Length - 2);
                sql += " FROM pg_stat_statements";

                // where
                long dbId = LeftMenu.GetDbIdFilter();
                if (LeftMenu.GetDbIdFilter() != -1)
                    sql += " WHERE dbid=" + dbId;

                // order by
                if (GridSortDirection != null && GridSortExpression != null)
                    sql += " ORDER BY " + GridSortExpression + " " + GridSortDirection;

                // execute
                var query = dbContext.Database.SqlQuery<Stat>(sql);
                List<Stat> items = query.Skip(MainGridView.PageSize * PageNum).Take(MainGridView.PageSize).ToList();
                MainGridView.VirtualItemCount = query.Count();
                MainGridView.DataSource = items;
                MainGridView.DataBind();

                // chart
                ChartLabelsHiddenField.Value = ChartDataHiddenField.Value = string.Empty;
                foreach (Stat item in items)
                {
                    ChartLabelsHiddenField.Value += item.queryid + ",";
                    ChartDataHiddenField.Value += item.calls + ",";
                }
                ChartLabelsHiddenField.Value.Substring(0, ChartLabelsHiddenField.Value.Length - 1);
                ChartDataHiddenField.Value.Substring(0, ChartDataHiddenField.Value.Length - 1);
            }
        }

        protected void RefreshMainGridViewTimer_Tick(object sender, EventArgs e)
        {
            LoadDataToGrid(false);
        }

        protected void MainGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridSortExpression = e.SortExpression;
            if(GridSortDirection == null || GridSortDirection == SortDirectionEnum.ASC.ToString())
                GridSortDirection = SortDirectionEnum.DESC.ToString();
            else
                GridSortDirection = SortDirectionEnum.ASC.ToString();
            
            LoadDataToGrid(false);
        }

        protected void MainGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Image sortImage = e.Row.FindControl(GridSortExpression + "Image") as Image;
                if (sortImage != null)
                    sortImage.ImageUrl = GridSortDirection == SortDirectionEnum.ASC.ToString() ? "~/Content/Icons/arrow_up.png" : "~/Content/Icons/arrow_down.png";
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Stat DataItem = e.Row.DataItem as Stat;

                Label UserIdLabel = e.Row.FindControl("UserIdLabel") as Label;
                Label DbIdLabel = e.Row.FindControl("DbIdLabel") as Label;
                Label QueryIdLabel = e.Row.FindControl("QueryIdLabel") as Label;
                Label QueryLabel = e.Row.FindControl("QueryLabel") as Label;
                Label CallsLabel = e.Row.FindControl("CallsLabel") as Label;
                Label TotalTimeLabel = e.Row.FindControl("TotalTimeLabel") as Label;
                Label MinTimeLabel = e.Row.FindControl("MinTimeLabel") as Label;
                Label MaxTimeLabel = e.Row.FindControl("MaxTimeLabel") as Label;
                Label MeanTimeLabel = e.Row.FindControl("MeanTimeLabel") as Label;
                Label StddevTimeLabel = e.Row.FindControl("StddevTimeLabel") as Label;
                Label RowsLabel = e.Row.FindControl("RowsLabel") as Label;
                Label SharedBlksHitLabel = e.Row.FindControl("SharedBlksHitLabel") as Label;
                Label SharedBlksReadLabel = e.Row.FindControl("SharedBlksReadLabel") as Label;
                Label SharedBlksDirtiedLabel = e.Row.FindControl("SharedBlksDirtiedLabel") as Label;
                Label SharedBlksWrittenLabel = e.Row.FindControl("SharedBlksWrittenLabel") as Label;
                Label LocalBlksHitLabel = e.Row.FindControl("LocalBlksHitLabel") as Label;
                Label LocalBlksReadLabel = e.Row.FindControl("LocalBlksReadLabel") as Label;
                Label LocalBlksDirtiedLabel = e.Row.FindControl("LocalBlksDirtiedLabel") as Label;
                Label LocalBlksWrittenLabel = e.Row.FindControl("LocalBlksWrittenLabel") as Label;
                Label TempBlksReadLabel = e.Row.FindControl("TempBlksReadLabel") as Label;
                Label TempBlksWrittenLabel = e.Row.FindControl("TempBlksWrittenLabel") as Label;
                Label BlkReadTimeLabel = e.Row.FindControl("BlkReadTimeLabel") as Label;
                Label BlkWriteTimeLabel = e.Row.FindControl("BlkWriteTimeLabel") as Label;

                UserIdLabel.Text = DataItem.userid.ToString();
                DbIdLabel.Text = DataItem.dbid.ToString();
                QueryIdLabel.Text = DataItem.queryid.ToString();
                if (DataItem.query != null)
                    QueryLabel.Text = QueryLabel.ToolTip = DataItem.query.ToString();
                CallsLabel.Text = DataItem.calls.ToString();
                TotalTimeLabel.Text = DataItem.total_time.ToString();
                MinTimeLabel.Text = DataItem.min_time.ToString();
                MaxTimeLabel.Text = DataItem.max_time.ToString();
                MeanTimeLabel.Text = DataItem.mean_time.ToString();
                StddevTimeLabel.Text = DataItem.stddev_time.ToString();
                RowsLabel.Text = DataItem.rows.ToString();
                SharedBlksHitLabel.Text = DataItem.shared_blks_hit.ToString();
                SharedBlksReadLabel.Text = DataItem.shared_blks_read.ToString();
                SharedBlksDirtiedLabel.Text = DataItem.shared_blks_dirtied.ToString();
                SharedBlksWrittenLabel.Text = DataItem.shared_blks_written.ToString();
                LocalBlksHitLabel.Text = DataItem.local_blks_hit.ToString();
                LocalBlksReadLabel.Text = DataItem.local_blks_read.ToString();
                LocalBlksDirtiedLabel.Text = DataItem.local_blks_dirtied.ToString();
                LocalBlksWrittenLabel.Text = DataItem.local_blks_written.ToString();
                TempBlksReadLabel.Text = DataItem.temp_blks_read.ToString();
                TempBlksWrittenLabel.Text = DataItem.temp_blks_written.ToString();
                BlkReadTimeLabel.Text = DataItem.blk_read_time.ToString();
                BlkWriteTimeLabel.Text = DataItem.blk_write_time.ToString();
            }
        }

        protected void MainGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            PageNum = e.NewPageIndex;
            MainGridView.PageIndex = PageNum;
            LoadDataToGrid(false);
        }
    }
}