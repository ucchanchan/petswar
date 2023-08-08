//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {

    public class RecurringPrizeType {

        public var lastGranted:int;// = 0
        public var nextGrant:int;// = 0
        public var grantInterval:int;

        public function RecurringPrizeType(_arg1:Object):void{
            if (!_arg1){
                return;
            };
            this.lastGranted = int(_arg1.last_granted_on);
            this.nextGrant = int(_arg1.next_grant_time);
            this.grantInterval = int(_arg1.interval);
        }
    }
}//package com.gaiaonline.monster.model.vo 
