using System;
using System.Collections.Generic;
using System.Text;

namespace EFWCoreLib.CoreFrame.Common
{
    /// <summary>
    /// TimingTaskType ��ʱ��������� 
    /// </summary>
    [EnumDescription("��ʱ���������")]
    public enum TimingTaskType
    {
        [EnumDescription("ÿСʱһ��")]
        PerHour,
        [EnumDescription("ÿ��һ��")]
        PerDay,
        [EnumDescription("ÿ��һ��")]
        PerWeek,
        [EnumDescription("ÿ��һ��")]
        PerMonth
    }
}
