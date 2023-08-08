//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {
    import __AS3__.vec.*;

    public class WhistleReportFriendVO {

        public var id:String;
        public var monsters:Vector.<WhistleReportMonsterVO>;
        private var levelUpMonster:Object;

        public function WhistleReportFriendVO(_arg1:Object, _arg2:String, _arg3:Object=null){
            var _local4:String;
            super();
            this.id = _arg2;
            this.monsters = new Vector.<WhistleReportMonsterVO>();
            for (_local4 in _arg1) {
                if (_arg3){
                    this.levelUpMonster = _arg3[_local4];
                };
                this.monsters.push(new WhistleReportMonsterVO(_arg1[_local4], _local4, this.levelUpMonster));
            };
        }
    }
}//package com.gaiaonline.monster.model.vo 
