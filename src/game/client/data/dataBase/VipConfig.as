package game.client.data.dataBase
{
      import flash.utils.Dictionary;
      public class VipConfig
      {
        /**
         * vip等级
         */
        public var vipLv:int;
        /**
         * vip天数
         */
        public var keepdays:int;
        /**
         * 绑定元宝
         */
        public var bindRMB:int;
        /**
         * vip卡ItemId
         */
        public var itemId:int;
        /**
         * buf描述
         */
        public var buffdesc:String;
        /**
         * 免费浮云数
         */
        public var freeFly:int;
        /**
         * 温泉加成
         */
        public var hotspringAddition:int;
        /**
         * 打坐加成
         */
        public var sitExpAddition:int;
        /**
         * 免费复活次数
         */
        public var freeRelive:int;
        /**
         * 免费传音次数
         */
        public var freeExpress:int;
        /**
         * 增加好友上限
         */
        public var addFriendsCap:int;
        /**
         * 远程仓库
         */
        public var remoteStorage:int;
        /**
         * 远程药店
         */
        public var remoteDrug:int;
        /**
         * 批量出售
         */
        public var batchSail:int;
        /**
         * 个性头像
         */
        public var specialHeadIcon:int;
        /**
         * 挂机地图
         */
        public var vipMap:int;
        /**
         * 特殊表情
         */
        public var specialGif:int;
        /**
         * 窗口抖动
         */
        public var shakeWindow:int;
        /**
         * 免费加速
         */
        public var freeAccelerate:int;
        /**
         * 副本委托
         */
        public var copysceneTrust:int;
        /**
         * 首次激活送物品
         */
        public var itemList:Array;
        public function VipConfig(data:Array)
        {
            vipLv = data[0];
            keepdays = data[1];
            bindRMB = data[2];
            itemId = data[3];
            buffdesc = data[4];
            freeFly = data[5];
            hotspringAddition = data[6];
            sitExpAddition = data[7];
            freeRelive = data[8];
            freeExpress = data[9];
            addFriendsCap = data[10];
            remoteStorage = data[11];
            remoteDrug = data[12];
            batchSail = data[13];
            specialHeadIcon = data[14];
            vipMap = data[15];
            specialGif = data[16];
            shakeWindow = data[17];
            freeAccelerate = data[18];
            copysceneTrust = data[19];
            itemList = data[20];
        }
        private static var _data:Array = [
            [0, 0, 0, 0, "0", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [], ],
            [1, 7, 5, 216001, "攻击+50 气血+350 防御+20 全抗+20", 15, 50, 5, 3, 3, 10, 1, 1, 1, 1, 1, 1, 1, 1, 0, [12100,20101,12101], ],
            [2, 30, 8, 216002, "攻击+100 气血+550 防御+40 全抗+40", 20, 50, 8, 5, 5, 15, 1, 1, 1, 1, 1, 1, 1, 1, 0, [12100,20101,12102], ],
            [3, 180, 10, 216003, "攻击+150 气血+750 防御+60 全抗+60", 999, 50, 10, 10, 10, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, [12100,20101,12103], ],
        ];
        private static function InitData(): Dictionary
        {
            var dic:Dictionary = new Dictionary();
            for (var i:int = 0; i < _data.length; i++)
            {
                var data:Array = (_data[i] as Array);
                dic[data[0]] = new VipConfig(data);
            }
            return dic;
        }
        public static var configData:Dictionary = InitData();
    }
}
