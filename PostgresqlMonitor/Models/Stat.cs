using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PostgresqlMonitor
{
    public class Stat
    {
        public long userid { get; set; }
        public long dbid { get; set; }
        public long queryid { get; set; }
        public string query { get; set; }
        public long calls { get; set; }
        public double total_time { get; set; }
        public double min_time { get; set; }
        public double max_time { get; set; }
        public double mean_time { get; set; }
        public double stddev_time { get; set; }
        public long rows { get; set; }
        public long shared_blks_hit { get; set; }
        public long shared_blks_read { get; set; }
        public long shared_blks_dirtied { get; set; }
        public long shared_blks_written { get; set; }
        public long local_blks_hit { get; set; }
        public long local_blks_read { get; set; }
        public long local_blks_dirtied { get; set; }
        public long local_blks_written { get; set; }
        public long temp_blks_read { get; set; }
        public long temp_blks_written { get; set; }
        public double blk_read_time { get; set; }
        public double blk_write_time { get; set; }
    }
}