package game.client.model
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import game.client.manager.SingletonFactory;

	public class GlobalModel
	{
		
		public static const RANK_LIST_UPDATE:String = "RANK_LIST_UPDATE";
		public static var rankUpdateEvent:Event = new Event(RANK_LIST_UPDATE);
		
		public static function getInstance():GlobalModel
		{
			return SingletonFactory.createObject(GlobalModel);
		}

		public static var stage:Stage;
		
		/**
		 *英雄 
		 */		
		public static var hero:Object;
		
	}
}