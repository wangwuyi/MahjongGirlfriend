package game.core.utils
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class JumpPath
	{
		private static var destMap:Dictionary = new Dictionary();
		private static var srcMap:Dictionary = new Dictionary();
		private static var pathList:Array = [];
		private static var pathDic:Dictionary = new Dictionary();
		private static var isFind:Boolean;
		private static var close:Dictionary = new Dictionary();
		private static var nodeQueue:Array = new Array();
		
		public static function init(jumps:Array):void
		{
			var i:int = 0;
			var len:int = jumps.length;
			for (i = 0; i < len; i++)
			{
				var node:Node = new Node;
				node.init(jumps[i]);
				if (destMap[node.destMapId] != null)
				{
					destMap[node.destMapId].push(node)
				}
				else
				{
					destMap[node.destMapId] = [node]
				}
				if (srcMap[node.srcMapId] != null)
				{
					srcMap[node.srcMapId].push(node)
				}
				else
				{
					srcMap[node.srcMapId] = [node];
				}
			}
		}
		
		public static function getAdjacentMapIdArr(mapId:int):Array
		{
			var result:Array = new Array();
			var nodeArr:Array = srcMap[mapId];
			if(nodeArr != null && nodeArr.length > 0)
			{
				for each(var node:Node in nodeArr)
				{
					result.push(node.destMapId);
				}
			}
			return result;
		}
		
		public static function find(srcMapId:int, destMapId:int):Array
		{
			if(srcMapId == destMapId)
			{
				return null;
			}
			var key:String = srcMapId + "," + destMapId;
			if (pathDic[key] != null)
			{
				return pathDic[key].concat();
			}
			for (var k:String in close)
			{
				delete close[k];
			}
			isFind = false;
			nodeQueue.length = 0;
			pathList.length = 0;
			getPath(srcMapId, destMapId);
			if (isFind == true)
			{
				var len:int = pathList.length;
				for (var i:int = 0; i < len; i++)
				{
					var node:Node = getMapJumpPoint(srcMapId, pathList[i])
					var mapId:int = pathList[i]
					pathList[i] = [node.x, node.y, srcMapId, node.npcId];
					srcMapId = mapId
				}
				pathDic[key] = pathList.concat();
			}
			return isFind ? pathDic[key].concat() : null
		}
		
		private static function getMapJumpPoint(srcMapId:int, destMapId:int):Node
		{
			if (destMapId == 0)
			{
				return null;
			}
			var node:Node;
			var len:int = srcMap[srcMapId].length;
			for (var i:int = 0; i < len; i++)
			{
				if (srcMap[srcMapId][i].destMapId == destMapId)
				{
					/*Utils.point.x = srcMap[srcMapId][i].x
					Utils.point.y = srcMap[srcMapId][i].y
					point = Utils.point;*/
					node = srcMap[srcMapId][i];
					break;
				}
			}
			return node;
		}
		
		private static function getPath(srcMapId:int, destMapId:int):void
		{
			addNodeToQueue(srcMapId, destMapId, null);
			while(nodeQueue.length > 0)
			{
				var node:Node = nodeQueue.shift();
				if(srcMapId == node.srcMapId)
				{
					generatePath(node, destMapId);
					isFind = true;
					return;
				}
				else
				{
					addNodeToQueue(srcMapId, node.srcMapId, node);
				}
			}
		}
		
		private static function generatePath(node:Node, destMapId:int):void
		{
			while(node != null)
			{
				pathList.push(node.destMapId);
				node = node.previousNode;
			}
		}
		
		private static function addNodeToQueue(srcMapId:int, destMapId:int, previousNode:Node):void
		{
			var nodeArr:Array = destMap[destMapId];
			if(nodeArr == null)
			{
				return;
			}
			var len:int = nodeArr.length;
			for(var i:int = 0; i < len; i++)
			{
				var node:Node = nodeArr[i] as Node; 
				if(close[srcMapId + "," + node.srcMapId] == true)
				{
					continue;
				}
				close[srcMapId + "," + node.srcMapId] = true;
				node.previousNode = previousNode;
				nodeQueue.push(node);
			}
		}
		
		/*
		private static function getPathFind(srcMapId:int, destMapId:int):void
		{
			close[srcMapId + "," + destMapId] = true;
			pathList.push(destMapId);
			var len:int = pathList.length;
			var node:Node;
			for (var i:int = 0; srcMapId != destMapId && destMap[destMapId] && i < destMap[destMapId].length; i++)
			{
				node = destMap[destMapId][i]
				if (srcMapId == node.srcMapId)
				{
					isFind = true
					return;
				}
				if (close[srcMapId + "," + node.srcMapId] == true)
				{
					continue;
				}
				getPathFind(srcMapId, node.srcMapId);
				if (isFind == true)
				{
					return;
				}
				pathList = pathList.slice(0, len);
			}
		}
	*/
	}
}

class Node
{
	public var npcId:int;
	public var destMapId:int;
	public var x:int;
	public var y:int;
	public var srcMapId:int
	public var previousNode:Node; //寻路过程中记录上层节点,每次寻路的时候会被覆写
	
	public function init(data:Array):void
	{
		npcId = data[0];
		srcMapId = data[1];
		destMapId = data[2];
		x = data[3];
		y = data[4];
		previousNode = null;
	}
}
