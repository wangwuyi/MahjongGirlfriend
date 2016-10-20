
package game.client.utils
{

	import flash.utils.Dictionary;

	public class HashMap
	{

		private var length:int;
		private var content:Dictionary;

		public function HashMap()
		{
			length=0;
			content=new Dictionary();
		}
		
		public function size():int
		{
			return length;
		}
		
		public function isEmpty():Boolean
		{
			return (length == 0);
		}
		
		public function keys():Array
		{
			var temp:Array=new Array(length);
			var index:int=0;
			for (var i:* in content)
			{
				temp[index]=i;
				index++;
			}
			return temp;
		}
		
		public function values():Array
		{
			var temp:Array=new Array(length);
			var index:int=0;
			for each (var i:* in content)
			{
				temp[index]=i;
				index++;
			}
			return temp;
		}
		
		public function containsValue(value:*):Boolean
		{
			for each (var i:* in content)
			{
				if (i === value)
				{
					return true;
				}
			}
			return false;
		}
		
		public function containsKey(key:*):Boolean
		{
			if (content[key] != undefined)
			{
				return true;
			}
			return false;
		}

		public function get(key:*):*
		{
			var value:*=content[key];
			if (value !== undefined)
			{
				return value;
			}
			return null;
		}

		public function getValue(key:*):*
		{
			return get(key);
		}

		public function put(key:*, value:*):*
		{
			if (key == null)
			{
				throw new ArgumentError("cannot put a value with undefined or null key!");
				return undefined;
			}
			else
			{
				var exist:Boolean=containsKey(key);
				if (!exist)
				{
					length++;
				}
				var oldValue:*=this.get(key);
				content[key]=value;
				return oldValue;
			}
		}

		public function remove(key:*):*
		{
			var exist:Boolean=containsKey(key);
			if (!exist)
			{
				return null;
			}
			var temp:*=content[key];
			delete content[key];
			length--;
			return temp;
		}

		public function clear():void
		{
			length=0;
			content=new Dictionary();
		}

		/**
		 * Return a same copy of HashMap object
		 */
		public function clone():HashMap
		{
			var temp:HashMap=new HashMap();
			for (var i:* in content)
			{
				temp.put(i, content[i]);
			}
			return temp;
		}

		public function toString():String
		{
			var ks:Array=keys();
			var vs:Array=values();
			var temp:String="HashMap Content:\n";
			for (var i:int=0; i < ks.length; i++)
			{
				temp+=ks[i] + " -> " + vs[i] + "\n";
			}
			return temp;
		}
	}

}