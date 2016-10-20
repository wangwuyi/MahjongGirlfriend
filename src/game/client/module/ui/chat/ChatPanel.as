package game.client.module.ui.chat
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import game.client.manager.SingletonFactory;
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.chatCommon.Face;
	import game.client.module.chatCommon.FaceCreator;
	import game.client.module.chatCommon.IHasInput;
	import game.client.module.chatCommon.RichText;
	import game.client.module.chatCommon.TextList;
	import game.client.module.popUI.listItem.ComboBoxItem;
	import game.client.module.popUI.listItem.ComboxList;
	import game.client.module.tip.TipManager;
	import game.client.module.ui.chat.skin.ChatPanelSkin;
	import game.client.module.ui.mainMenu.MainMenuPanel;
	import game.component.Button;
	import game.component.Label;
	import game.component.RadioButton;
	import game.component.RadioButtonGroup;
	import game.component.ScrollBar;
	import game.core.gameUnit.magic.Magic;
	
	public class ChatPanel extends BasePanel  implements IHasInput
	{
		private static const LABA_MAGIC_TIME:int = 500;
		private var inputTxt:TextField;
		private var textList:TextList = new TextList;
		private var labaTxt:RichText;
		private var labaMagic:Magic;
		private var labaMagicKuang:Magic;
		private var msgScroll:ScrollBar;
		private var pinbiList:ComboxList;
		private var channelList:ComboxList;
		private var type:int;
		private var msgType:int;
		private var tabs:RadioButtonGroup;
		private var btnAll:RadioButton;
		private var btnWorld:RadioButton;
		private var btnScene:RadioButton;
		private var btnCamp:RadioButton;
		private var btnGuild:RadioButton;
		private var btnTeam:RadioButton;
		private var btnSpeaker:RadioButton;
		
		private var btnExpansion:Button;
		private var btnPinbi:Button;
		private var btnChannel:Button;
		private var btnFace:Button;
		private var btnSend:Button;
		private var btnExpressFace:Button;
		private var channelBtnArr:Array =[];//真正的频道是从世界频道开始
		private var _msgArray:Array = [];
		private var historyInputList:Array = [];
		private var lastSendTime:uint = 0;
		private var back:Bitmap;
		private var priChatName:String;
		private static const KEY_UP:int = 38
		private static const KEY_DOWN:int = 40
		private static var currentHistoryIndex:int;
		private static const ERROR:Array = ["","","","你没有所属的阵营","你没有所属的帮会","你没有所属的队伍","你没有传音道具"]
		private static const LOW_HEIGHT:int = 188;
		private static const MID_HEIGHT:int = 233;
		private static const HIGH_HEIGHT:int = 278;
		private static const HISTORY_NUM_MAX:int = 10;
		
		public static function getInstance():ChatPanel
		{
			return SingletonFactory.createObject(ChatPanel);
		}
		
		public function ChatPanel()
		{
			initSkin();
			initText();
			initBtn();
			initLaba();
		}
		
		private function initSkin():void
		{
			this.skin = ChatPanelSkin.skin;
			back = getChildByName("liaotiankuang") as Bitmap;
		}
		
		private function initText():void
		{
			var txtChat:Label = getChildByName("txtwanjiaming") as Label;
			removeChild(txtChat);
			inputTxt = new TextField();
			inputTxt.x =60;
			inputTxt.y = 194;
			inputTxt.width =168;
			inputTxt.height =25;
			inputTxt.type =TextFieldType.INPUT;
			inputTxt.maxChars = 50;
			inputTxt.mouseEnabled = true;
			inputTxt.selectable = true;
			inputTxt.wordWrap = false;
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0xFFFF00;
			format.size = 12;
			format.leading = 4;
			inputTxt.defaultTextFormat = format;
			inputTxt.text = "请输入聊天内容";
			addChild(inputTxt);
			
			inputTxt.addEventListener(FocusEvent.FOCUS_IN, onInputFocusIn);
			inputTxt.addEventListener(KeyboardEvent.KEY_UP, onKey);
			inputTxt.addEventListener(Event.CHANGE,onChange);
			
			textList.x = 28;
			addChild(textList);
			textList.addEventListener(Event.CHANGE,textListChange);
			msgScroll = getChildByName("msgScroll") as ScrollBar;
			msgScroll.isThumbDown = true;
			textList.y = back.y = msgScroll.y;
			msgScroll.target = textList;
		}
		
		private function initBtn():void
		{
			tabs = getChildByName("tabs") as RadioButtonGroup;
			tabs.addEventListener(Event.CHANGE,onChatTypeChange);
			btnAll = tabs.getChildByName("all") as RadioButton;
			btnWorld = tabs.getChildByName("world") as RadioButton;
			btnScene = tabs.getChildByName("scene") as RadioButton;
			btnCamp = tabs.getChildByName("camp") as RadioButton;
			btnGuild = tabs.getChildByName("guild") as RadioButton;
			btnTeam = tabs.getChildByName("team") as RadioButton;
			btnSpeaker = tabs.getChildByName("speaker") as RadioButton;
			btnSpeaker.selected = false;
			btnFace = getChildByName("xiaolian") as Button;
			btnSend = getChildByName("huiche") as Button;
			btnExpansion = getChildByName("expansion") as Button;
			btnPinbi= getChildByName("pinbi") as Button;
			btnChannel =getChildByName("channal") as Button;
			
			btnExpressFace =getChildByName("xin") as Button;
			channelBtnArr = [btnAll,btnWorld,btnScene,btnCamp,btnGuild,btnTeam,btnSpeaker];
			
			TipManager.bind("发送消息",btnSend);
			TipManager.bind("插入表情",btnFace);
			TipManager.bind("传音告白",btnExpressFace);
			pinbiList = new ComboxList();
			pinbiList.setItem([ChatConstant.CHAT_ALL_CHANNEL,pinbi,ComboBoxItem.TYPE_PINBI]);
			channelList =  new ComboxList();
			channelList.setItem([ChatConstant.CHAT_ALL_CHANNEL,channel,ComboBoxItem.TYPE_CHANNAL]);
			btnFace.addEventListener(MouseEvent.CLICK,showFacePanel);
			btnFace.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				e.stopPropagation();
			});
			btnSend.addEventListener(MouseEvent.CLICK,sendMsg);
			btnExpressFace.addEventListener(MouseEvent.CLICK,onExpressLove);
			btnExpansion.addEventListener(MouseEvent.CLICK,expansion);
			btnPinbi.addEventListener(MouseEvent.CLICK,showPinbi);
			btnChannel.addEventListener(MouseEvent.CLICK,showChannel);
			btnAll.addEventListener(MouseEvent.MOUSE_DOWN,onChatTypeChange);
			btnPinbi.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				e.stopPropagation();
			});
			btnChannel.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
			{
				e.stopPropagation();
			});
			for (var i:int = 0; i < ChatConstant.CHAT_CHANNEL.length; i++)
			{
				_msgArray[i] = [];
				writeMsg(i,"<font color='#ff0000'>抵制不良游戏 拒绝盗版游戏 注意自我保护,谨防受骗上当 适度游戏益脑 沉迷游戏伤身,合理安排时间 享受健康生活</font>");
			}
			tabs.selection = btnAll;
			tabs.dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function initLaba():void
		{
			labaMagicKuang = new Magic();
			labaMagicKuang.x = 170;
			labaMagicKuang.y = -40;
			addChild(labaMagicKuang);
			
			labaMagic = new Magic();
			labaMagic.x = 170;
			labaMagic.y = -40;
			addChild(labaMagic);
			
			labaTxt = new RichText();
			labaTxt.x = 5;
			labaTxt.y = labaMagic.y - 24;
			labaTxt.width = 330;
			labaTxt.height = 60;
			addChild(labaTxt);
		}
		
		public function showLaba(msg:String):void
		{
			labaTxt.htmlText = msg;
			labaTxt.visible = true;
			labaMagicKuang.init(0,ChatConstant.LABA_MAGIC_KUANG_ID,LABA_MAGIC_TIME,true);
			labaMagic.init(0,ChatConstant.LABA_MAGIC_ID,LABA_MAGIC_TIME,true);
			
			addChild(labaMagicKuang);
			addChild(labaMagic);
			
			ChatAction.startLaba();
		}
		
		public function hideLaba():void
		{
			removeChild(labaMagicKuang);
			removeChild(labaMagic);
			
			labaMagicKuang.disposeEffect();
			labaMagic.disposeEffect();
			labaTxt.visible = false;
		}
		
		private function pinbi(e:MouseEvent):void
		{
			var currentIndex:int =(e.currentTarget as ComboBoxItem).index;
			if(ChatConstant.pinbiArr == null)
			{
				ChatConstant.pinbiArr  = [];
			}
			var index:int = ChatConstant.pinbiArr.indexOf(currentIndex);
			if(index != -1)
			{
				ChatConstant.pinbiArr.splice(index,1);
			}
			else
			{
				ChatConstant.pinbiArr.push(currentIndex);
			}
		}
		
		private function channel(e:MouseEvent):void
		{
			var index:int = (e.currentTarget as ComboBoxItem).index;
			GlobalModel.stage.removeChild(channelList);
			btnChannel.label.text = ChatConstant.CHAT_ALL_CHANNEL[index];
			msgType =index;
			textList.data = _msgArray[type];
		}
		
		private function showPinbi(e:MouseEvent):void
		{
			if(GlobalModel.stage.contains(pinbiList))
			{
				GlobalModel.stage.removeChild(pinbiList);
			}
			else
			{
				GlobalModel.stage.addChild(pinbiList);
				pinbiList.x =this.x + 295;
				pinbiList.y =this.y + 32;
			}
		}
		
		private function showChannel(e:MouseEvent):void
		{
			if(GlobalModel.stage.contains(channelList))
			{
				GlobalModel.stage.removeChild(channelList);
			}
			else
			{
				GlobalModel.stage.addChild(channelList);
				channelList.x = this.x + 10;
				channelList.y = this.y + 55;
			}
		}
		
		private function expansion(e:MouseEvent):void
		{
			if(back.height ==HIGH_HEIGHT)
			{
				updatePosition(LOW_HEIGHT,HIGH_HEIGHT);
			}
			else if(back.height ==MID_HEIGHT)
			{	
				updatePosition(HIGH_HEIGHT,MID_HEIGHT);
			}
			else
			{
				updatePosition(MID_HEIGHT,LOW_HEIGHT);
			}
		}
		
		/**
		 * 改变聊天框高度
		 * @param currentHeight 改变后的高度
		 * @param originHeight  改变前的高度
		 */		
		private function updatePosition(currentHeight:int,originHeight:int):void
		{
			var needChangeHeight:int = currentHeight - originHeight;
			back.height = currentHeight;
			back.y -= needChangeHeight;
			textList.y -= needChangeHeight;
			msgScroll.y -= needChangeHeight;
			msgScroll.height += needChangeHeight;
			msgScroll.target = textList;
			labaMagicKuang.y = labaMagic.y = back.y - 40;
			labaTxt.y = labaMagic.y - 24;
		}
		
		private function showFacePanel(e:MouseEvent):void
		{
			var face:Face = FaceCreator.createFace(this, e.currentTarget as DisplayObject,this);
			GlobalModel.stage.contains(face) ? GlobalModel.stage.removeChild(face) : GlobalModel.stage.addChild(face);
		}
		
		private function sendMsg(e:MouseEvent):void
		{
			dosend();
		}
		
		public function dosend():void
		{
			var sendMessage:String = inputTxt.text;
			if (sendMessage == "" || sendMessage == "请输入聊天内容" ||  sendMessage == "喇叭频道需要消耗一个喇叭。")
			{
				inputTxt.text = "";
				return;
			}
			if(ChatConstant.pinbiArr.indexOf(msgType) != -1)
			{
				writeMsg(type,"您已屏蔽该频道，如需发言，请取消屏蔽后再发言");
				return ;
			}
			if(msgType == ChatConstant.MSG_TYPE_PRIVATE)
			{
				sendPriChat(sendMessage);
				return;
			}
			if(sendMessage.substr(0,3) != "jy_")
			{
				var time:int = getTimer() - lastSendTime;
				if (time < ChatConstant.TIME_SEND[msgType])
				{
					writeMsg(type,"<font color='#ffff00'>您说话太快了，</font>"+int((ChatConstant.TIME_SEND[type] - (getTimer() - lastSendTime))/1000+1)+"<font color='#ffff00'>秒后才能发言。</font>")
					ChatConstant.chatShowArr.length = 0;
					inputTxt.text = "";
					return;
				}
			}
			if(ChatConstant.chatShowArr.length > 0)
			{
				//ChatClient.getInstance().chat(msgType,"$"+sendMessage+"$",GlobalModel.hero.name,0,ChatConstant.chatShowArr);
			}
			else
			{
				//ChatClient.getInstance().chat(msgType,sendMessage,GlobalModel.hero.name,0,ChatConstant.chatShowArr);
			}
			
			writeMsg(type,sendMessage);
			showLaba(sendMessage);
			
			ChatConstant.chatShowArr = [];
			lastSendTime = getTimer();
			inputTxt.text = "";
			var index:int = historyInputList.indexOf(sendMessage);
			if (index != -1)
			{
				historyInputList.splice(index,1);
			}
			historyInputList.push(sendMessage);
			if (historyInputList.length > HISTORY_NUM_MAX)
			{
				historyInputList.shift();
			}
			currentHistoryIndex = historyInputList.length;
		}
		
		public function setPriInput(name:String):void
		{
			tabs.selection = btnSpeaker;
			tabs.dispatchEvent(new Event(Event.CHANGE));
			priChatName = name; 
			inputTxt.text = priChatName + "：" ;
		}
		
		private function sendPriChat(content:String):void
		{
			if(priChatName == "")
			{
				writeMsg(ChatConstant.CHAT_CHANNEL_PRI,"请选择私聊对象");
				return;
			}
			content = content.substring(priChatName.length + 1);
			//ChatClient.getInstance().chat(ChatConstant.MSG_TYPE_PRIVATE,content,priChatName,0,[]);
			inputTxt.text = priChatName + "：" ;
		}
		
		private function clearPriChat():void
		{
			priChatName = "";
			inputTxt.text = "";
		}
		
		public function writeMsg(channelType:int,msg:String):void
		{
			_msgArray[channelType].push(msg);
			if (_msgArray[channelType].length > TextList.TEXT_NUM_MAX)
			{
				_msgArray[channelType].shift();
			}
			if((type == ChatConstant.CHAT_CHANNEL_ALL && channelType != ChatConstant.CHAT_CHANNEL_PRI && channelType != ChatConstant.CHAT_CHANNEL_WORLD))
			{
				textList.data = _msgArray[ChatConstant.CHAT_CHANNEL_ALL];
			}
			else if(type == channelType)
			{
				textList.data = _msgArray[channelType];
			}
		}
		
		private function onInputFocusIn(e:FocusEvent):void
		{
			if (inputTxt.text == "请输入聊天内容" || inputTxt.text == "喇叭频道需要消耗一个喇叭。")
			{
				inputTxt.text = "";
			}
		}
		
		private function onChatTypeChange(e:Event):void
		{
			for(var i:int = 0; i<channelBtnArr.length; i++)
			{
				channelBtnArr[i].selected = false;
			}
			if(msgType == ChatConstant.MSG_TYPE_PRIVATE)
			{
				clearPriChat();
			}
			var channelType:int;
			switch (tabs.selection.name)
			{
				case "all":
					type = ChatConstant.CHAT_CHANNEL_ALL;
					btnAll.selected = true;
					msgType =ChatConstant.MSG_TYPE_WORLD;
					break;
				case "world":
					type = ChatConstant.CHAT_CHANNEL_WORLD;
					btnWorld.selected = true;
					msgType =ChatConstant.MSG_TYPE_WORLD;
					break;
				case "scene":
					type = ChatConstant.CHAT_CHANNEL_SCENE;
					msgType =ChatConstant.MSG_TYPE_SCENE;
					btnScene.selected = true;
					break;
				case "camp":
					type = ChatConstant.CHAT_CHANNEL_CAMP;
					msgType =ChatConstant.MSG_TYPE_CAMP;
					btnCamp.selected = true;
					break;
				case "guild":
					type = ChatConstant.CHAT_CHANNEL_GUILD;
					msgType =ChatConstant.MSG_TYPE_GUILD;
					btnGuild.selected = true;
					break;
				case "team":
					type = ChatConstant.CHAT_CHANNEL_TEAM;
					msgType =ChatConstant.MSG_TYPE_TEAM;
					btnTeam.selected = true;
					break;
				case "speaker":
					type = ChatConstant.CHAT_CHANNEL_PRI;
					msgType =ChatConstant.MSG_TYPE_PRIVATE;
					btnSpeaker.selected = true;
					break;
			}
			channelType = msgType;
			btnChannel.label.text = ChatConstant.CHAT_ALL_CHANNEL[channelType];
			textList.data = _msgArray[type];
		}
		
		private function onKey(e:KeyboardEvent):void
		{
			if ((e.keyCode != KEY_UP && e.keyCode != KEY_DOWN) || !historyInputList.length)
				return;
			
			switch (e.keyCode)
			{
				case KEY_UP:
					currentHistoryIndex--
					if (currentHistoryIndex < 0)
						currentHistoryIndex = 0;
					break;
				case KEY_DOWN:
					currentHistoryIndex++
					if (currentHistoryIndex > historyInputList.length - 1)
						currentHistoryIndex = historyInputList.length - 1;
					break;
			}
			inputTxt.text = historyInputList[currentHistoryIndex];
			inputTxt.setSelection(inputTxt.text.length,inputTxt.text.length);
		}
		
		private function onChange(e:Event):void
		{
			if(msgType == ChatConstant.MSG_TYPE_PRIVATE)
			{
				if(priChatName != "")
				{
					var len:int = priChatName.length;
					if(inputTxt.text.length == len)
					{
						clearPriChat();
					}
				}
			}
			if(ChatConstant.chatShowArr.length > 0)//删除输入框中展示物品
			{
				ChatConstant.chatShowArr = [];
				inputTxt.text = "";
			}
		}
		
		public function get input():TextField
		{
			return inputTxt;
		}
		
		public function setInputTxt(str:String):void
		{
			inputTxt.text = str;
		}
		
		public function setFocus():void
		{
			if(GlobalModel.stage.focus == inputTxt)
			{
				if(inputTxt.text == "请输入聊天内容")
				{
					GlobalModel.stage.focus = null;
				}
			}
			else
			{
				GlobalModel.stage.focus = inputTxt;
			}
		}
		
		public override function onResize():void
		{
			if(MainMenuPanel.instance.x <= x + width)
			{
				y = GlobalModel.stage.stageHeight - height + 64 - MainMenuPanel.instance.height;
			}else
			{
				y = GlobalModel.stage.stageHeight - height + 64; //64是喇叭那块
			}
		}
		
		private function onExpressLove(e:MouseEvent):void
		{
			//AcousticConfessionPanel.instance.visible = !AcousticConfessionPanel.instance.visible; 
		}
		
		private function textListChange(e:Event):void{
			msgScroll.target = e.currentTarget as TextList;
		}
	}
}