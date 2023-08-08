//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class PurchaseViaOfferCommand extends Command {

		[Inject]
        public var event:PremiumPurchaseEvent;
		[Inject]
        public var monetization:MonetizationService;

        override public function execute():void{
            this.monetization.showOffersPopup({});
        }

    }
}//package com.gaiaonline.monster.controller.application 
