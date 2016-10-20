package game.client.utils
{
	
	public class HtmlUtil
	{

		public static function br(value:String):String
		{
			return "<br>" + value + "</br>";
		}

		public static function font2(value:String, color:int, size:int=12):String
		{
			return font(value, color.toString(16), size);
		}

		public static function bold(value:String):String
		{
			return "<b>" + value + "</b>";
		}

		public static function fontBr(value:String, color:String, size:int = 12):String
		{
			return font(value, color, size) + "\n";
		}

		public static function link(linkUrl:String, value:String = "", isUnderline:Boolean = false):String
		{
			if (isUnderline)
			{
				return "<u><a href=\'event:" + linkUrl + "\'>" + value + "</a></u>";
			}
			return "<a href=\'event:" + linkUrl + "\'>" + value + "</a>";
		}
		
		public static function filterHtml(value:String):String
		{
			var result:String = value.replace(/\<\/?[^\<\>]+\>/gmi, "");
			return result;
		}

		public static function font(value:String, color:String, size:int = 12, isCenter:Boolean = true):String
		{
			if (isCenter)
			{
				return "<p align=\'center\'><font color=\'" + color + "\' size=\'" + size + "\'>" + value + "</font></p>";
			}
			return "<p><font color=\'" + color + "\' size=\'" + size + "\'>" + value + "</font></p>";
		}
		
		public static function fontLeftAlign(value:String, color:String, size:int = 12):String
		{
			return "<font color=\'" + color + "\' size=\'" + size + "\'>" + value + "</font>";
		}
		
		public static function textColor(text:String, color:String):String
		{
			return "<font color=\'" + color + "\'>" + text + "</font>";
		}
		
		public static function format(str:String, color:uint = 0, size:uint = 12, font:String = "", isBold:Boolean = false, isItalic:Boolean = false, isUnderline:Boolean = false, href:String = null, align:String = null):String
		{
			if (isBold)
			{
				str = "<b>" + str + "</b>";
			}
			if (isItalic)
			{
				str = "<i>" + str + "</i>";
			}
			if (isUnderline)
			{
				str = "<u>" + str + "</u>";
			}
			var style:String = "";
			if (font)
			{
				style = style + (" font=\"" + font + "\"");
			}
			if (size > 0)
			{
				style = style + (" size=\"" + size + "\"");
			}
			style = style + (" color=\"#" + color.toString(16) + "\"");
			str = "<font" + style + ">" + str + "</font>";
			if (href)
			{
				str = "<a href=\"" + href + "\" target=\"_blank\">" + str + "</a>";
			}
			if (align)
			{
				str = "<p align=\"" + align + "\">" + str + "</p>";
			}
			return str;
		}

	}
}
