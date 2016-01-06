using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EFWCoreLib.WebFrame.HttpHandler.Controller;
using EFWCoreLib.CoreFrame.Business.AttributeInfo;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Caching;
using System.Collections;

namespace IotPlatform.WebController
{
    //发送指令给树莓派
    [WebController]
    public class RaspberryPiController : WebHttpController
    {
        

        private ICacheManager InitRaspberryPi()
        {
            ICacheManager cache = GetCache();
            //初始化树莓派主机
            if (cache.Contains("RaspberryPi") == false)
            {
                Dictionary<string, string[]> dic = new Dictionary<string, string[]>();
                dic.Add("00000000-0000-0000-0000-000000000000", new string[]{"树莓派主机1号","0",DateTime.Now.ToString()});//主机名、在线/掉线、最后时间
                dic.Add("10000000-0000-0000-0000-000000000000", new string[] { "树莓派主机2号", "0", DateTime.Now.ToString() });
                dic.Add("20000000-0000-0000-0000-000000000000", new string[] { "树莓派主机3号", "0", DateTime.Now.ToString() });
                dic.Add("30000000-0000-0000-0000-000000000000", new string[] { "树莓派主机4号", "0", DateTime.Now.ToString() });

                cache.Add("RaspberryPi", dic);
            }
            //初始化树莓派的设备
            if (cache.Contains("RaspberryPi_Device") == false)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("heartbeat", "监视设备");
                dic.Add("gpio", "控制GPIO");

                cache.Add("RaspberryPi_Device", dic);
            }

            Dictionary<string, string[]> dicPiList = cache.GetData("RaspberryPi") as Dictionary<string, string[]>;
            Dictionary<string, string> dicPiDev = cache.GetData("RaspberryPi_Device") as Dictionary<string, string>;

            foreach (var pi in dicPiList)
            {
                foreach (var dev in dicPiDev)
                {
                    //双通道
                    //发送给树莓派的命令数据
                    string CMD = "RaspberryPi_CMD_" + pi.Key + "_" + dev.Key;
                    if (cache.Contains(CMD) == false)
                    {
                        Queue qcmd = new Queue();
                        cache.Add(CMD, qcmd);
                    }
                    //树莓派回传给Web的数据
                    string DATA = "RaspberryPi_DATA_" + pi.Key + "_" + dev.Key;
                    if (cache.Contains(DATA) == false)
                    {
                        Queue qcmd = new Queue();
                        cache.Add(DATA, qcmd);
                    }
                }
            }
            return cache;
        }

        private Queue GetCmdQueue_CMD(string authkey, string dkey)
        {
            ICacheManager cache = InitRaspberryPi();
            string _dkey = "RaspberryPi_CMD_" + authkey + "_" + dkey;
            if (cache.Contains(_dkey) == false)
            {
                throw new Exception("'" + dkey + "' is not exist.");
            }
            return cache.GetData(_dkey) as Queue;
        }

        private Queue GetCmdQueue_DATA(string authkey, string dkey)
        {
            ICacheManager cache = InitRaspberryPi();
            string _dkey = "RaspberryPi_DATA_" + authkey + "_" + dkey;
            if (cache.Contains(_dkey) == false)
            {
                throw new Exception("'" + dkey + "' is not exist.");
            }
            return cache.GetData(_dkey) as Queue;
        }

        #region 提供给树莓派远程访问
        [WebMethod]
        public void GetData()
        {
            string authkey = ParamsData["authkey"];//树莓派发过来的授权码

            string dkey = ParamsData["dkey"];
            Queue que = GetCmdQueue_CMD(authkey, dkey);
            if (que.Count > 0)
            {
                string data = que.Dequeue().ToString();
                JsonResult = RetSuccess("get data success.", data);
            }
            else
            {
                JsonResult = RetSuccess("data no data.");
            }
        }

        [WebMethod]
        public void SendData()
        {
            string authkey = ParamsData["authkey"];//树莓派发过来的授权码

            string dkey = ParamsData["dkey"];
            string data = ParamsData["data"];
            Queue que = GetCmdQueue_DATA(authkey, dkey);
            que.Enqueue(data);
            if (que.Count > 100)//太多了，清空一些数据
            {
                for (int i = 1; i < 90; i++)
                {
                    que.Dequeue();
                }
            }
            //更新状态为在线
            ICacheManager cache = InitRaspberryPi();
            Dictionary<string, string[]> dicPiList = cache.GetData("RaspberryPi") as Dictionary<string, string[]>;
            dicPiList[authkey][1] = "1";
            dicPiList[authkey][2] = DateTime.Now.ToString();

            JsonResult = RetSuccess("send data success.");
        }
        #endregion

        [WebMethod]
        public void GetRaspberryPiList()
        {
            ICacheManager cache = InitRaspberryPi();
            Dictionary<string, string[]> dicPiList = cache.GetData("RaspberryPi") as Dictionary<string, string[]>;
            Dictionary<string, string> dicPiDev = cache.GetData("RaspberryPi_Device") as Dictionary<string, string>;

            foreach (var pi in dicPiList)//如果许久没连山，置为断线
            {
                if (DateTime.Now.AddSeconds(-5) > Convert.ToDateTime(pi.Value[2]))
                    pi.Value[1] = "0";
            }

            string data = "{\"dicPiList\":" + ToJson2(dicPiList) + ",\"dicPiDev\":" + ToJson2(dicPiDev) + "}";
            JsonResult = RetSuccess("", data);
        }

        [WebMethod]
        public void SetRaspberryPiData()
        {
            string authkey = ParamsData["authkey"];

            string dkey = ParamsData["dkey"];
            string data = FormData["data"];
            Queue que = GetCmdQueue_CMD(authkey, dkey);
            que.Enqueue(data.Replace("\n",""));
            JsonResult = RetSuccess("send RaspberryPi success.");
        }

        [WebMethod]
        public void GetRaspberryPiData()
        {
            string authkey = ParamsData["authkey"];

            string dkey = ParamsData["dkey"];
            Queue que = GetCmdQueue_DATA(authkey, dkey);
            if (que.Count > 0)
            {
                string data = que.Dequeue().ToString();
                JsonResult = RetSuccess(null, data);
            }
            else
            {
                JsonResult = RetSuccess(null);
            }
        }

        [WebMethod]
        public void GetRaspberryPiDataAll()
        {
            string authkey = ParamsData["authkey"];

            string dkey = ParamsData["dkey"];
            Queue que = GetCmdQueue_DATA(authkey, dkey);
            if (que.Count > 0)
            {
                string data = "[";
                for (int i = 0; i < que.Count; i++)
                    if (i == 0)
                        data += que.Dequeue().ToString() + "\n";
                    else
                        data += "," + que.Dequeue().ToString() + "\n";
                data += "]";
                JsonResult = RetSuccess(null, data);
            }
            else
            {
                JsonResult = RetSuccess(null);
            }
        }
    }
}
