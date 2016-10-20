package game.core.gameUnit.role
{
	
	public class Action {
		
		public static const STAND:Action 		= new Action("stand", 1000);
		public static const RUN:Action 			= new Action("run", 100);
		public static const READY:Action 		= new Action("ready", 600);
		public static const ATTACK1:Action 		= new Action("attack1", 700);
		public static const ATTACK2:Action 		= new Action("attack2", 700);
		public static const ATTACK3:Action 		= new Action("attack3", 700);
		public static const SIT:Action 			= new Action("sit", 1000);
		public static const JUMP:Action 		= new Action("jump", 0);
		public static const DOWN:Action 		= new Action("down", 300);
		public static const HITBACK:Action 		= new Action("stand", 0);
		public static const DIE:Action 			= new Action("die", 0);
		public static const YOGA:Action			= new Action("yoga", 0);
		public static const RIDE_RUN:Action		= new Action("riderun", 0);
		public static const RIDE_STAND:Action	= new Action("ridestand", 0);
		public static const UNDER_ATTACK:Action	= new Action("underattack", 300);
		public static const CAST:Action			= new Action("cast", 600);
		public static const SINGFIRE:Action		= new Action("singfire", 600);
		public static const SINGLOOP:Action		= new Action("singloop", 600);
		public static const SHOCK:Action		= new Action("shock", 700);
		
		public var name:String;
		public var totalTime:int;
		
		public function Action(_name:String, _time:int) {
			name = _name;
			totalTime = _time;
		}
		
		public function toString():String{
			return name;
		}
	}
}