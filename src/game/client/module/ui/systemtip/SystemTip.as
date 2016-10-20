package game.client.module.ui.systemtip
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import game.client.manager.SingletonFactory;
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.ui.systemtip.skin.SystemTipSkin;
	import game.client.utils.FilterUtil;
	import game.component.Button;
	import game.component.Label;
	
	public class SystemTip extends BasePanel
	{
		public static const MAX_MESSAGE_LENGTH:int = 10;
		
		private static var _messageList:Array = [];
		
		private var _systemTipPanelBtn:Button;
		private var _contentTxt:Label;
		private var _mask:Shape;
		
		public static function instance():SystemTip
		{
			return SingletonFactory.createObject(SystemTip);
		}
		
		public function SystemTip()
		{
			this.skin = SystemTipSkin.skin;
			initPanelElement();
			addElementEventListener();
		}
		
		private function initPanelElement():void
		{
			_systemTipPanelBtn = getChildByName("jiahao") as Button;
			
			_contentTxt = getChildByName("txtContent") as Label;
			_contentTxt.text = "";
			_contentTxt.width = 191;
			_contentTxt.height = 80;
			_contentTxt.multiline = true;
			_contentTxt.wordWrap = true;
			_contentTxt.filters = FilterUtil.blackFilter;
			this.mouseEnabled = false;
		}
		
		private function initMask():void
		{
			
		}
		
		private function addElementEventListener():void
		{
			_systemTipPanelBtn.addEventListener(MouseEvent.CLICK, onSystemTipPanel);
		}
		
		private function onSystemTipPanel(evt:MouseEvent):void
		{
			//SystemTipPanel.instance().visible = !SystemTipPanel.instance().visible;
		}
		
		public function clearContent():void
		{
			_contentTxt.htmlText = "";
			_messageList.length = 0;
		}
		
		public static function addMsg(strMsg:String,strColor:String="#D0D0D0"):void
		{
			if(strMsg=="")
			{
				return;
			}
			instance().addMsg(strMsg,strColor);
			//SystemTipPanel.addMsg(strMsg, strColor);
		}
		
		private function addMsg(strMsg:String,strColor:String):void
		{
			if (_messageList.length >= MAX_MESSAGE_LENGTH)
			{
				_messageList.shift().dispose();
			}
			var info:Message = Message.instance();
			info.contentStr = strMsg;
			info.color = strColor;
			_messageList.push(info);
			var strContent:String = "";
			var len:int = _messageList.length;
			var strHtml:String
			for (var i:int = 0; i < len; i++)
			{
				var message:Message = _messageList[i] as Message;
				strHtml = "<font color = '" + message.color + "'> " + message.contentStr + "</font>"
				strContent += strHtml + "\n"
			}
			_contentTxt.htmlText = strContent;
			_contentTxt.scrollV = _contentTxt.maxScrollV;
		}
		
		public override function onResize():void
		{
			this.x = GlobalModel.stage.stageWidth - this.width;
			this.y = GlobalModel.stage.stageHeight - this.height - 125;
		}
	}
	
}