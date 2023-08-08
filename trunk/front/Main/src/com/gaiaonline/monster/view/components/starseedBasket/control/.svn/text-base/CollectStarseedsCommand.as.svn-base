//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.control {
    import com.gaiaonline.monster.view.components.starseedBasket.service.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class CollectStarseedsCommand extends Command {

        public var gsi:GSIDataService;
        public var event:StarseedBasketEvent;
        public var process:CollectStarseedsProcess;

        override public function execute():void{
            this.process.outputData = this.event.data;
            this.gsi.collectGiftedStarseeds(this.process);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.control 
