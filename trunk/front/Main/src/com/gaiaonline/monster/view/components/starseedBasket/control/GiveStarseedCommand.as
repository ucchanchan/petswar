//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.control {
    import com.gaiaonline.monster.view.components.starseedBasket.service.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class GiveStarseedCommand extends Command {

        public var gsi:GSIDataService;
        public var event:StarseedBasketEvent;
        public var process:GiveStarseedProcess;

        override public function execute():void{
            this.process.friendID = (this.event.data as String);
            this.gsi.giftStarseed(this.process);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.control 
