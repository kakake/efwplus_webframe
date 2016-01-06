
//==================================================
// 作 者：曾浩
// 日 期：2011/03/06
// 描 述：介绍本文件所要完成的功能以及背景信息等等
//==================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace EFWCoreLib.CoreFrame.Common
{
    public static class ExtendMethod
    {
        public static DataTable SelectData(this DataTable table, string filterExpression)
        {
            DataRow[] rows = table.Select(filterExpression);
            DataTable resultTable = table.Clone();
            if (rows != null)
            {
                foreach (DataRow row in rows)
                {
                    resultTable.Rows.Add(row.ItemArray);
                }
            }
            return resultTable;
        }
    }
}
