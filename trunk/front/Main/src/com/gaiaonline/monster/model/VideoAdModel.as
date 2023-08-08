//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import com.gaiaonline.monster.service.*;
    import gaia.lib.*;
    import org.robotlegs.mvcs.*;

    public class VideoAdModel extends Actor {

		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var timer:TimerService;
        public var isPurchaser:Boolean;
        public var progId:String;
        public var minPurchaseInterval:int;
        public var minPurchaseAmount:int;
        public var videoAdInterval:int;
        public var dormantInterval:int;
        public var isEnabled:Boolean;

        private static const COOKIE_NAME:String = "lastTimeShownVideoAd";

        public function init(_arg1:Object):void{
            var _local2:String;
            var _local3:int;
            var _local4:int;
            var _local5:int;
            if (!_arg1){
                this.isPurchaser = false;
                return;
            };
            for (_local2 in _arg1) {
                _local3 = _arg1[_local2].time_placed;
                _local4 = _arg1[_local2].amount;
                _local5 = (this.timer.currentTime - _local3);
                if ((((_local5 < this.minPurchaseInterval)) && ((_local4 < this.minPurchaseAmount)))){
                    this.isPurchaser = true;
                };
            };
        }
        public function canShowAd():Boolean{
            var _local1:Number = this.cookie.getValue(COOKIE_NAME, 0);
            var _local2:Number = (this.timer.currentTime - (_local1 - 1));
            if (((((((this.isEnabled) && ((_local2 > this.videoAdInterval)))) && ((_local2 < this.dormantInterval)))) && (!(this.isPurchaser)))){
                this.cookie.setValue(COOKIE_NAME, this.timer.currentTime);
                return (true);
            };
            if (_local2 > this.dormantInterval){
                this.cookie.setValue(COOKIE_NAME, this.timer.currentTime);
            };
            return (false);
        }

    }
}//package com.gaiaonline.monster.model 
