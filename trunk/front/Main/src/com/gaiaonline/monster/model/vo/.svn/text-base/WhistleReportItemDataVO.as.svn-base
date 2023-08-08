//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {
    import __AS3__.vec.*;

    public class WhistleReportItemDataVO {

        public var instanceId:String;
        public var friends:Vector.<String>;
        public var xp:int;// = 0
        public var levelUp:Object;
        public var multiplier:int;// = 1
        private var totalBonuses:int;// = 0

        public function WhistleReportItemDataVO(_arg1:String, _arg2:Object=null){
            this.friends = new Vector.<String>();
            this.instanceId = _arg1;
            this.levelUp = _arg2;
        }
        public function addFriend(_arg1:String):void{
            this.friends.push(_arg1);
        }
        public function addXP(_arg1:int, _arg2:int):void{
            _arg2 = ((_arg2) || (1));
            this.xp = (this.xp + _arg1);
            this.totalBonuses = (this.totalBonuses + _arg2);
            this.multiplier = Math.round((this.totalBonuses / this.friends.length));
        }

    }
}//package com.gaiaonline.monster.model.vo 
