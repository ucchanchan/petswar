//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.prizeTimer {
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.controller.*;

    public class RecurringPrizeClaimCommand extends AsyncCommand {

		[Inject]
        public var process:RecurringPrizeClaimProcess;

        override public function execute():void{
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:GSIProcess):void{
        }
        private function onError(_arg1:GSIProcess, _arg2:String=""):void{
        }

    }
}//package com.gaiaonline.monster.controller.prizeTimer 
