//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import flash.utils.*;
    import com.gaiaonline.monster.model.vo.*;

    public class RecurringPrizeModel {

		[Inject]
        public var model:ApplicationModel;
        public var prizes:Dictionary;

        public function update(_arg1:Object):void{
            var _local2:String;
            this.prizes = new Dictionary();
            for (_local2 in _arg1) {
                this.prizes[_local2] = new RecurringPrizeType(_arg1[_local2]);
            };
        }
        public function reset(_arg1:int, _arg2:int):void{
            if (!this.prizes[_arg1]){
                this.prizes[_arg1] = new RecurringPrizeType({last_granted_on:this.model.currentTime, next_grant_time:(this.model.currentTime + _arg2), interval:_arg2});
                return;
            };
            var _local3:RecurringPrizeType = this.prizes[_arg1];
            _local3.nextGrant = (this.model.currentTime + _local3.grantInterval);
        }

    }
}//package com.gaiaonline.monster.model 
