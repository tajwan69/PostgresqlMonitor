using PostgresqlMonitor.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostgresqlMonitor.Controls
{
    public partial class LeftMenuControl : System.Web.UI.UserControl
    {
        public event EventHandler<List<int>> RefreshGrid;
        public event EventHandler ChangeChartVisible;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadColumnsToListBox();
                LoadItemsToDropDownLists();
            }
        }

        private void LoadColumnsToListBox()
        {
            int counter = 0;
            foreach (string name in MainPage.columnsNames)
            {
                ListItem listItem = new ListItem(name, counter.ToString());
                if (MainPage.defaultVisibleColumns.Contains(counter))
                    listItem.Selected = true;
                ColumnsListBox.Items.Add(listItem);
                counter++;
            }
        }

        protected void RefreshGridViewButton_Click(object sender, EventArgs e)
        {
            RefreshGrid.Invoke(this, GetColumnsIds());
        }
        
        public List<int> GetColumnsIds()
        {
            List<int> visibleColumns = new List<int>();
            foreach (ListItem item in ColumnsListBox.Items)
            {
                if (item.Selected)
                    visibleColumns.Add(int.Parse(item.Value));
            }

            return visibleColumns;
        }

        private void LoadItemsToDropDownLists()
        {
            using (PostgresEntities dbContext = new PostgresEntities())
            {
                DbIdsDropDownList.Items.Add(new ListItem("ALL"));

                List <long> dbIds = dbContext.Database.SqlQuery<long>("SELECT DISTINCT CAST(dbid AS bigint) FROM pg_stat_statements").ToList();
                foreach (long id in dbIds)
                    DbIdsDropDownList.Items.Add(new ListItem(id.ToString()));
            }
        }

        public long GetDbIdFilter()
        {
            string text = "ALL";
            if (DbIdsDropDownList.SelectedItem != null)
                text = DbIdsDropDownList.SelectedItem.Text;

            if (text == "ALL")
                text = "-1";

            return long.Parse(text);
        }

        protected void ShowChartButton_Click(object sender, EventArgs e)
        {
            ChangeChartVisible.Invoke(this, null);
        }
    }

}