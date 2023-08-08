//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {

    public class WhistleReportMonsterVO {

        public var id:String;
        public var xp:int;
        public var lastUpdate:int;
        public var levelUp:Object;
        public var bonus:int;

        public function WhistleReportMonsterVO(_arg1:Object, _arg2:String, _arg3:Object=null){
            this.id = _arg2;
            this.xp = _arg1.activity_bundle.gain;
            this.bonus = _arg1.activity_bundle.bonus;
            this.lastUpdate = _arg1.last_updated;
            if (_arg3){
                this.levelUp = _arg3;
            };
        }
    }
}//package com.gaiaonline.monster.model.vo 
