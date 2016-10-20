package game.client.module.ui.rank
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	import game.client.module.BasePanel;
	import game.client.module.ui.rank.data.RankType;
	import game.client.module.ui.rank.list.RankCategoryListItem;
	import game.client.module.ui.rank.list.RankSubclassesListItem;
	import game.client.module.ui.rank.skin.RankPanelSkin;
	import game.component.Button;
	import game.component.Label;
	import game.component.List;
	import game.component.RadioButton;
	import game.component.RadioButtonGroup;
	import game.component.ScrollBar;
	
	public class RankPanel extends BasePanel
	{
		public static var instance:RankPanel = new RankPanel();
		
		private var _isInit:Boolean = false;
		private var _tabs:RadioButtonGroup;
		private var _careerTabs:RadioButtonGroup;
		private var _sexTabs:RadioButtonGroup;
		private var _rankListItems:Array;
		private var _subListItems:Array;
		private var _tabNames:Array = ["qianghua","zhuanbeixilian"];
		private var _careerNames:Array = ["shushi","xiaoyao","wusheng","suoyou"];
		private var _sexNames:Array = ["suoyou","nv","nan"];
		private var _rankList:List;
		private var _rankSubList:List;
		private var _listScroll:ScrollBar;
		
		private var _lastType:int;
		private var _lastSubtype:int;
		private var _listSprite:Sprite;
		private var _subHeight:int;
		private var _pageTxt:Label;
		private var _currPage:int;
		private var _currTotal:int;
		private var _career:int;
		private var _sex:int;
		public function RankPanel()
		{
			this.closeeffect=true;
			this.skin = RankPanelSkin.skin;
			_listSprite = new Sprite();
			this.addChild(_listSprite);
			_rankListItems = [];
			_subListItems = [];
			initView();
		}
		
		private function initView():void
		{
			_tabs = this.getChildByName("tabs") as RadioButtonGroup;
			for each(var tab:String in _tabNames)
			{
				RadioButton(_tabs.getChildByName(tab)).addEventListener(MouseEvent.CLICK, tabClickHandler);
			}
			_careerTabs = this.getChildByName("zhiye") as RadioButtonGroup;
			for each(tab in _careerNames)
			{
				RadioButton(_careerTabs.getChildByName(tab)).addEventListener(MouseEvent.CLICK, careerClickHandler);
			}
			_sexTabs = this.getChildByName("xingbie") as RadioButtonGroup;
			for each(tab in _sexNames)
			{
				RadioButton(_sexTabs.getChildByName(tab)).addEventListener(MouseEvent.CLICK, sexClickHandler);
			}
			_listScroll = this.getChildByName("msgScroll") as ScrollBar;
			_rankList = this.getChildByName("dalei") as List;
			_rankList.columnCount = 1;		//横向数量
			_rankList.verticalGap = 1;		//垂直间距
			_rankSubList = this.getChildByName("xiaolei") as List;
			_rankSubList.columnCount = 1;
			_listSprite.y = _rankList.y;
			Button(this.getChildByName("xiangyou")).addEventListener(MouseEvent.CLICK, rigthtClickHandler);	//分页向右
			Button(this.getChildByName("xiangzuo")).addEventListener(MouseEvent.CLICK, leftClickHandler);		//分页向左
			_pageTxt = this.getChildByName("txtPage") as Label;
			_pageTxt.x -= 5;
			_pageTxt.width = 60;
			_pageTxt.align = TextFormatAlign.LEFT;
			Button(this.getChildByName("wodepaih")).addEventListener(MouseEvent.CLICK, mineRankClickHandler);		//我的排行榜
			Button(this.getChildByName("suozyou")).addEventListener(MouseEvent.CLICK, famousClickHandler);			//名人堂
			showRank();
		}
		
		private function showRank():void
		{
			for each(var type:String in RankType.RANK_MAIN_TYPES)
			{
				var index:int = RankType.RANK_MAIN_TYPES.indexOf(type);
				var categoryItem:RankCategoryListItem = RankCategoryListItem.getInstance();
				_rankList.addChild(categoryItem);
				_rankListItems.push(categoryItem);
				categoryItem.data = {name:type,type:index};
				categoryItem.addEventListener(RankCategoryListItem.LISTITEM_CLICK, onCategoryClickHandler);
			}
			_rankList.configSkin();
			_rankListItems[0].selected = true;
			showSubList(0);
		}
		public function showTargetRank(target:String = "等级排行"):void
		{
			acceptMainMenuClick(null);
			var arr:Array = RankType.findBtn(target);
			var list:int = arr[0];
			var subList:int = arr[1];
			RankCategoryListItem(_rankListItems[list]).isSelected = true;
			RankCategoryListItem(_rankListItems[list]).onClickHandler();
			_subListItems[subList].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function onCategoryClickHandler(e:Event):void
		{
			var listItem:RankCategoryListItem = e.currentTarget as RankCategoryListItem;
			var type:int = listItem.data.type;
			if(type != _lastType)
				_rankListItems[_lastType].isSelected = false;
			if(listItem.isSelected == true)
			{
				showSubList(type);
			}
			else
			{
				_subListItems.length = 0;
				_rankSubList.removeAllItem();
				//_rankList.setInterval(0,0);
			}
		}
		
		private function showSubList(type:int):void
		{
			_lastType = type;
			_subListItems.length = 0;
			_rankSubList.removeAllItem();
			var list:Array = RankType.RANK_SUB_TYPES[type];
			for each(var subtype:String in list)
			{
				var index:int = list.indexOf(subtype);
				var subItem:RankSubclassesListItem = RankSubclassesListItem.getInstance();
				_rankSubList.addChild(subItem);
				_subListItems.push(subItem);
				subItem.data = {name:subtype,type:index};
				subItem.addEventListener(RankSubclassesListItem.RANK_SUB_CLICK, onSubitemClickHandler);
			}
			_rankSubList.configSkin();
			//_rankList.setInterval(type, _rankSubList.height+4);
			if(_rankList.height > 340)
			{
				_listScroll.visible = true;
				_listSprite.addChild(_rankList);
				_rankList.y = 0;
				_listSprite.addChild(_rankSubList);
				_rankSubList.y = 27;
				_listScroll.target = _listSprite;
				_subHeight = 27;
			}
			else
			{
				_listScroll.target = _listSprite;
				_listScroll.visible = false;
				this.addChild(_rankList);
				_rankList.y = 132;
				this.addChild(_rankSubList);
				_rankSubList.y = 159;
				_subHeight = 159;
			}
			_rankSubList.y = _subHeight + type*25;
			_subListItems[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function onSubitemClickHandler(e:Event):void
		{
			var subitem:RankSubclassesListItem = e.currentTarget as RankSubclassesListItem;
			var subType:int = subitem.data.type;
			//BoardClient.getInstance().boardQuery(1000*(_lastType+1)+(subType+1),0,0);
			clearRankList();
			RankType.RANK_INSTANCE_LIST[_lastType].visible = true;
			RankType.RANK_INSTANCE_LIST[_lastType].updateSubtype(subType);
		}
		
		private function clearRankList():void
		{
			for each(var obj:* in RankType.RANK_INSTANCE_LIST)
			{
				obj.visible = false;
			}
		}
		
		private function tabClickHandler(e:MouseEvent):void
		{
			var tab:String = e.currentTarget.name;
			switch(tab)
			{
				case "qianghua":
					break;
				case "zhuanbeixilian":
					break;
			}
		}
		
		private function careerClickHandler(e:MouseEvent):void
		{
			switch(_careerTabs.selectionName)
			{
				case "suoyou":	//所有
					_career = 0;
					break;
				case "shushi":	//修罗
					_career = 3;
					break;
				case "xiaoyao"://法尊
					_career = 2;
					break;
				case "wusheng"://武灵
					_career = 1;
					break;
			}
			showPage(1)
		}
		
		private function sexClickHandler(e:MouseEvent):void
		{
			switch(_sexTabs.selectionName)
			{
				case "suoyou":	//所有
					_sex = 0;
					break;
				case "nv":	//女
					_sex = 2;
					break;
				case "nan"://男
					_sex = 1;
					break;
			}
			showPage(1);
		}
		
		private function rigthtClickHandler(e:MouseEvent):void
		{
			if(_currPage < _currTotal)
			{
				_currPage ++;
				showPage(_currPage);
			}
		}
		
		private function leftClickHandler(e:MouseEvent):void
		{
			if(_currPage > 1)
			{
				_currPage --;
				showPage(_currPage);
			}
		}
		
		private function mineRankClickHandler(e:MouseEvent):void
		{
			//BoardClient.getInstance().myBoard(0);
			clearRankList();
			var index:int = RankType.RANK_INSTANCE_LIST.length;
			RankType.RANK_INSTANCE_LIST[index-1].visible = true;
		}
		
		private function famousClickHandler(e:MouseEvent):void
		{
			//FamousPanel.getInstance().acceptClickButton();
		}
		
		private function showPage(page:int):void
		{
			RankType.RANK_INSTANCE_LIST[_lastType].updateDatas(page, _career, _sex);
		}
		
		public function setPage(page:int, total:int):void
		{
			_currPage = page;
			_currTotal = total>0?total:1;
			_pageTxt.text = _currPage+"/"+_currTotal;
		}
		
		public function get career():int
		{
			return _career;
		}
		
		public function get sex():int
		{
			return _sex;
		}
		
		public function acceptMainMenuClick(e:MouseEvent):void
		{
			this.visible = !this.visible;
			if(_isInit == false && this.visible == true)
			{
				_isInit = true;
			}
		}
	}
}