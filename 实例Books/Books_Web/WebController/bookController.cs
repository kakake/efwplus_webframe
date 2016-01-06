using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EFWCoreLib.WebFrame.HttpHandler.Controller;
using EFWCoreLib.CoreFrame.Business.AttributeInfo;
using Books_Web.Entity;
using System.Data;

namespace Books_Web.WebController
{
    [WebController]
    public class bookController : JEasyUIController
    {

        [WebMethod]
        public void SaveBook()
        {
            Books book = GetModel<Books>();
            book.save();
            JsonResult = RetSuccess("保存书籍成功！");
        }

        [WebMethod]
        public void SearchBook()
        {
            string schar = ParamsData["schar"];
            int flag = Convert.ToInt32(ParamsData["flag"]);

            DataTable dt = NewObject<Books>().gettable();
            JsonResult = ToGridJson(dt);
        }
    }
}
