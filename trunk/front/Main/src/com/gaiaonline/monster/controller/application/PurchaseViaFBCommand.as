//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class PurchaseViaFBCommand extends Command {

		[Inject]
        public var event:PremiumPurchaseEvent;
		[Inject]
        public var fb:FBService;

        override public function execute():void{
            this.fb.premiumCoinPurchase(this.event.item);
        }

    }
}//package com.gaiaonline.monster.controller.application 
