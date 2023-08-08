//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.recurringPrize.*;
    import org.robotlegs.mvcs.*;

    public class RecurringPrizeMediator extends Mediator {

        private const RECURRING_PRIZE_ID:uint = 6;

		[Inject]
        public var view:RecurringPrize;
		[Inject]
        public var model:RecurringPrizeModel;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var friendRanch:FriendRanchModel;
        private var grantInterval:int;// = 28800

        override public function onRegister():void{
            this.view.claimPrize.add(this.onClaimPrize);
            this.view.timerClick.add(this.onTimerClick);
            this.init();
            eventDispatcher.addEventListener(RecurringPrizeEvent.CLOSE_PROMPT, this.onClosePrompt);
        }
        override public function onRemove():void{
            this.view.claimPrize.remove(this.onClaimPrize);
            eventDispatcher.removeEventListener(RecurringPrizeEvent.CLOSE_PROMPT, this.onClosePrompt);
            this.view.dispose();
        }
        private function init():void{
            var _local1:RecurringPrizeType = this.model.prizes[this.RECURRING_PRIZE_ID];
            if (_local1){
                this.grantInterval = _local1.grantInterval;
            } else {
                this.view.enablePrizeButton();
                return;
            };
            var _local2:Number = (Number(_local1.nextGrant) - this.timer.currentTime);
            if ((((_local1.nextGrant == 0)) || ((_local1.nextGrant < this.timer.currentTime)))){
                this.view.enablePrizeButton();
            } else {
                this.view.setPrizeTimer(_local2);
            };
        }
        private function onClaimPrize():void{
            dispatch(new RecurringPrizeEvent(RecurringPrizeEvent.CLAIM_PRIZE));
            this.view.addPrompt(new RecurringPrizePrompt(this.assets.recurringPrizePrompt, this.grantInterval));
            this.view.setPrizeTimer(this.grantInterval);
            this.model.reset(this.RECURRING_PRIZE_ID, this.grantInterval);
        }
        private function onTimerClick(_arg1:int):void{
            this.view.addPrompt(new RecurringPrizePrompt(this.assets.recurringPrizePrompt, _arg1));
        }
        private function onClosePrompt(_arg1:RecurringPrizeEvent):void{
            this.view.removePrompt();
        }

    }
}//package com.gaiaonline.monster.view 
