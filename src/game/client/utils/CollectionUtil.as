package game.client.utils
{

	public class CollectionUtil
	{

		/**
		 * 获取最大页数
		 * @param array
		 * @param pageSize
		 */
		public static function getMaxPage(array:Array, pageSize:int):int
		{
			if (CollectionUtil.isArrayEmpty(array))
			{
				return 0;
			}
			var result:int=array.length / pageSize;
			if (array.length % pageSize != 0)
			{
				result+=1;
			}
			return result;
		}

		/**
		 * 从指定集合中取数据
		 * @param array 指定数据集
		 * @param currentPage 开始页
		 * @param pageSize  数据页大小
		 * @return
		 *
		 */
		public static function getArray(array:Array, currentPage:int, pageSize:int):Array
		{
			if (CollectionUtil.isArrayEmpty(array))
			{
				return null;
			}
			var startIndex:int=(currentPage - 1) * pageSize;
			if (startIndex >= array.length)
			{
				return null;
			}
			var result:Array=new Array();
			for (var i:int=0; (startIndex + i) < array.length && i < pageSize; i++)
			{
				result[i]=array[startIndex + i];
			}
			return result;
		}

		/**
		 *根据索引删除数组的元素
		 * @param arr
		 * @param index 删除元素 的索引
		 * @return
		 *
		 */
		public static function delArr(arr:Array, index:int):Array
		{
			if (!isArrayEmpty(arr))
			{
				//delete arr[index];
				arr=arr.slice(0, index).concat(arr.slice(index + 1, arr.length));
			}
			return arr;
		}

		/**
		 * 删除数组的元素
		 * @param arr
		 * @param item 要删除的元素
		 * @return
		 *
		 */
		public static function delArrItem(arr:Array, item:*):Array
		{
			if (!isArrayEmpty(arr))
			{
				var index:int=arr.indexOf(item);
				if (index != -1)
					arr=delArr(arr, index);
			}
			return arr;
		}

		/**
		 *批量删除数组中的元素
		 * @param arr
		 * @param arg 要删除的元素
		 * @return
		 *
		 */
		public static function delArrListItem(arr:Array, ... arg):Array
		{
			if (!isArrayEmpty(arr))
			{
				var argArr:Array=arg;
				if (argArr != null)
				{
					for (var i:String in argArr)
					{
						arr=delArrItem(arr, argArr[i]);
					}
				}
			}
			return arr;
		}
		/**
		 *删除所有元素 
		 * @param arr
		 * 
		 */
		public static function delAllItem(arr:Array):void
		{
			if (isArrayEmpty(arr))
				return;
			arr.splice(0,arr.length);
		}

		/**
		 *交换数组元素位置
		 * @param arr
		 * @param index1
		 * @param index2
		 * @return
		 *
		 */
		public static function swicthArrItem(arr:Array, index1:int, index2:int):Array
		{
			if (!isArrayEmpty(arr))
			{
				if ((index1 != index2) && (arr.length >= index1) && (arr.length >= index2))
				{
					var temp:Object=arr[index1];
					arr[index1]=arr[index2];
					arr[index2]=temp;
				}
			}
			return arr;
		}

		/**
		 * 数据是否为空
		 * @param array
		 * @return true-是 false-否
		 */
		public static function isArrayEmpty(array:Array):Boolean
		{
			if (array == null || array.length == 0)
			{
				return true;
			}
			return false
		}
	}
}