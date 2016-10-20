package game.client.net
{
	


	/**
	 * 服务器回应消息
	 *
	 */
	public class Response
	{
		/**
		 * 成功
		 */
		public static const GC_SUCCESS:int=1;
		/**
		 * 错误提示
		 */
		public static const GC_ERROR_TIP:int=-1;
		/**
		 * 错误不提示
		 */
		public static const GC_ERROR_NOT_TIP:int=-2;
		/**
		 * 服务器异常
		 */
		public static const GC_SERVER_EXCEPTION:int=-100;
		
	}
}