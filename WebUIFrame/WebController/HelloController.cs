using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EFWCoreLib.WebFrame.HttpHandler.Controller;
using EFWCoreLib.CoreFrame.Business.AttributeInfo;

namespace WebUIFrame.WebController
{
    [WebController]
    public class HelloController : JEasyUIController
    {
        [WebMethod]
        public void GetHello()
        {
			//代码实现
            JsonResult = RetSuccess("hello world");
        }
    }
}
