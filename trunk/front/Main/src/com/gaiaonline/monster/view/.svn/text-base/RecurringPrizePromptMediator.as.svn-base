//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.recurringPrize.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class RecurringPrizePromptMediator extends Mediator {

		[Inject]
        public var view:RecurringPrizePrompt;

        override public function onRegister():void{
            this.view.close.addOnce(this.onClose);
            this.view.openShop.addOnce(this.onOpenShop);
            this.view.askForStarseeds.addOnce(this.onAskForStarseeds);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onClose():void{
            this.closeView();
        }
        private function onOpenShop():void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
            this.closeView();
        }
        private function closeView():void{
            this.view.closePrompt();
            dispatch(new RecurringPrizeEvent(RecurringPrizeEvent.CLOSE_PROMPT));
        }
        private function onAskForStarseeds():void{
            dispatch(new StarseedBasketEvent(StarseedBasketEvent.OPEN_REQUESTOR_UI));
            this.closeView();
        }

    }
}//package com.gaiaonline.monster.view 
