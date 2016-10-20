package game.core.events
{
	import flash.events.Event;

	/**
	 * 带参数的事件
	 * @author wwy
	 */	
	public class SimpleEvent extends Event
	{
		public var data:*;
		
		public function SimpleEvent(type:String, value:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			data=value;
			super(type,bubbles,cancelable);
		}
	}
}