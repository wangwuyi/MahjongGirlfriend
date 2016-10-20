package game.client.module.popUI
{
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import game.client.model.GlobalModel;
	import game.client.module.popUI.listItem.ComboBoxItem;
	import game.client.module.popUI.listItem.ComboxList;
	import game.client.module.ui.chat.ChatPanel;
	import game.client.module.ui.menu.CommonMenuMethod;


	public class PopupMenu 
	{
		public static const STR_PRI_CHAT:String= "私聊";
		public static const STR_TEAM:String= "组队";
		public static const STR_COPY_NAME:String= "复制名字";
		public static const STR_INVITE_GUILD:String= "邀请入帮";
		public static const STR_PRESENT_FLOWER:String = "赠送鲜花";
		public static const STR_EXIT_TEAM:String = "退出队伍";
		public static const STR_APPOINT_LEADER:String = "委任队长";
		public static const STR_KICK_TEAM:String = "踢出队伍";
		public static const STR_DEAL:String = "交易";
		public static const STR_ADD_FRIEND:String = "加为好友";
		public static const STR_SEND_MAIL:String = "发送邮件";
		public static const STR_PRI_RIGHT_NOW:String = "立即私聊";
		public static const STR_QUERY:String = "查询";
		public static const STR_ADD_FRIEND_SIMPLE:String = "交友";
		
		public static const OBJ_ID:int = 0;
		public static const OBJ_NAME:int = 1;
		public static const TEAM_POS:int = 2;
		
		private static var nameLinkList:ComboxList;
		public static var objID:int;
		public static var data:Array = [];
		
		public static function show(objId:int,items:Array):void
		{
			if(objId == GlobalModel.hero.id)
			{
				return;
			}
			objID = objId;
			if(nameLinkList == null)
			{
				nameLinkList = new ComboxList();
			}
			nameLinkList.setItem([items,nameLink,ComboBoxItem.TYPE_OTHER]);
			nameLinkList.x = GlobalModel.stage.mouseX + 20;
			if(GlobalModel.stage.mouseY + nameLinkList.Bg.height > GlobalModel.stage.stageHeight) 
			{
				nameLinkList.y = GlobalModel.stage.stageHeight - nameLinkList.Bg.height - 5;
			}
			else  
			{
				nameLinkList.y = GlobalModel.stage.mouseY + 2;
			}
			if(GlobalModel.stage.contains(nameLinkList) == false)
			{
				GlobalModel.stage.addChild(nameLinkList);
			}
		}
		
		public static function hide():void
		{
			if(nameLinkList && nameLinkList.parent)
			{
				nameLinkList.parent.removeChild(nameLinkList);
			}
		}
		
		private static function nameLink(e:MouseEvent):void
		{
			hide();
			var name:String = (e.currentTarget as ComboBoxItem).itemName;
			switch(name)
			{
				case STR_PRI_CHAT:
					priChat();
					break;
				case STR_TEAM:
					team();
					break;
				case STR_COPY_NAME:
					copyName();
					break;
				case STR_INVITE_GUILD:
					guildInvite();
					break;
				case STR_PRESENT_FLOWER:
					//PresentFlowerPanel.instance.sendToUser(data[OBJ_NAME]);
					break;
				case STR_EXIT_TEAM:
					exitTeam();
					break;
				case STR_APPOINT_LEADER:
					appointLeader();
					break;
				case STR_KICK_TEAM:
					kickTeam();
					break;
				case STR_DEAL:
					inviteTrade();
					break;
				case STR_ADD_FRIEND:
				case STR_ADD_FRIEND_SIMPLE:
					addFriend();
					break;
				case STR_SEND_MAIL:
					sendMail();
					break;
				case STR_PRI_RIGHT_NOW:
					prichatRightNow();
					break;
				case STR_QUERY:
					//UserClient.getInstance().queryPlayerInfo(data[OBJ_NAME]);
					break;
			}
		}
		
		private static function guildInvite():void
		{
			//GuildClient.getInstance().guildInvite(data[OBJ_NAME]);
		}
		
		private static  function priChat():void
		{
			//UserClient.getInstance().humanQuery(data[OBJ_NAME],GlobalModel.HUAME_PRIVATE_CHAT);
		}
		
		private static function team():void
		{
			//TeamClient.getInstance().teamInvite(data[OBJ_NAME],TeamConstant.NORMAL_TEAM);
		}
		
		private static function copyName():void
		{
			System.setClipboard(data[OBJ_NAME]);
		}
		
		public static function exitTeam():void
		{
			MsgBox.show("您确定要退出队伍吗？",MsgBox.YES_OR_NO,function(index:int):void
			{
				if(index == MsgBox.YES)
				{
					//TeamClient.getInstance().teamExit();
				}
			});
		}
		
		public static function appointLeader():void
		{
			//TeamClient.getInstance().appointLeader(data[TEAM_POS]);
		}
		
		public static function kickTeam():void
		{
			MsgBox.show("您确定要将"+data[OBJ_NAME]+"移除出队伍吗？",MsgBox.YES_OR_NO,function(index:int):void
			{
				if(index == MsgBox.YES)
				{
					//TeamClient.getInstance().teamKick(data[TEAM_POS]);
				}
			});
		}
		
		private static function inviteTrade():void
		{
			//CommonMenuMethod.inviteTrade(data[OBJ_NAME]);
		}
		
		private static function addFriend():void
		{
			CommonMenuMethod.addFriend(data[OBJ_NAME]);
		}
		
		private static function sendMail():void
		{
			CommonMenuMethod.sendEmail(data[OBJ_NAME]);
		}
		
		private static function prichatRightNow():void
		{
			ChatPanel.getInstance().setPriInput(data[OBJ_NAME]);
		}
		
	}
}