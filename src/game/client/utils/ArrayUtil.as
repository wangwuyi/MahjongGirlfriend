package game.client.utils
{
	/**
	 * array工具类
	 * @author wwy
	 * 
	 */	
	public class ArrayUtil
	{
		/**
		 * 删除数组重复数据 
		 * @param array
		 * @return 
		 * 
		 */		
		public static function deleteDuplication(array:Array):Array{
			var hash:Object = {};
			var result:Array = [];
			for(var i:int = 0, len:int = array.length; i < len; i++){
				if(!hash[array[i]]){
					result.push(array[i]);
					hash[array[i]] = true;
				}
			}
			return result;
		}
	}
}