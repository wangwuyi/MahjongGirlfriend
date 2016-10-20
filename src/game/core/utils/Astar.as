package game.core.utils
{
	
	import flash.utils.ByteArray;
	
	public class Astar
	{
		
		public static var size:int = 25;
		private static var mapCol:int;
		private static var mapRow:int;
		public static var grid:Vector.<Vector.<Node>>;
		private static var row:int, col:int;
		private static var startNode:Node;
		private static var endNode:Node;
		private static var nowversion:int = 1;
		
		private static var open:BinaryHeap;
		private static var close:Array = [];
		private static var arr:Array = [];
		private static var path:Array = [];
		
		private static var _straightCost:Number=1.0;//直线代价
		private static var _diagCost:Number = 1.4;//对角线代价
		
		public static function init(byte:ByteArray):void
		{
			open = new BinaryHeap();
			byte.position = 0;
			mapCol = Math.ceil(byte.readInt() / size);
			mapRow = Math.ceil(byte.readInt() / size);
			byte.readShort();
			var rowLen:int = (grid ? grid.length : 0);
			for (row = 0; row < rowLen; row++)
			{
				var colLen:int = grid[row].length;
				for (col = 0; col < colLen; col++)
				{
					grid[row][col].dispose();
				}
			}
			grid = new Vector.<Vector.<Node>>();
			var index:int = 0;
			for (row = 0; row < mapRow; row++)
			{
				grid[row] = new Vector.<Node>();
				for (col = 0; col < mapCol; col++)
				{
					grid[row][col] = Node.pool.length ? Node.pool.pop() : new Node();
					grid[row][col].init(index++, row, col, byte.readByte());
				}
			}
			for (row = 0; row < mapRow; row++)
			{
				for (col = 0; col < mapCol; col++)
				{
					var node:Node = grid[row][col];
					node.initLink();
				}
			}
		}
		
		public static function initBuff(byte:ByteArray):void
		{
			for (row = 0; row < mapRow; row++)
			{
				for (col = 0; col < mapCol; col++)
				{
					grid[row][col].setBuff(byte.readByte());
				}
			}
		}
		
		public static function getNode(row:int, col:int):Node
		{
			if (!grid)
				return null;
			if (row < 0 || row > grid.length - 1)
				return null;
			if (col < 0 || col > grid[0].length - 1)
				return null;
			if (!grid[row] || !grid[row][col])
				return null;
			return grid[row][col];
		}
		
		public static function walkable(x:int, y:int):Boolean
		{
			var row:int = y / size;
			var col:int = x / size;
			if (grid[row][col])
			{
				return grid[row][col].isBlock == false;
			}
			return false;
		}
		
		public static function find(x1:int, y1:int, x2:int, y2:int):Array
		{
			startNode = getRoundStartNode(y1 / size, x1 / size);
			if (!startNode)
				return null;
			y1 = startNode.row * size;
			x1 = startNode.col * size;
			endNode = getNode(Math.min(mapRow - 1, y2 / size), Math.min(mapCol - 1, x2 / size));
			if (!startNode || !endNode)
				return [];
			if (endNode.isBlock)
			{
				endNode = getRound(1);
				x2 = (endNode.col + .5) * size;
				y2 = (endNode.row + .5) * size;
			}
			startNode.g = 0;
			open.a.length = 1;
			close.length = 0;
			nowversion++;
			var node:Node = startNode;
			node.version = nowversion;
			
			while (node != endNode)
			{
				var len:int = node.links.length;
				for (var i:int = 0; i < len; i++)
				{
					var test:Node = node.links[i];
					if (close[test.index])
						continue;
					var g:Number = node.g + _straightCost;
					var dx:Number = test.row - endNode.row;
					var dy:Number = test.col - endNode.col;
					var mh:Number = Math.abs(dx) * _straightCost + Math.abs(dy) * _straightCost;//曼哈顿估价
					var jh:Number = Math.sqrt(dx * dx + dy * dy) * _straightCost;//几何估价
					var dh:Number = _straightCost * (dx + dy - 2 * Math.min(dx, dy)) + _diagCost * Math.min(dx, dy);//对角线估价
//					trace(dx+"_"+dy+":"+h+"-----------"+jh+"-----------"+dh);
					var h:Number = dh;
					var f:Number = g + h;
					if (test.version == nowversion)
					{
						if (test.f > f)
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
						}
					}
					else
					{
						test.f = f;
						test.g = g;
						test.h = h;
						test.parent = node;
						open.ins(test);
						test.version = nowversion;
					}
				}
				close[node.index] = node;
				if (open.a.length == 1)
					return [];
				node = open.pop() as Node;
			}
			
			arr.length = 0;
			path.length = 0;
			while (node != startNode)
			{
				arr.unshift([int((node.col + .5) * size), int((node.row + .5) * size)]);
				node = node.parent;
			}
			if (arr.length)
				arr.pop();
			arr.push([x2, y2]);
			
			var sx:int = x1;
			var sy:int = y1;
			var start:int;
			var end:int = arr.length - 1;
			for (var j:int = end; j >= start; j--)
			{
				if (pathCheck(sx, sy, arr[j][0], arr[j][1]))
				{
					path.push(arr[j]);
					sx = arr[j][0];
					sy = arr[j][1];
					start = j + 1;
					j = end + 1;
				}
			}
			return [].concat(path);
		}
		
		private static var dir:Array = [-1, 0, 1, 0, 0, -1, 0, 1];
		
		private static function getRoundStartNode(row:int, col:int):Node
		{
			if (getNode(row, col) && !getNode(row, col).isBlock)
			{
				return getNode(row, col);
			}
			for (var i:int = 0; i < 512; ++i)
			{
				++row;
				++col;
				for (var j:int = 0; j < 4; ++j)
				{
					for (var k:int = 0; k < i << 1; ++k)
					{
						var node:Node = getNode(row, col);
						if (node && !node.isBlock)
						{
							return node;
						}
						row += dir[j];
						col += dir[j + 4];
					}
				}
			}
			return null;
		}
		
		/**
		 * 寻找附近可达点
		 * @param i
		 * @return 
		 * 
		 */		
		private static function getRound(i:int):Node
		{
			var startRow:int = Math.max(endNode.row - i, 0);
			var startCol:int = Math.max(endNode.col - i, 0);
			var endRow:int = Math.min(endNode.row + i, mapRow - 1);
			var endCol:int = Math.min(endNode.col + i, mapCol - 1);
			var len:int = Math.abs(startRow - endRow);
			var arr:Array = [];
			for (var j:int = 0; j <= len; j++)
			{
				arr[0] = getNode(startRow, startCol + j);
				arr[1] = getNode(endRow, startCol + j);
				arr[2] = getNode(startRow + j, startCol);
				arr[3] = getNode(startRow + j, endCol);
				for (var k:int = 0; k < 4; k++)
				{
					if (arr[k] && !arr[k].isBlock)
						return arr[k];
				}
			}
			return getRound(++i);
		}
		
		/**
		 * 优化路线 
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return 
		 * 
		 */		
		private static function pathCheck(x1:int, y1:int, x2:int, y2:int):Boolean
		{
			var order:Boolean;
			var left:int, right:int, left_y:int, right_y:int;
			var dx:int, dy:int;
			if (((dx = x2 - x1) > 0 ? dx : -dx) > ((dy = y2 - y1) > 0 ? dy : -dy))
			{
				order = true;
				if (x1 < x2)
				{
					left = x1;
					right = x2;
					left_y = y1;
					right_y = y2;
				}
				else
				{
					left = x2;
					right = x1;
					left_y = y2;
					right_y = y1;
				}
			}
			else
			{
				order = false;
				if (y1 < y2)
				{
					left = y1;
					right = y2;
					left_y = x1;
					right_y = x2;
				}
				else
				{
					left = y2;
					right = y1;
					left_y = x2;
					right_y = x1;
				}
			}
			var rate:Number = (right_y - left_y) / (right - left);
			var LY:int = left_y / size;
			var len:int = right / size;
			var m1:Number = rate * size;
			var m2:Number = (size - left) * rate + left_y + 0.5;
			for (var X:int = left / size; X < len; X++)
			{
				var Y:int = (X * m1 + m2) / size;
				if (((order ? grid[LY][X] : grid[X][LY]) as Node).isBlock)
					return false;
				if (Y != LY)
				{
					if (((order ? grid[Y][X] : grid[X][Y]) as Node).isBlock)
						return false;
					LY = Y;
				}
			}
			return true;
		}
	}
}
import game.core.utils.Node;

class BinaryHeap
{
	
	public var a:Vector.<Node>;
	
	public function BinaryHeap()
	{
		a = new Vector.<Node>();
		a.push(null);
	}
	
	public function ins(node:Node):void
	{
		var p:int = a.length;
		a[p] = node;
		var pp:int = p >> 1;
		while (p > 1 && (a[p].f < a[pp].f))
		{
			var temp:Node = a[p];
			a[p] = a[pp];
			a[pp] = temp;
			p = pp;
			pp = p >> 1;
		}
	}
	
	public function pop():Node
	{
		var min:Node = a[1];
		a[1] = a[a.length - 1];
		a.pop();
		var p:int = 1;
		var l:int = a.length;
		var sp1:int = p << 1;
		var sp2:int = sp1 + 1;
		while (sp1 < l)
		{
			if (sp2 < l)
			{
				var minp:int = (a[sp2].f < a[sp1].f) ? sp2 : sp1;
			}
			else
			{
				minp = sp1;
			}
			if (a[minp].f < a[p].f)
			{
				var temp:Node = a[p];
				a[p] = a[minp];
				a[minp] = temp;
				p = minp;
				sp1 = p << 1;
				sp2 = sp1 + 1;
			}
			else
			{
				break;
			}
		}
		return min;
	}
}
