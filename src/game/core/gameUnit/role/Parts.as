package game.core.gameUnit.role
{
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import game.component.BitmapDataCache;
	import game.core.manager.ResourceManager;
	
	public class Parts extends Sprite
	{
		public static const DEFAULT_EGG:String = "transparent";
		
		public static const SHADOW:int 			= 1;
		public static const HORSE_SIT:int 		= 2;
		public static const HORSE_STAND:int 	= 4;
		public static const HORSE_RIDE:int		= 8
		public static const BODY:int 			= 16;
		public static const WEAPON:int 			= 32;
		public static const WEAPON_EFFECT:int 	= 64;
		public static const WING:int 			= 128;
		public static const WING_EFFECT:int		= 256;
		public static const FIRE:int			= 512;
		
		public static const PART_NAME:Object = {1:"阴影", 2:"坐骑_坐", 4:"坐骑_站", 8:"坐骑_骑", 16:"身体", 32:"武器", 64:"武器特效", 128:"翅膀", 256:"翅膀特效", 512:"攻击"};
		public static const PART_PRIORITY:Object = {1:0, 2:14, 4:14, 8:14, 16:15, 32:5,128:5, 256:4, 512:4}; 
		public static const PART_MAX_BIT:int = 512;
		
		private var list:Vector.<Part> = new Vector.<Part>();
		
		private var _action:Action;
		private var _way:int;
		private var beginTime:int;
		private var rate:Number;
		private var displayData:Object;
		private var isWeaponDown:Boolean;
				
		public var body:Part;
		public var weapon:Part;
		public var weaponEffect:Part;
		public var wing:Part;
		public var wingEffect:Part;
		public var fire:Part;
		
		private var _horseStand:Part;
		private var _horseSit:Part;
		private var _horseRide:Part;
		
		private var _roleContainer:Role;
		private var _preloadLink:String; 
		
		private var _preload:BitmapData;
		private var _veritcalOffset:int;
		
		public var a:Number, b:Number;
		
		private var _actionTotalTime:Object = {};
		
		public function Parts(parts:int, container:DisplayObjectContainer)
		{
			for (var i:int = 1; i <= PART_MAX_BIT; i += i)
			{
				var bit:int = parts & i;
				if (bit > 0)
				{
					list.push(addChild(new Part(bit, PART_NAME[bit], PART_PRIORITY[bit])));
				}
			}
			body = getPart(BODY) as Part;
			weapon = getPart(WEAPON) as Part;
			wing = getPart(WING) as Part;
			wingEffect = getPart(WING_EFFECT) as Part;
			fire = getPart(FIRE) as Part;
			weaponEffect = getPart(WEAPON_EFFECT) as Part;
			
			_horseStand = getPart(HORSE_STAND) as Part;
			_horseSit = getPart(HORSE_SIT) as Part;
			_horseRide = getPart(HORSE_RIDE) as Part;
			
			_roleContainer = container as Role;
		}
		
		/**
		 * 设置代图 
		 * @param value
		 * 
		 */		
		public function set preloadLink(value:String):void
		{
			_preloadLink = value;
		}
		
		public function get preloadLink():String
		{
			return _preloadLink;
		}
		
		public function setPart(type:int, url:String):void
		{
			for each (var part:Part in list)
			{
				if (part.type == type)
				{
					part.url = url;
				}
			}
		}
		
		public function getPart(type:int):Object
		{
			for each (var part:Part in list)
			{
				if (part.type == type)
					return part;
			}
			return null;
		}
		
		private function getActionTotalTime(actionName:String):int
		{
			if(_actionTotalTime[actionName])
			{
				return _actionTotalTime[actionName];
			}
			var totalTimeObj:Object = ResourceManager.getConfig(body.url, actionName, "totalTime");
			if(totalTimeObj != null)
			{
				_actionTotalTime[actionName] = int(totalTimeObj);
				return int(totalTimeObj);
			}
			return action.totalTime;
		}
		
		public function update(now:int):void
		{
			var totalTime:int = getActionTotalTime(action.name);
			var speedPercent:Number = 1;
			if(_roleContainer != null)
			{
				speedPercent = _roleContainer.speedPercent;
			}
			if (action == Action.RUN)
			{
				totalTime = 72000/_roleContainer.nowSpeed
			}
			if(action == Action.JUMP)
			{
				beginTime = _roleContainer.runBeginTime;
				totalTime = _roleContainer.runTotalTime;
			}
			totalTime = totalTime/speedPercent;
			var elapsedTime:int = now - beginTime;
			if (elapsedTime >= totalTime)
			{
				var actionChanged:Boolean = false;
				if (action == Action.ATTACK1 || action == Action.ATTACK2 || action == Action.ATTACK3)
				{
					action = Action.READY;
					actionChanged = true;
				}
				else if (action == Action.DOWN || action == Action.UNDER_ATTACK || action == Action.SHOCK)
				{
					action = Action.STAND;
					actionChanged = true;
				}
				else if (action == Action.JUMP)
				{
					action = Action.DOWN;
					totalTime = 0;
					actionChanged = true;
				}
				else if (action == Action.SINGFIRE)
				{
					action = Action.STAND;
					actionChanged = true;
				}
				else
				{
					beginTime = now;
				}
				if(actionChanged == true && _roleContainer != null)
				{
					_roleContainer.action = action;
				}
			}
			rate = (now - beginTime) / totalTime;
			if (rate < 0 || isNaN(rate))
			{
				rate = 0;
			}
			for each (var part:Part in list)
			{
				part.visible = (part.isHide == false && part.url) ? true : false;
				if (part.visible == false)
				{
					continue;
				}
				displayData = updatePartDisplayData(part, rate);
				if (displayData == null)
				{
					if(part.type == BODY)
					{
						if(_preloadLink != null)
						{
							_preload = BitmapDataCache.getBitmapData(_preloadLink);	
						}
						if(_preload == null)
						{
							_preload = BitmapDataCache.getBitmapData(DEFAULT_EGG);
						}
						if(_preload != null)
						{
							body.bitmapData = _preload;
							body.x = -(_preload.width >> 1);
							body.y = -_preload.height;
						}
					}
					else
					{
						part.bitmapData = null;
					}
					continue;
				}
				
				if (body!= null && weapon != null)
				{
					var temp:int = Part.layer[displayData.index];
					var weaponIndex:int;
					if (temp == 0 && isWeaponDown)
					{
						swapChildren(body, weapon);
						isWeaponDown = false;
					}
					else if (temp == 1 && isWeaponDown == false)
					{
						swapChildren(body, weapon);
						isWeaponDown = true;
					}
				}
				if (part.bitmapData != displayData.bitmapData)
				{
					part.bitmapData = displayData.bitmapData;
				}
				if(part.x != displayData.x || part.y != displayData.y){
					part.x = displayData.x;
					part.y = displayData.y;
				}
				updatePartVerticalHeight(part);
				if (action == Action.JUMP && part.type != SHADOW)
				{
					part.y = displayData.y - (a * (rate - 0.5) * (rate - 0.5) + b);
				}
				if(part.type == BODY && (action == Action.ATTACK1 || action == Action.ATTACK2  || action == Action.ATTACK3) && rate > 0.9)
				{
					_roleContainer.triggerKeyframes();
				}
			}
		}
		
		/**
		 * 垂直高度偏移 
		 * @param part
		 * 
		 */		
		private function updatePartVerticalHeight(part:Part):void
		{
			if((_horseStand != null && _horseStand.isHide == false) || (_horseSit != null && _horseSit.isHide == false) || (_horseRide != null && _horseRide.isHide == false)){
				if (part.type == BODY || part.type == WEAPON || part.type == WING || part.type == WING_EFFECT)
				{
					part.y = displayData.y - _veritcalOffset;
				}
			}
		}
		
		public function set verticalOffset(value:int):void
		{
			_veritcalOffset = value;
		}
		
		public function get verticalOffset():int
		{
			return _veritcalOffset;
		}
		
		private function updatePartDisplayData(part:Part, rate:Number):Object
		{
			if(_horseStand != null && _horseStand.isHide == false)
			{
				switch(part.type)
				{
					case BODY:
						return ResourceManager.getResource(body.url, Action.STAND.name, way < 5 ? way : 8 - way, rate, body.priority);
					case WEAPON:
						return ResourceManager.getResource(weapon.url, Action.STAND.name, way < 5 ? way : 8 - way, rate, weapon.priority);
					case WING:
						return ResourceManager.getResource(wing.url, Action.STAND.name, way < 5 ? way : 8 - way, rate, wing.priority);
					case WING_EFFECT:
						return ResourceManager.getResource(wingEffect.url, Action.STAND.name, way < 5 ? way : 8 - way, rate, wingEffect.priority);
					default:
						return ResourceManager.getResource(part.url, action.name, way < 5 ? way : 8 - way, rate, part.priority);
				}
			}
			else if(_horseSit != null && _horseSit.isHide == false)
			{
				switch(part.type)
				{
					case BODY:
						return ResourceManager.getResource(body.url, Action.SIT.name, way < 5 ? way : 8 - way, rate, body.priority);
					case WING:
						return ResourceManager.getResource(wing.url, Action.SIT.name, way < 5 ? way : 8 - way, rate, wing.priority);
					case WING_EFFECT:
						return ResourceManager.getResource(wingEffect.url, Action.SIT.name, way < 5 ? way : 8 - way, rate, wingEffect.priority);
					default:
						return ResourceManager.getResource(part.url, action.name, way < 5 ? way : 8 - way, rate, part.priority);
				}
			}
			else if(_horseRide != null && _horseRide.isHide == false)
			{
				switch(part.type)
				{
					case BODY:
						return ResourceManager.getResource(body.url, "ride" + action.name, way < 5 ? way : 8 - way, rate, body.priority);
					case WING:
						return ResourceManager.getResource(wing.url, "ride" + action.name, way < 5 ? way : 8 - way, rate, wing.priority);
					case WING_EFFECT:
						return ResourceManager.getResource(wingEffect.url, "ride" + action.name, way < 5 ? way : 8 - way, rate, wingEffect.priority);
					default:
						return ResourceManager.getResource(part.url, action.name, way < 5 ? way : 8 - way, rate, part.priority);
				}
			}
			return ResourceManager.getResource(part.url, action.name, way < 5 ? way : 8 - way, rate, part.priority);
		}
		
		public function set action(value:Action):void
		{
			if (_action == value)
			{				
				return;
			}
			_action = value;
			beginTime = getTimer();
		}
		
		public function get action():Action
		{
			return _action;
		}
		
		public function set way(value:int):void
		{
			_way = value;
			scaleX = value < 5 ? 1 : -1;
		}
		
		public function get way():int
		{
			return _way;
		}
		
		public function dispose():void
		{
			for each (var part:Part in list)
			{
				part.dispose();
			}
			this.preloadLink = null;
			this.filters = null;
			this._actionTotalTime = {};
		}
	}
}
