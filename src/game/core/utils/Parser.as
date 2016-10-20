package game.core.utils
{
	
	/**
	 * LUA TABLE 分析器 支持 {func=1 , func2= "你好" ,func3={dd=123}}
	 * TABLE可多层嵌套
	 */
	public class Parser
	{
		private static var data:Array = [];
		
		public static function decode(str:String):Object
		{
			if (!str)
				return null;
			data.length = 0;
			var len:int = str.length;
			for (var i:int = 0; i < len; i++)
			{
				data[i] = str.charAt(i);
			}
			return parserObject(data);
		}
		
		private static function parserObject(data:Array):Object
		{
			if (data.shift() != "{")
				throw new Error("格式错误，没有{");
			var obj:Object = {};
			var char:String;
			var isClearSpace:Boolean
			while (data.length)
			{
				if (!isClearSpace)
					obj[parserKey(data)] = parserValue(data)
				char = data.shift();
				if (char == ",")
				{
					isClearSpace = false;
					continue;
				}
				else if (char == "}")
				{
					isClearSpace = false;
					break;
				}
				else if (char == " ")
				{
					isClearSpace = true;
					continue;
				}
				else
					throw new Error("格式错误");
			}
			return obj;
		}
		
		private static function parserKey(data:Array):String
		{
			var key:String = "";
			var char:String
			while (data.length)
			{
				char = data.shift();
				if (char == "=")
					break;
				else if (char == " ")
					continue;
				else
					key += char;
			}
			return key;
		}
		
		private static function parserValue(data:Array):Object
		{
			var value:Object;
			var char:String;
			var isString:Boolean;
			var isNumber:Boolean;
			var isObject:Boolean;
			while (data.length)
			{
				char = data.shift();
				if (char == "\"")
				{
					if (!isString)
						isString = true;
					else
						break;
				}
				else if (char == "," || char == "}")
				{
					data.unshift(char);
					break;
				}
				else if (char == " " && !isString)
				{
					continue;
				}
				else if (char == "{")
				{
					data.unshift(char);
					return parserObject(data)
				}
				else
				{
					if (!value)
						value = "";
					value += char;
				}
			}
			return Number(value).toString() == "NaN" ? value : Number(value);
		}
	}
}
