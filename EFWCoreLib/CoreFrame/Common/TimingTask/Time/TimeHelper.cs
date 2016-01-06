using System;
using System.Collections.Generic;
using System.Text;

namespace EFWCoreLib.CoreFrame.Common
{
    /// <summary>
    /// TimeHelper ��DateTime��صĹ�����
    /// </summary>
    public static class TimeHelper
    {
        #region IsOnTime
        /// <summary>
        /// IsOnTime ʱ��val��requiredTime֮��Ĳ�ֵ�Ƿ���maxToleranceInSecs��Χ֮�ڡ�
        /// </summary>        
        public static bool IsOnTime(DateTime requiredTime, DateTime val, int maxToleranceInSecs)
        {
            TimeSpan span = val - requiredTime;
            double spanMilliseconds = span.TotalMilliseconds < 0 ? (-span.TotalMilliseconds) : span.TotalMilliseconds;

            return (spanMilliseconds <= (maxToleranceInSecs * 1000));
        }

        /// <summary>
        /// IsOnTime ����ѭ�����ã�ʱ��val��startTime֮��Ĳ�ֵ(>0)��cycleSpanInSecs�������Ľ���Ƿ���maxToleranceInSecs��Χ֮�ڡ�
        /// </summary>        
        public static bool IsOnTime(DateTime startTime, DateTime val, int cycleSpanInSecs, int maxToleranceInSecs)
        {
            TimeSpan span = val - startTime;
            double spanMilliseconds = span.TotalMilliseconds ;
            double residual = spanMilliseconds % (cycleSpanInSecs * 1000);

            return (residual <= (maxToleranceInSecs * 1000));
        } 
        #endregion
    }
}
