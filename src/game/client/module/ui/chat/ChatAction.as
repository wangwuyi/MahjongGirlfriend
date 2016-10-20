package game.client.module.ui.chat
{
	import game.client.model.GlobalModel;
	import game.client.utils.ColorUtil;
	import game.core.utils.Timer;
	import game.core.utils.Tween;

	public class ChatAction
	{
		private static var lastLabaTime:int;
		private static var time:int;
		private static var lastShakeTime:int;
		public static const SHAKE_TIME:int = 30;
		private static var shakeTime:int =SHAKE_TIME;
		private static var sendName:String;
		public static const SYS_TIME:String="<font color='#00ff00'>$text</font>";
		
		public function ChatAction()
		{
		}
		
		public static function startLaba():void
		{
			time = 0;
			Timer.add(run);
		}
		
		public static function stopLaba():void
		{
			ChatPanel.getInstance().hideLaba();
			Timer.remove(run);
			time = 0;
		}
		
		private static function run(now:uint):void
		{
			if(now -lastLabaTime >1000)
			{
				lastLabaTime = now;
				time ++;
				if(time >= 15)
				{
					stopLaba();
				}
			}
		}
		
		private static function runShake(now:uint):void
		{
			if(now -lastShakeTime > 1000)
			{
				lastShakeTime = now;
				shakeTime --;
				if(shakeTime <= 0)
				{
					Timer.remove(runShake);
					shakeTime = SHAKE_TIME;
				}
			}
		}
		
		public static function shake(name:String):void
		{
			sendName = name;
			Timer.add(runShake);
			//Tween.to(ChatAction.getPriChatPanel(sendName),100,{x:[ChatAction.getPriChatPanel(sendName).x,ChatAction.getPriChatPanel(sendName).x + 20]},downShake);
		}
		
		private static function upShake():void
		{
			//Tween.to(ChatAction.getPriChatPanel(sendName),100,{y:[ChatAction.getPriChatPanel(sendName).y,ChatAction.getPriChatPanel(sendName).y + 20]});
		}
		
		private static function leftShake():void
		{
			//Tween.to(ChatAction.getPriChatPanel(sendName),100,{x:[ChatAction.getPriChatPanel(sendName).x,ChatAction.getPriChatPanel(sendName).x - 20]},upShake);
		}

       private static function downShake():void
       {
		   //Tween.to(ChatAction.getPriChatPanel(sendName),100,{y:[ChatAction.getPriChatPanel(sendName).y,ChatAction.getPriChatPanel(sendName).y - 20]},leftShake);
       }
	   
	   /*public static function getPriChatPanel(name:String):PrivateChatPanel
	   {
		   if(name == GlobalModel.hero.name)
		   {
			   return null;
		   }
		   if(ChatConstant.priChatPanelDic[name] == null)
		   {
			   var priChatPanel:PrivateChatPanel;
			   priChatPanel = PrivateChatPanel.getInstance();
			   priChatPanel.ownName = name;
			   priChatPanel.updateShake();
			   ChatConstant.priChatPanelDic[name] = priChatPanel;
		   }
		   return  ChatConstant.priChatPanelDic[name] as PrivateChatPanel;
	   }*/
	   
	   /*public static function updateShake():void
	   {
		   for each(var priChatPanel:PrivateChatPanel in ChatConstant.priChatPanelDic)
		   {
			   priChatPanel.updateShake();
		   }
	   }*/
	   
	   /*public static function operatePriChatHeadArr(name:String,chatHead:ChatHeadShow):void
	   {
		   ChatConstant.priChatHeadArr.push(chatHead);
		   ChatConstant.priChatNameArr.push(name);
		   if(ChatConstant.priChatHeadArr.length > ChatConstant.PRI_CHAT_MAX_NUM_HEAD)
		   {
			   chatHead= ChatConstant.priChatHeadArr.shift();
			   chatHead.hide();
			   chatHeadAlign();
			   ChatConstant.priChatNameArr.shift();
		   }
	   }*/
	   
	  /* private static function chatHeadAlign():void
	   {
		   var i:int = 0;
		   for each(var chatHead:ChatHeadShow in ChatConstant.priChatHeadArr)
		   {
			   chatHead.x = GlobalModel.stage.stageWidth/2 + i * ChatConstant.PRI_CHAT_ICON_WIDTH;
			   i++;
		   }
	   }*/
	   
	   public static function setShowData(content:String,type:int,index:int):void
	   {
		   ChatPanel.getInstance().setInputTxt(content);
		   ChatConstant.chatShowArr.push([type,index]);
	   }
	   
	   public static function getItemShowStr(objId:int,content:String,itemList:Array,horseList:Array):String
	   {
		   if(content.indexOf("$")!=-1 && content.indexOf("$") != content.lastIndexOf("$"))
		   {
			   var arr:Array;
			   var itemStr:String=content.substring(content.indexOf("$") + 1,content.lastIndexOf("$"));
			   if(horseList && horseList.length > 0)
			   {
				   arr = horseList[0];
				   content = content.replace("$"+itemStr+"$", "<font color='"+ColorUtil.GOLD+"'><u><a href='event:"+ChatConstant.ACTION_HORSE_LINK+"_"+objId+","+ arr +"'>"+itemStr+" </a></u></font>");
			   }
			   else if(itemList && itemList.length > 0)
			   {
				   arr =[itemList[0][0],1,1,itemList[0][2],itemList[0][1],itemList[0][3]];
				   content = content.replace("$"+itemStr+"$", "<font color='"+ColorUtil.GOLD+"'><u><a href='event:"+ChatConstant.ACTION_ITEM_LINK+"_"+objId+","+ arr +"'>"+itemStr+" </a></u></font>");
			   }
		   }
		   return content;
	   }
	   
	   public static function getXYStr(content:String):String
	   {
		   if(content.indexOf("&")!=-1 && content.indexOf("&") != content.lastIndexOf("&"))
		   {
			   var str:String=content.substring(content.indexOf("&") + 1,content.lastIndexOf("&"));
			   var arr:Array = str.split(",");
			   if(arr == null || arr.length < 3)
			   {
				   return content;
			   }
			   content = "来找我吧！<font color='"+ColorUtil.GREEN+"'><u><a href='event:"+ChatConstant.ACTION_ITEM_GO+"_"+arr[0]+","+arr[1] +","+arr[2]+"'>["+arr[1] +","+arr[2]+"]</a></u></font>"+
				   "  <font color='"+ColorUtil.GREEN+"'><u><a href='event:"+ChatConstant.ACTION_ITEM_FLY+"_"+arr[0]+","+arr[1] +","+arr[2]+"'>[传送]</a></u></font>";
		   }
		   return content;
	   }
	   
	   public static function get systemTime():String
	   {
		   var nowDate:Date=new Date();
		   var hour:String = String((nowDate.hours<10?"0":"")+nowDate.hours);
		   var minute:String = String((nowDate.minutes<10?"0":"")+nowDate.minutes);
		   var second:String = String((nowDate.seconds<10?"0":"")+nowDate.seconds);
		   var ret:String="["+hour+":"+minute+":"+second+"] ";
		   return ret;
	   }
	   
	}
}