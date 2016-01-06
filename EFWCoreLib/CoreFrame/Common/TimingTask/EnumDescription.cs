using System;
using System.Collections ;
using System.Reflection ;
using System.Collections.Generic;

namespace EFWCoreLib.CoreFrame.Common
{
	/// <summary>
	/// EnumDescription ��������ö�ٵ����ԡ�	
	/// </summary>
	[AttributeUsage(AttributeTargets.Field | AttributeTargets.Enum)]
	public class EnumDescription : Attribute
	{
        private static IDictionary<string, IList<EnumDescription>> EnumDescriptionCache = new Dictionary<string, IList<EnumDescription>>(); //EnumType.FullName - IList<EnumDescription>

		#region Ctor
        public EnumDescription(string _description) :this(_description ,null)
		{
		}

        public EnumDescription(string _description, object _tag)
        {
            this.description = _description;
            this.tag = _tag;
        }
		#endregion

		#region property
        #region Description
        private string description = "";
        public string Description
        {
            get
            {
                return this.description;
            }
        }	 
        #endregion	

        #region EnumValue
        private object enumValue = null;
        public object EnumValue
        {
            get
            {
                return this.enumValue;
            }
        } 
        #endregion

        #region Tag
        private object tag = null;
        public object Tag
        {
            get
            {
                return this.tag;
            }
        } 
        #endregion

        #region ToString
        public override string ToString()
        {
            return this.description;
        } 
        #endregion		
		
		#endregion

        #region DoGetFieldTexts
        /// <summary>
        /// DoGetFieldTexts �õ�ö�����Ͷ��������ö��ֵ�������ı�		
        /// </summary>	
        private static IList<EnumDescription> DoGetFieldTexts(Type enumType)
        {
            if (!EnumDescription.EnumDescriptionCache.ContainsKey(enumType.FullName))
            {
                FieldInfo[] fields = enumType.GetFields();
                IList<EnumDescription> list = new List<EnumDescription>();
                foreach (FieldInfo fi in fields)
                {
                    object[] eds = fi.GetCustomAttributes(typeof(EnumDescription), false);
                    if (eds.Length == 1)
                    {
                        EnumDescription enumDescription = (EnumDescription)eds[0];
                        enumDescription.enumValue = fi.GetValue(null);
                        list.Add(enumDescription);
                    }
                }

                EnumDescription.EnumDescriptionCache.Add(enumType.FullName, list);
            }

            return EnumDescription.EnumDescriptionCache[enumType.FullName];
        }
        #endregion

        #region GetEnumDescriptionText
        /// <summary>
        /// GetEnumDescriptionText ��ȡö�����͵������ı���
	    /// </summary>	   
        public static string GetEnumDescriptionText(Type enumType)
		{
            EnumDescription[] enumDescriptionAry = (EnumDescription[])enumType.GetCustomAttributes(typeof(EnumDescription), false);
            if (enumDescriptionAry.Length < 1)
            {
                return string.Empty;
            }

            return enumDescriptionAry[0].Description;
        }
        #endregion

        #region GetEnumTag
        /// <summary>
        /// GetEnumTag ��ȡö������Я����Tag��
        /// </summary>
        public static object GetEnumTag(Type enumType)
        {
            EnumDescription[] eds = (EnumDescription[])enumType.GetCustomAttributes(typeof(EnumDescription), false);
            if (eds.Length != 1) return string.Empty;
            return eds[0].Tag;
        } 
        #endregion		
		
        #region GetFieldText
        /// <summary>
        /// GetFieldDescriptionText ���ָ��ö��ֵ�������ı���
        /// </summary>		
        public static string GetFieldText(object enumValue)
        {
            IList<EnumDescription> list = EnumDescription.DoGetFieldTexts(enumValue.GetType());
            if (list == null)
            {
                return null;
            }

            return CollectionConverter.ConvertFirstSpecification<EnumDescription, string>(list, delegate(EnumDescription ed) { return ed.Description; }, delegate(EnumDescription ed) { return ed.enumValue.ToString() == enumValue.ToString(); });
        } 
        #endregion

        #region GetFieldTag
        /// <summary>
        /// GetFieldTag ���ָ��ö��ֵ��Tag��
        /// </summary>
        /// <param name="enumValue"></param>
        /// <returns></returns>
        public static object GetFieldTag(object enumValue)
        {
            IList<EnumDescription> list = EnumDescription.DoGetFieldTexts(enumValue.GetType());
            if (list == null)
            {
                return null;
            }

            return CollectionConverter.ConvertFirstSpecification<EnumDescription, object>(list, delegate(EnumDescription ed) { return ed.Tag; }, delegate(EnumDescription ed) { return ed.enumValue.ToString() == enumValue.ToString(); });
        }     
        #endregion

        #region GetEnumValueByTag
        /// <summary>
        /// GetEnumValueByTag ��������Tag��ȡ��Ӧ��ö��ֵ
        /// </summary>     
        public static object GetEnumValueByTag(Type enumType, object tag)
        {
            IList<EnumDescription> list = EnumDescription.DoGetFieldTexts(enumType);
            if (list == null)
            {
                return null;
            }

            return CollectionConverter.ConvertFirstSpecification<EnumDescription, object>(list, delegate(EnumDescription des) { return des.enumValue; }, delegate(EnumDescription des) { return des.tag.ToString() == tag.ToString(); });
        } 
        #endregion
		
	}
}
