package game.core.utils
{
	public class Node
	{
		public static const BLOCK:int 		= 0x1;//障碍区
		public static const ALPHA:int 		= 0x2;//透明区
		public static const JUMP:int 		= 0x4;//跳跃区
		public static const BUFF:int 		= 0x8;//buff区
		public static const SAFETY:int 		= 0x10;//安全区
		public static const WATER:int 		= 0x20;//水域区
		public static const BLOCKING:int  	= 0x40;//阻档区
		
		public static const OBSTACLE:int  	= 0x1;//障碍栅栏区
		public static const FLARE:int 		= 0x2;//爆发区
		public static const SWAMP:int 		= 0x4;//沼泽区
		public static const INTRIGUE:int 	= 0x8;//机关区
		
		public var index:int;
		public var row:int;
		public var col:int;
		public var f:Number;//路径估值
		public var g:Number;//当前格到开始格的路径消耗
		public var h:Number;//当前格到目标格的路径估值
		public var links:Vector.<Node>;
		public var version:int = 1;
		public var parent:Node;
		
		private var _isBlock:Boolean;
		public var isAlpha:Boolean;
		public var isJump:Boolean;
		public var isBuff:Boolean;
		public var isSafety:Boolean;
		public var isWater:Boolean;
		public var isBlocking:Boolean;
		
		/***路障区***/
		public var isObstacle:Boolean;
		/***爆发区***/
		public var isFlare:Boolean;
		/***沼泽区***/
		public var isSwamp:Boolean;
		/***机关区***/
		public var isIntrigue:Boolean;
		
		private var _isOpenBlocking:Boolean;
		
		public static var pool:Vector.<Node> = new Vector.<Node>();
		
		private var pRow:Array = [-1, 0, 1, 0];
		private var pCol:Array = [0, -1, 0, 1];
		
		public function init(index:int, row:int, col:int, data:int):void
		{
			this.index = index;
			this.row = row;
			this.col = col;
			_isBlock = ((data & BLOCK) == 0);
			isAlpha = _isBlock ? false : ((data & ALPHA) == 0);
			isJump = _isBlock ? false : ((data & JUMP) == 0);
			isBuff = _isBlock ? false : ((data & BUFF) == 0);
			isSafety = _isBlock ? false : ((data & SAFETY) == SAFETY);
			isWater = _isBlock ? false : ((data & WATER) == WATER);
			isBlocking = _isBlock?false:((data&BLOCKING) == BLOCKING);
		}
		
		public function setBuff(buffData:int):void
		{
			isObstacle = isBuff?((buffData&OBSTACLE) == 0):false;
			isFlare = isBuff?((buffData&FLARE) == 0):false;
			isSwamp = isBuff?((buffData&SWAMP) == 0):false;
			isIntrigue = isBuff?((buffData&INTRIGUE) == 0):false;
		}
		
		/***是否打开阻档***/
		public function set isOpenBlocking(value:Boolean):void
		{
			_isOpenBlocking = value;
		}
		
		public function initLink():void
		{
			links = new Vector.<Node>();
			for (var i:int = 0; i < 4; i++)
			{
				var tem:Node = Astar.getNode(row + pRow[i], col + pCol[i]);
				if (tem && !tem.isBlock)
					links.push(tem);
			}
		}
		
		public function get isOpenBlocking():Boolean
		{
			return _isOpenBlocking;
		}
		
		public function get isBlock():Boolean
		{
			if(_isBlock == true)
			{
				return true;
			}
			else
			{
				if(isBlocking == true && _isOpenBlocking == false)
				{
					return true;
				}
				else if(isBlocking == true && _isOpenBlocking == true)
				{
					return false;
				}
				return false;
			}
		}
		
		public function dispose():void
		{
			parent = null;
			pool.push(this);
			isObstacle = false;
			isFlare = false;
			isSwamp = false;
			isIntrigue = false;
			isOpenBlocking = false;
		}
	}
}