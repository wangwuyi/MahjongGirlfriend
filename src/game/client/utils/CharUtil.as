package  game.client.utils
{
	public class CharUtil
	{
		private static var chineseReg:RegExp = /[\u4E00-\u9FA5]/;
		private static var numReg:RegExp = /[0-9]/;
		private static var englishReg:RegExp = /[a-zA-Z]/;
		private static var spaceEmptyReg:RegExp =  /^[ ]*$/;//是否全空格
		private static var serverNameReg:RegExp =  /\[{1}[0-9]*(]{1})/;//用于判断人名前是否有服务端号 例如[01]李四
		public static function judgeChinese(str:String):Boolean
		{
			return chineseReg.test(str);
		}
		
		public static function judgeNum(str:String):Boolean
		{
			return numReg.test(str);
		}
		
		public static function judgeEnglish(str:String):Boolean
		{
			return englishReg.test(str);
		}
		
		public static function judgeEmptySpace(str:String):Boolean
		{
			return spaceEmptyReg.test(str);
		}
		
		public static function deleteServerName(str:String):String
		{
			 return str.replace(serverNameReg,"");
		}
		
		public static function judgeServerName(str:String):Boolean
		{
			return serverNameReg.test(str);
		}
		
		public static function font(content:String, color:String, size:int = 12):String
		{
			return "<font color='" + color + "' size='" + size + "'>" + content + "</font>";
		}
	}
}