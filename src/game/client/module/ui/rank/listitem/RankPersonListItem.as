package game.client.module.ui.rank.listitem
{
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import game.client.module.ui.rank.data.RankDataVo;
	import game.component.Image;
	import game.component.Label;
	import game.component.ListItemBase;
	
	public class RankPersonListItem extends ListItemBase
	{
		public static var personMemberItemPool:Vector.<RankPersonListItem> = new Vector.<RankPersonListItem>();
		public static function getInstance():RankPersonListItem
		{
			return personMemberItemPool.length ? personMemberItemPool.shift() : new RankPersonListItem();
		}
		
		private var _selectBg:Image;
		private var _zhanli:Label;
		private var _camp:Label;
		private var _club:Label;
		private var _career:Label;
		private var _sex:Label;
		private var _name:Label;
		private var _rank:Label;
		private var _timeout:int;
		private var _listItem:RankPersonListItem;
		public function RankPersonListItem()
		{
			super();
		}
		
		public override function set skin(value:Object):void
		{
			super.skin = value;
			init();
		}
		
		private function init():void
		{
			_listItem = this;
			_selectBg = this.getChildByName("xuanzhongxx21") as Image;
			addEventListener(MouseEvent.CLICK, onClickHandler);
			_zhanli = this.getChildByName("txtzhandouliss") as Label;
			_zhanli.width = 100;
			_camp = this.getChildByName("txttianjige") as Label;
			_club = this.getChildByName("txtbangpmaa") as Label;
			_career = this.getChildByName("txtwusheng1") as Label;
			_sex = this.getChildByName("txtnan1") as Label;
			_name = this.getChildByName("txtmingzi11") as Label;
			_rank = this.getChildByName("txtpaim11") as Label;
			selected = false;
		}
		
		public override function set data(value:Object):void
		{
			_data = value;
			_rank.text = RankDataVo(_data).rank.toString();
			_name.text = RankDataVo(_data).name;
			_sex.text = RankDataVo(_data).sexName;
			_career.text = getCareerName(RankDataVo(_data).job);
			_club.text = RankDataVo(_data).guild_name;
			_camp.text = RankDataVo(_data).camp.toString();
			_zhanli.text = RankDataVo(_data).person_value.toString();
		}
		
		public function getCareerName(job:int):String
		{
			switch(job)
			{
				case 1:
					return "武灵";
				case 2:
					return "法尊";
				case 3:
					return "修罗";
			}
			return "无";
		}
		
		
		public override function set selected(value:Boolean):void
		{
			_selected = value;
			_selectBg.visible = value;
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			if(_timeout != 0) clearTimeout(_timeout);
			_timeout = setTimeout(function ():void{
				//RankPersonalMenu.intance.show(_listItem);
				_timeout = 0;
			},200);
		}
		
		public override function get data():Object
		{
			return _data;
		}
	}
}