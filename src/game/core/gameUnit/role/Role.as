package game.core.gameUnit.role
{
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import game.core.gameUnit.GameUnit;
	import game.core.gameUnit.magic.Effect;
	import game.core.manager.ResourceManager;
	import game.core.utils.Utils;
	
	public class Role extends GameUnit
	{
		public static const DEAD:int = 0;
		public static const LIFE:int = 1;
		
		public static const HUMAN_STATUS_NORMAL:int 	= 1;
		public static const HUMAN_STATUS_SIT:int 		= 2;
		public static const HUMAN_STATUS_HORSE:int 		= 3;
		public static const HUMAN_STATUS_COLLECT:int 	= 4;
		public static const HUMAN_STATUS_SING:int 		= 7;
		
		public static const COLOR_WHITE:int 			= 1;
		public static const COLOR_GREEN:int 			= 2;
		public static const COLOR_BLUE:int				= 3;
		public static const COLOR_PURPLE:int			= 4;
		public static const COLOR_ORANGE:int			= 5;
		public static const COLOR_RED:int 				= 6;
		
		public static const JUMP_SPEED_SCALE:int 		= 3;
		private static const HIT_TIME_EFFECT:int = 180
		
		private var _hp:int;
		private var _mp:int;
		private var _hpMax:int;
		private var _mpMax:int;
		private var _head:int;
		
		private var _level:int;
		public var speed:int;
		public var parts:Parts;
		public var nameBar:NameBar;
		private var _nameBarLastY:int;
		public var buffStartTime:int = 0;
		private var _buffList:Array = new Array();
		
		public var nowSpeed:int;
		private var distance:int;
		private var realSpeed:int;
		private var start_x:int, start_y:int;
		private var end_x:int, end_y:int;
		private var dx:int, dy:int;
		private var lastTime:int;
		private var allTime:int;
		private var _route:Array;
		
		public var alphaNum:Number = 1;
		public var isHitBack:Boolean;
		
		private var tick:int = 0;
		/** 击中效果 */
		private var _hitTime:uint;
		private var _isHitBackDead:Boolean = false;
		private var _status:int;
		
		protected var _title:String = "";
		protected var _displayName:String = ""; //name用作保存玩家实际的名字，displayName为显示的名字，两者可能不一样
		protected var _nameBarContent:String = ""; //最终会呈现在玩家头上的NameBar中的内容，为displayerName，title，guildName组成的内容
		protected var _effectMap:Dictionary;
		protected var _headIcon:Bitmap;
		
		private var _speedPercent:Number = 1;//速度百分比
		private var _framesHandler:Function;//触发关键帧时调用方法
		private var _isTrigger:Boolean = false;//是否已触发
		
		private var _visible:Boolean = true;
		
		/****锁定移动****/
		private var _isLockMove:Boolean;
		private var _isJumbLockMove:Boolean;
		private var _lockMoveLastTime:int;
		private var _finishLockMoveHandler:Function;
		private var _finisHitHandler:Function;
		
		public function Role(_parts:int)
		{
			parts = new Parts(_parts, this);
			addChild(parts);
			nameBar = addChild(new NameBar()) as NameBar;
			super.state = LIFE;
			action = Action.STAND;
		}
		
		public override function set name(value:String):void
		{
			super.name = value;
			displayName = value;
		}
		
		public function set displayName(value:String):void
		{
			_displayName = value;
		}
		
		public function get displayName():String
		{
			return _displayName;
		}
		
		public function get runBeginTime():int
		{
			return lastTime;
		}
		
		public function get runTotalTime():int
		{
			return allTime;
		}
		
		protected function addUnderfootShadow():void
		{
			
		}
		
		public function showUnderfootShadow():void
		{
			
		}
		
		public function hideUnderfootShadow():void
		{
			
		}
		
		public function addHeadIcon(url:String):void
		{
			if(_headIcon == null)
			{
				_headIcon = new Bitmap();
				addChild(_headIcon);
			}
			ResourceManager.getBitmap(_headIcon, url);
		}
		
		private function updateHeadIconPosition():void
		{
			if(_headIcon != null)
			{
				_headIcon.x = -(_headIcon.width >> 1);
				_headIcon.y = this.nameBar.y - (_headIcon.height >> 1) - 10;
			}
		}
		
		public function removeHeadIcon():void
		{
			if(_headIcon != null && _headIcon.parent)
			{
				_headIcon.parent.removeChild(_headIcon);
				_headIcon = null;
			}
		}
		
		public override function show():void
		{
			updateNameBar();
		}
		
		public function updateNameBar():void
		{
			_nameBarContent = _title + " " + _displayName;
			nameBar.textContent = _nameBarContent;
		}
		
		protected function updateNameBarPosition():void
		{
			if(Math.abs(parts.body.y - _nameBarLastY) > 15)
			{
				nameBar.y = parts.body.y - 5;
				_nameBarLastY = parts.body.y
			}
		}
		
		public override function set state(value:int):void
		{
			if (super.state == value)
			{
				return;
			}
			if (value == LIFE)
			{
				playLifeAction();
			}
			else if (value == DEAD)
			{
				playDieAction();
			}
			super.state = value;
		}
		
		protected function playLifeAction():void
		{
			parts.action = Action.STAND;
			nameBar.visible = true;
			parts.visible = true;
		}
		
		protected function playDieAction():void
		{
			nameBar.visible = false;
			parts.visible = false;
			removeAllEffect();
		}
		
		public function set status(value:int):void
		{
			_status = value;
		}
		
		public function get status():int
		{
			return _status;
		}
		
		/**
		 * 角色心跳 
		 * @param now
		 * 
		 */		
		public override function update(now:int):void
		{
			if (visible == true)
			{
				onHit(now);
				parts.update(now);
				updateNameBarPosition();
				updateHeadIconPosition();
				nameBar.updateHp(hp,hpMax);
			}
			checkLockMove(now);
			move(now);
		}
		
		public override function algin():void
		{
			super.algin();
			alpha *= alphaNum;
		}
		
		public function move(now:int):void
		{
			if (action != Action.JUMP && action != Action.RUN && isHitBack == false)
			{
				return;
			}
			var rate:Number;
			if (isHitBack == true)
			{
				var a:Number = Math.sqrt(2 * distance / (allTime * allTime));
				var v:Number = a * allTime;
				var t:Number = (now - lastTime);
				rate = (v * t - a * t * t / 2) / allTime;
			}
			else
			{
				rate = (now - lastTime) / allTime;
			}
			if (rate > 1)
			{
				x = end_x;
				y = end_y;
				route = _route;
				if (isHitBack == true)
				{
					if(_isHitBackDead == true)
					{
						setTimeout(hitDead, 150);
					}
					if(_finisHitHandler != null)
					{
						_finisHitHandler();
						_finisHitHandler = null;
					}
				}
				isHitBack = false;
			}
			else
			{
				x = Math.round(rate * dx + start_x);
				y = Math.round(rate * dy + start_y);
			}
			algin();
		}
		
		public function set routePath(path:Array):void{
			//让子类实现
			route = path;
		}
		
		public function set route(path:Array):void
		{
			nowSpeed = speed;
			if (path && path.length && processingPath(path.shift()))
			{
				var nway:int = Utils.getWay(end_x, end_y, start_x, start_y);
				way = nway;
				action = Action.RUN;
				_route = path;
			}else if(path.length > 0){
				route = path;
			}else if (action != Action.DIE && action != Action.JUMP)
			{
				action = Action.STAND;
			}
		}
		
		public function get route():Array
		{
			if (_route)
				_route.unshift([end_x, end_y]);
			return _route;
		}
		
		public function set jumpPoint(point:Array):void
		{
			nowSpeed = speed * JUMP_SPEED_SCALE;
			if (point && point.length && processingPath(point))
			{
				var nway:int = Utils.getWay(end_x, end_y, start_x, start_y);
				way = nway;
				action = Action.JUMP;				
				_route = [];
			}
			else if (action != Action.JUMP)
			{
				action = Action.STAND;
			}
		}
		
		private var black:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0])
		public function set hitBack(point:Array):void
		{
			nowSpeed = 40;
			if (processingPath(point))
			{
				action = Action.STAND;
				isHitBack = true;
			}
		}
		
		public function hitBackHandle(point:Array, finisHitHandler:Function = null):void
		{
			nowSpeed = 40;
			if (processingPath(point))
			{
				action = Action.STAND;
				isHitBack = true;
				_finisHitHandler = finisHitHandler;
			}
			else
			{
				if(_finisHitHandler != null)
				{
					_finisHitHandler();
					_finisHitHandler = null;
				}
			}
		}
		
		public function set hitBackAndDead(point:Array):void
		{
			_isHitBackDead = true;
			nowSpeed = 40;
			if (processingPath(point))
			{
				action = Action.STAND;
				isHitBack = true;
			}
			else
			{
				hitDead();
			}
		}
		
		private function hitDead():void
		{
			if(_isHitBackDead == true)
			{
//				GameUnitManager.removeUnit(this);
			}
			_isHitBackDead = false;
		}
		
		private function processingPath(path:Array):Boolean
		{
			if(isLockMove == true)
			{
				return false;
			}
			start_x = x;
			start_y = y;
			end_x = path[0];
			end_y = path[1];
			distance = Math.sqrt((end_y - start_y) * (end_y - start_y) + (end_x - start_x) * (end_x - start_x));
			if (distance < 10)
			{
				return false;
			}
			if (end_x == start_x)
			{
				realSpeed = nowSpeed;
			}
			else
			{
				var c:Number = (end_y - start_y) / (end_x - start_x) * (end_y - start_y) / (end_x - start_x);
				realSpeed = nowSpeed * Math.sqrt((1 + c) / (1 / (1.4 * 1.4) + c / (1 * 1)));
			}
			allTime = distance / realSpeed * 1000;
			lastTime = getTimer();
			dx = end_x - start_x;
			dy = end_y - start_y;
			return true;
		}
		
		public function interruptPath():void
		{
			start_x = this.x;
			start_y = this.y;
			end_x = this.x;
			end_y = this.y;
			dx = 0;
			dy = 0;
		}
		
		public function addEffect(id:int, totTime:int = 500, pos:int = 1, isLoop:Boolean = false, px:int = 0, py:int = 0):void
		{
			if(id == 0)
			{
				return;
			}
			if(_effectMap == null)
			{
				_effectMap = new Dictionary();
			}
			if(_effectMap[id] != null)
			{
				removeEffect(id);
			}
			var effect:Effect = Effect.getEffect(true);
			effect.init(id, isLoop, totTime);
			effect.px = px;
			effect.py = py;
			if (pos == Effect.POS_DOWN)
			{
				addChildAt(effect, 0);
			}	
			else
			{
				addChild(effect);
			}
			_effectMap[id] = effect;
		}
		
		public function getEffect(id:int):Effect
		{
			if(_effectMap && _effectMap[id])
			{
				return _effectMap[id];
			}
			return null;
		}
		
		public function removeEffect(id:int):void
		{
			if(_effectMap == null || _effectMap[id] == null || id == 0)
			{
				return;
			}
			var effect:Effect = _effectMap[id];
			effect.dispose(true);
			delete _effectMap[id];
		}
		
		private function removeAllEffect():void
		{
			if(_effectMap != null)
			{
				for(var key:* in _effectMap)
				{
					removeEffect(int(key));
				}
				_effectMap = null;
			}
		}
		
		private function removeHitNumber():void
		{
			var hitNumber:DisplayObject = getChildByName("hit_" + this.name);
			if(hitNumber != null)
			{
				if(contains(hitNumber) == true)
				{
					removeChild(hitNumber);
				}
			}
		}
		
		private static var colorTransform:ColorTransform = new ColorTransform();
		
		public override function mouseOver():void
		{
			colorTransform.redOffset = 50;
			colorTransform.greenOffset = 50;
			colorTransform.blueOffset = 50;
			parts.getPart(Parts.BODY).transform.colorTransform = colorTransform;
		}
		
		public override function mouseOut():void
		{
			colorTransform.redOffset = 0;
			colorTransform.greenOffset = 0;
			colorTransform.blueOffset = 0;
			parts.getPart(Parts.BODY).transform.colorTransform = colorTransform;
		}
		
		public function doHit():void
		{
			_hitTime = getTimer();
			if(action == Action.STAND && action != Action.HITBACK)
			{
				action = Action.UNDER_ATTACK;
			}
		}
		
		public function triggerKeyframes():void
		{
			if(_isTrigger == false || _framesHandler == null)
			{
				return;
			}
			_isTrigger = true;
			_framesHandler();
			_framesHandler = null;
		}
		
		public function resetKeyFramesData(handler:Function):void
		{
			_framesHandler = handler;
			_isTrigger = true;
		}
		
		public function onHit(now:uint):void
		{
			if (_hitTime == 0)
			{
				return;
			}
			var time:int = now - _hitTime;
			var scale:Number = (HIT_TIME_EFFECT - time) / HIT_TIME_EFFECT;
			if (time > 0 && time < HIT_TIME_EFFECT)
			{
				colorTransform.redOffset = 125 * scale;
				colorTransform.greenOffset = 70 * scale;
				colorTransform.blueOffset = 0
				parts.getPart(Parts.BODY).transform.colorTransform = colorTransform;
			}
			else
			{
				mouseOut();
				_hitTime = 0;
			}
		}
		
		public function set hp(value:int):void
		{
			if (state == DEAD && value > 0)
			{
				state = LIFE;
			}
			else if (state == LIFE && value <= 0)
			{
				state = DEAD;
			}
			_hp = value;
		}
		
		public function get hp():int
		{
			return _hp;
		}
		
		public function set mp(value:int):void
		{
			_mp = value;
		}
		
		public function get mp():int
		{
			return _mp;
		}
		
		public function set level(value:int):void
		{
			this._level = value;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set hpMax(value:int):void
		{
			_hpMax = value;
		}
		
		public function get hpMax():int
		{
			return _hpMax;
		}
		
		public function set mpMax(value:int):void
		{
			_mpMax = value;
		}
		
		public function get mpMax():int
		{
			return _mpMax;
		}
		
		public function set way(value:int):void
		{
			parts.way = value;
		}
		
		public function get way():int
		{
			return parts.way;
		}
		
		public function set action(value:Action):void
		{
			if(_isLockMove == true && (value == Action.RUN || value == Action.JUMP))
			{
				return;
			}
			if(value == Action.JUMP || value == Action.DOWN)
			{
				_isLockMove = true;
			}
			else
			{
				_isLockMove = false;
			}
			if (value == Action.JUMP)
			{
				parts.b = distance * 0.5; /**重力(gravity) 0.5*/
				parts.a = -4 * parts.b;
			}
			parts.action = value;
		}
		
		public function get action():Action
		{
			return parts.action;
		}
		
		public function set buffList(value:Array):void
		{
			_buffList = value;
			buffStartTime = getTimer();
		}
		
		public function get buffList():Array
		{
			return _buffList;
		}
		
		public override function checkIn():void
		{
			_buffList = new Array();
			alphaNum = 1;
			isHitBack = false;
			state = LIFE;
			removeHeadIcon();
			removeAllEffect();
			removeHitNumber();
			super.checkIn();
		}
		
		public function caculateClosePoint(xPos:Number, yPos:Number, lockLen:int):Point
		{
			var distance:int = Utils.dist(this.x, this.y, xPos, yPos); 
			if(distance < lockLen)
			{
				return new Point(xPos, yPos);
			}
			var angle:Number = Math.atan2(yPos - this.y, xPos - this.x);
			var point:Point = Point.polar(lockLen, angle);
			var targetX:int = this.x + point.x;
			var targetY:int = this.y + point.y;
			return new Point(targetX, targetY);
		}
		
		public function set displayNameColor(value:int):void
		{
			switch (value)
			{
				case COLOR_WHITE:
					displayName = "<font color='#FFFFFF'> " + displayName + "</font>"
					break;
				case COLOR_GREEN:
					displayName = "<font color='#00FF00'> " + displayName + "</font>"
					break;
				case COLOR_BLUE:
					displayName = "<font color='#0000FF'> " + displayName + "</font>"
					break;
				case COLOR_PURPLE:
					displayName = "<font color='#9932CD'> " + displayName + "</font>"
					break;
				case COLOR_ORANGE:
					displayName = "<font color='#E47833'> " + displayName + "</font>"
					break;
				case COLOR_RED:
					displayName = "<font color='#FF0000'> " + displayName + "</font>"
					break;
				default:
					displayName = "<font color='#FFFFFF'> " + displayName + "</font>"
					break;
			}
		}
		
		public override function set visible(value:Boolean):void
		{
			_visible = value;
			var len:int = this.numChildren;
			for(var i:int = 0; i < len; i++)
			{
				var child:DisplayObject = this.getChildAt(i);
				if(child.name != NameBar.NAME)
				{
					child.visible = _visible;
				}
			}
		}
		
		public override function get visible():Boolean
		{
			return _visible;
		}
		
		public function set head(value:int):void
		{
			_head = value;
		}
		
		public function get head():int
		{
			return _head;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set speedPercent(value:Number):void
		{
			this._speedPercent = Math.max(0,value);
		}
		
		public function get speedPercent():Number
		{
			return _speedPercent;
		}
		
		public function addNameIcon(iconUrl:String, anchor:String = "right"):void
		{ 
			nameBar.addIcon(iconUrl, anchor);
		}
		
		public function removeNameIcon():void
		{
			nameBar.removeIcon();
		}
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			setChildVisibilty(child, _visible);
			return super.addChild(child);
		}
		
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return super.addChildAt(child, index);
		}
		
		private function setChildVisibilty(child:DisplayObject, value:Boolean):void
		{
			child.visible = value;
		}
		
		private function resetChildVisibilty(child:DisplayObject):void
		{
			child.visible = true;
		}
		
		public override function removeChild(child:DisplayObject):DisplayObject
		{
			resetChildVisibilty(child);
			return super.removeChild(child);
		}
		
		public override function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			resetChildVisibilty(child);
			return super.removeChildAt(index);
		}
		
		public function lockMove(value:Boolean, lastTime:int = -1, finishLockMoveHandler:Function = null):void
		{
			_isLockMove = value;
			_lockMoveLastTime = lastTime > 0? getTimer() + lastTime: -1;
			_finishLockMoveHandler = finishLockMoveHandler;
		}
		
		private function checkLockMove(now:int):void
		{
			if(_isLockMove == true && _lockMoveLastTime > 0 && now > _lockMoveLastTime)
			{
				_isLockMove = false;
				if(_finishLockMoveHandler != null)
				{
					_finishLockMoveHandler();
				}
			}
		}
		
		public function get isLockMove():Boolean
		{
			return _isLockMove;
		}
	
		public override function dispose():void
		{
			super.dispose();
			buffList = [];
			parts.dispose();
			nameBar.dispose();
		}
	}
}
