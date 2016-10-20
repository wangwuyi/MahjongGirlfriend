package game.client.module.ui.chat
{
	import flash.events.TextEvent;
	import flash.utils.Dictionary;
	
	import game.client.model.GlobalModel;
	import game.client.module.popUI.MsgBox;
	import game.client.module.popUI.PopupMenu;
	import game.client.module.tip.TipManager;

	public class ChatConstant
	{
		private static const OPEN_TRIAL_PANEL:int = 1;
		private static const OPEN_GUILD_DONATE_PANEL:int = 2;
		private static var HANDLER:Object = [onNameLink,onOpenPanel,onItemLink,onFly,onGo,onHorseLink,onGuildApply,onTeamRecruit,onTeamApply,onSchoolApply,onBuyItem];

		public static const CHAT_CHANNEL_ALL:int = 0;
		public static const CHAT_CHANNEL_WORLD:int = 1;
        public static const CHAT_CHANNEL_SCENE:int = 2;
        public static const CHAT_CHANNEL_CAMP:int = 3;
		public static const CHAT_CHANNEL_GUILD:int = 4;
		public static const CHAT_CHANNEL_TEAM:int = 5;
	    public static const CHAT_CHANNEL_PRI:int = 6;
		
		public static const MSG_TYPE_WORLD:int = 0;
		public static const MSG_TYPE_SCENE:int = 1;
		public static const MSG_TYPE_CAMP:int = 2;
		public static const MSG_TYPE_GUILD:int = 3;
		public static const MSG_TYPE_TEAM:int = 4;
		public static const MSG_TYPE_PRIVATE:int = 5;
		public static const MSG_TYPE_SPEAKER:int = 6;
		public static const MSG_TYPE_SYSTEM:int = 7;
		
		public static const CHAT_ALL_CHANNEL:Array = ["世界","场景","阵营","帮会","组队","私聊","传音"];
		public static const CHAT_CHANNEL:Array = ["世界","场景","阵营","帮会","组队","私聊","传音","系统"];
		public static const SEX:Array = [null,["♂","#5D76F3"],["♀","#FF00A8"]];
		public static const CHANNEL_COLOR:Array = ["#eb7b29","#8bf0ff","#39ceff","#2eebdb","#FFFFFF","#fee400","#fe4c5a"];	
		public static const TIME_SEND:Array = [10*1000, 2*1000, 2*1000, 2*1000, 2*1000, 2*1000, 0*1000];
		public static const SHAKE:int = 1;
		
		public static const ACTION_NAME_LINK:int = 0;
		public static const ACTION_OPEN_PANEL:int = 1;
		public static const ACTION_ITEM_LINK:int = 2;
		public static const ACTION_ITEM_FLY:int = 3;
		public static const ACTION_ITEM_GO:int = 4;
		public static const ACTION_HORSE_LINK:int = 5;
		public static const ACTION_GUILD_APPLY:int = 6;
		public static const ACTION_TEAM_RECRUIT:int = 7;
		
		public static const PRI_CHAT_NAME:int = 0;
		public static const PRI_CHAT_LV:int = 1;
		public static const PRI_CHAT_ICON:int = 2;
		public static const PRI_CHAT_GUILD_NAME:int = 3;
		public static const PRI_CHAT_OBJID:int = 4;
		
		public static const NO_CAMP:int = 0;
		
		public static const PRI_CHAT_MAX_NUM_HEAD:int = 5;
		public static const PRI_CHAT_ICON_WIDTH:int = 65;
		
		public static const LABA_MAGIC_ID:int = 1;
		public static const LABA_MAGIC_KUANG_ID:int = 2;
		
		public static const TYPE_SHOW_ROLE:int = 1;
		public static const TYPE_SHOW_BAG:int = 2;
		public static const TYPE_SHOW_HORSE:int = 3;
		
		public static const LABA_ID:int = 218001;
		
		public static var priChatPanelDic:Dictionary = new Dictionary;
		public static var priChatHeadArr:Array = [];
		public static var priChatNameArr:Array = [];
		public static var pinbiArr:Array = [];
		public static var relateChatArr:Array = [];
		public static var relateChatNameArr:Array = [];
		/*物品展示列表*/
		public static var chatShowArr:Array = [];
		public static var needPriChat:Boolean;
		public static var unableShake:Boolean;
		
		public static function onTextEventLink(e:TextEvent):void
		{
			var data:Array = e.text.split("_");
			var action:int;
			var args:Array;
			action = int(data[0]);
		    args = data[1].split(",");
			HANDLER[action].apply(null,args);
		}
		
		public static function onNameLink(objId:int,name:String):void
		{
			if(name == GlobalModel.hero.name)
			{
				return;
			}
			PopupMenu.objID = objId;
			PopupMenu.data = [objId,name];
			var items:Array =  [PopupMenu.STR_PRI_RIGHT_NOW,PopupMenu.STR_PRI_CHAT,PopupMenu.STR_TEAM,PopupMenu.STR_COPY_NAME,PopupMenu.STR_PRESENT_FLOWER
				,PopupMenu.STR_ADD_FRIEND,PopupMenu.STR_DEAL,PopupMenu.STR_SEND_MAIL,PopupMenu.STR_INVITE_GUILD];
			
			PopupMenu.show(objId,items);
		}
		
		public static function onOpenPanel(link:int):void
		{
			switch(link)
			{
				case OPEN_TRIAL_PANEL:
					//TrialListPanel.instance.visible = !TrialListPanel.instance.visible;
					break;
				case OPEN_GUILD_DONATE_PANEL:
					//GuildDonateGoodsPanel.instance.visible = !GuildDonateGoodsPanel.instance.visible;
					break;
			}
		}
		
		public static function onItemLink(objId:int,id:int,pos:int,count:int,isBind:int,equipId:int,strenghthen:int):void
		{
			/*var dataVO:BagDataVO = new BagDataVO();
			var data:Array = [id,pos,count,isBind,equipId];
			dataVO.init(data);
			var type:int = dataVO.type;
			if(type != BagType.TYPE_EQUIP)
			{
				TipManager.bindByPosition(dataVO,GlobalModel.stage.mouseX,GlobalModel.stage.mouseY,true,ItemTip);
			}
			else 
			{
				TipManager.bindByPosition(dataVO,GlobalModel.stage.mouseX,GlobalModel.stage.mouseY,true,EquipTip);
			}*/
		}
		
		public static function onHorseLink(objId:int,index:int,name:String,icon:int,powerIcon:int,power:int,powerPercent:int,id:int,jjBless:int):void
		{
			/*var dataVO:MountDataVo= new MountDataVo();
			var data:Array = [index,name,icon,powerIcon,power,powerPercent,id,jjBless];
			dataVO.init(data);
			TipManager.bindByPosition(dataVO,GlobalModel.stage.mouseX,GlobalModel.stage.mouseY,true,MountTip);*/
		}
		
		public static function onFly(mapId:int,x:int,y:int):void
		{
			GlobalModel.hero.flyToMapPoint(mapId, x, y);
		}
		
		public static function onGo(mapId:int,x:int,y:int):void
		{
			GlobalModel.hero.walkToTargetPosition(x, y, mapId);
		}
		
		public static function onGuildApply(guildId:int):void
		{
			//GuildClient.getInstance().guildApplyJoin(guildId);
		}

		public static function onTeamRecruit(inviteName:String,copyId:int,time:int):void
		{
			//TeamClient.getInstance().teamInviteReply(TeamConstant.AGREE,inviteName,time);
		}
		public static function onSchoolApply(masterName:String):void
		{
			//SchoolClient.getInstance().masterApply(masterName);
		}

		public static function onBuyItem(marketId:int, totalPrice:int, num:int, name:String):void
		{
			MsgBox.show("你是否花费"+totalPrice+"元宝购买"+num+"个"+name+"？", MsgBox.YES_OR_NO, function (ret:uint):void
			{
				if(ret == MsgBox.YES)
				{
					//MarketClient.getInstance().marketBuy(marketId);
				}
			});
		}
		
		public static function onTeamApply(userName:String):void
		{
			//TeamClient.getInstance().teamInvite(userName,0);
		}
	}
}