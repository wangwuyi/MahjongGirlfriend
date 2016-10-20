package game.client.module.ui.skill
{
	import flash.events.Event;
	
	import game.client.module.page.CommonPage;
	import game.client.module.ui.skill.listitem.SkillListItem;
	import game.component.List;

	public class SkillListContainer
	{
		private var _list:List;
		private var _type:int;
		private var _page:CommonPage;
		private var _selectSkillFun:Function;
		private const PAGE_SIZE:int=6;
		
		public function SkillListContainer(list:List, page:CommonPage, selectSkillFun:Function)
		{
			_list=list;
			_page=page;
			_page.pageFn=setData;
			_page.pageSize=PAGE_SIZE;
			_selectSkillFun=selectSkillFun;
			init();
		}
		
		private function init():void{
			_list.verticalGap=10;
			_list.horizontalGap=30;
			_list.rowCount=3;
			_list.columnCount=2;
			_list.addEventListener(Event.CHANGE,onChange);
		}
		
		private function setData(ary:Array):void{
			_list.removeAllItem();
			for (var i:int = 0; i < ary.length; i++) 
			{
				var item:SkillListItem=SkillListItem.getInstance();
				_list.addChild(item);
				item.data=ary[i];
			}
			
			selectSkill(ary[0]);
		}
		
		private function onChange(e:Event):void
		{
			selectSkill(_list.selection.data);
		}
		
		private function selectSkill(skillVO:Object):void
		{
			_selectSkillFun(skillVO);
		}
		
		public function setSkill(type:int):void
		{
			_type = type;
			var arr:Array = [1,2,3,4,5,6];
			_page.pageData = arr;
		}
	}
}