package game.client.net.handler.common
{
	import game.client.module.ui.broadcast.Alert;
	import game.client.module.ui.broadcast.BroadcastMarquee;
	import game.client.module.ui.chat.ChatAction;
	import game.client.module.ui.chat.ChatConstant;
	import game.client.module.ui.chat.ChatPanel;
	import game.client.net.handler.CmdType;
	import game.client.net.handler.user.UserHandler;
	import game.client.utils.HashMap;
	import game.client.utils.HtmlUtil;
	import game.core.net.Handler;
	
	public class CommonHandler extends Handler
	{
		public static const ERR_OK:int                                     = 0;
		public static const ERR_FAIL:int                                     = 1;
		
		private static const POS_TEAM:int = 0;//组队聊天频道
		private static const POS_UP:int = 1;
		private static const POS_CENTER:int = 2;
		private static const POS_DOWN:int = 3;
		private static const POS_WORLD:int = 4;
		private static const POS_WIN:int = 5//弹窗;
		private static const POS_GUILDCHAT:int =6;//帮会聊天
		private static const POS_RUMOR:int = 7//传闻
		private static const POS_RIGHT_DOWN:int = 8//右下
		private static const POS_MARQUEE:int = 9//走马灯广播（从右向左滚动）
		
		private static var modulReturnCodeHandlerList:HashMap = new HashMap();
		
		public function CommonHandler()
		{
			register(CommonCmd.GC_BROADCAST, [2,0], broadcast);
			register(CommonCmd.GC_RETURN_CODE, [1,3,3,2], returnCode);
			modulReturnCodeHandlerList.put(CmdType.USER_TYPE, UserHandler.returnCode);
		}
		
		/**
		 content:256  //显示内容
		 pos:1  //显示位置
		 */
		public function broadcast(content:String,pos:int):void 
		{
			var message:String = content;
			var posStr:String = pos + "";
			var len:int = posStr.length;
			for(var index:int = 0; index < len;index++)
			{
				var posValue:int = int(posStr.charAt(index));
				switch(posValue)
				{
					case POS_UP:
						Alert.show(message,Alert.UP);
						break;
					case POS_DOWN:
						Alert.show(message,Alert.DOWN);
						break;
					case POS_CENTER:
						Alert.show(message,Alert.CENTER);
						break;
					case POS_WORLD:
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_ALL,"【<b> 系统 </b>】" + message);
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_WORLD,"【<b> 系统 </b>】" + message);
						break;
					case POS_RUMOR:
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_ALL,"【<b> 传闻 </b>】 " + message);
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_WORLD,"【<b> 传闻  </b>】 " + message);
						break;
					case POS_WIN:
						break;
					case POS_GUILDCHAT:
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_GUILD, message);
						var syetemContent:String =  HtmlUtil.textColor("系统：","#ff0000") + ChatAction.SYS_TIME.replace("$text",ChatAction.systemTime)+"\n" + message;
						break;
					case POS_RIGHT_DOWN:
						Alert.show(message,Alert.RIGHT_DOWN);
						break;
					case POS_MARQUEE:
						BroadcastMarquee.show(message);
						break;
					case POS_TEAM:
						ChatPanel.getInstance().writeMsg(ChatConstant.CHAT_CHANNEL_TEAM,message);
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 id:1  //id
		 showWay:1  //消息显示方式
		 retCode:1  //返回码 0 成功 1失败
		 content:2  //显示内容
		 */
		public static function returnCode(id:int,showWay:int,retCode:int,content:String):void
		{	
			var moduleType:int = int(String(id).substr(0,3));
			var handlerFun:Function = modulReturnCodeHandlerList.get(moduleType) as Function;
			if(handlerFun != null)
			{
				handlerFun.apply(null,arguments);
			}
			else
			{
				trace("没找到 GC_RETURN_CODE 返回消息id = " + id + "对应模块的处理函数");
			}
		}
	}
}