package game.client.module.ui.friend
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.client.facade.SceneFacade;
	import game.client.manager.DispatchManager;
	import game.client.model.GlobalModel;
	import game.client.module.BasePanel;
	import game.client.module.page.CommonPage;
	import game.client.module.tip.TipManager;
	import game.client.module.ui.broadcast.Alert;
	import game.client.module.ui.broadcast.BroadcastMarquee;
	import game.client.module.ui.friend.container.FriendListContainer;
	import game.client.module.ui.friend.skin.FriendPanelSkin;
	import game.client.module.ui.rank.RankPanel;
	import game.client.module.ui.skill.SkillPanel;
	import game.client.module.ui.systemtip.SystemTip;
	import game.client.net.handler.user.HeroVO;
	import game.client.utils.ColorWord;
	import game.component.Button;
	import game.component.Component;
	import game.component.Label;
	import game.component.List;
	import game.component.RadioButtonGroup;
	import game.core.gameUnit.magic.Effect;
	import game.core.gameUnit.role.Action;
	import game.core.gameUnit.role.HitNumber;

	public class FriendPanel extends BasePanel
	{
		public static var instance:FriendPanel = new FriendPanel();
		
		private var _label:Label;
		private var _labelMask:Component;
		private var _guanbi:Button;
		private var _onRide:Button;
		private var _haoyou:Button;
		private var _tuijian:Button;
		private var _tabs:RadioButtonGroup;
		
		private var _friendList:FriendListContainer;
		
		public function FriendPanel()
		{
			this.closeeffect=true;
			this.skin = FriendPanelSkin.skin;
			init();
		}
		
		private function init():void{
			_label = getChildByName("wanjiamingzi") as Label;
			_label.mouseEnabled = true;
			_label.htmlText = "师傅:<a href='type|id' style='cursor:default'><u>100</u></a>元。";
			_labelMask = _label.setMaskRect("师傅");
			_labelMask.guideKey = "wanjiamingzi";
			TipManager.bind(null,_label);
			_label.addEventListener(MouseEvent.MOUSE_MOVE, checking);
			
			_guanbi=getChildByName("guanbi") as Button;
			_guanbi.addEventListener(MouseEvent.CLICK,close);
			_onRide=getChildByName("shousuohaoyou") as Button;
			_onRide.addEventListener(MouseEvent.CLICK,onRide);
			_haoyou=getChildByName("tianjaihaoyou") as Button;
			_haoyou.addEventListener(MouseEvent.CLICK,addEffect);
			TipManager.bind("好友",_haoyou);
			_tuijian=getChildByName("haoyoutuijian") as Button;
			_tuijian.addEventListener(MouseEvent.CLICK,addEffectTwo);
			
			_tabs = getChildByName("haoyou")as RadioButtonGroup;
			_tabs.getChildByName("haoyou").addEventListener(MouseEvent.CLICK, DispatchManager.create(onChangePage,1));
			(_tabs.getChildByName("haoyou") as Component).guideKey="haoyou";
			_tabs.getChildByName("heimingdan").addEventListener(MouseEvent.CLICK, DispatchManager.create(onChangePage,2));
			(_tabs.getChildByName("heimingdan") as Component).guideKey="heimingdan";
			_tabs.getChildByName("zuijin").addEventListener(MouseEvent.CLICK, DispatchManager.create(onChangePage,3));
			(_tabs.getChildByName("zuijin") as Component).guideKey="zuijin";
			_tabs.getChildByName("fenshen").addEventListener(MouseEvent.CLICK, DispatchManager.create(onChangePage,4));
			(_tabs.getChildByName("fenshen") as Component).guideKey="fenshen";
			
			var commPage:CommonPage = new CommonPage;
			commPage.config(null, null, null, null, null);
			_friendList=new FriendListContainer(getChildByName("haoyouliebiao") as List, commPage);
			_friendList.setFriend(0);
		}
		
		private function checking(event:MouseEvent) : void {
			var tip : String = _label.getTextFormat(_label.getCharIndexAtPoint(_label.mouseX, _label.mouseY)).url;
			if (tip != null && tip != "") {
				TipManager.showUpdateDataTip(event.target,tip);
			}else{
				TipManager.hide();
			}
		}
		
		private function addEffect(e:Event):void{
			GlobalModel.hero.addEffect(1,500,Effect.POS_UP,false,0,-50);
			SkillPanel.instance.visible=!SkillPanel.instance.visible;
		}
		private function addEffectTwo(e:Event):void{
			GlobalModel.hero.addEffect(2,500,Effect.POS_UP,false,0,-50);
			GlobalModel.hero.action=Action.SIT;
		}
		
		private function onRide(e:Event):void{
			var roleNum:HitNumber = HitNumber.instance;
			roleNum.name = "hit_" + GlobalModel.hero.name;
			roleNum.init(false, 0, 123, 0, true);
			GlobalModel.hero.addChild(roleNum);
			roleNum.start();
		}
		
		private var msgN:int;
		private function close(e:Event):void{
			msgN++;
			SystemTip.addMsg("下马了。"+msgN);
			this.visible = false;
		}
		
		private function onChangePage(e:Event,value:int):void{
			if(value==1){
				
			}else if(value==2){
				Alert.show("哈哈哈");
			}else if(value==3){
				BroadcastMarquee.show("广告：娃哈哈。");
//				RankPanel.instance.visible=!RankPanel.instance.visible;
			}else if(value==4){
				msgN++;
				SystemTip.addMsg("下马啊哈阿富汗人大阿德个挖掘分给国际快递公司。"+msgN);
				ColorWord.show("共10波怪，当前第?波","#FFFFFF",30,ColorWord.BOTTOM,9990000);
			}
		}
		
		public override function set visible(value:Boolean):void
		{
			super.visible = value;
		}
		
		public override function onResize():void
		{
			this.x = GlobalModel.stage.stageWidth - this.width - 90;
			this.y = (GlobalModel.stage.stageHeight - this.height) >> 1;
		}
		
	}
}