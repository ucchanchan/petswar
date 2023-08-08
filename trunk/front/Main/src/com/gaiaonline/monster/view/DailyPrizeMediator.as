//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.dailyPrize.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class DailyPrizeMediator extends Mediator {

        public var view:DailyPrize;
        public var model:SettingsModel;

        override public function onRegister():void{
            this.view.confirm.addOnce(this.onConfirm);
            this.view.close.addOnce(this.onClose);
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.OPEN_DAILY_PRIZE_PROMPT));
        }
        override public function onRemove():void{
            this.view.onRemove();
            this.view.dispose();
            this.view.confirm.remove(this.onConfirm);
            this.view.close.remove(this.onClose);
        }
        private function onConfirm():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.ENABLE_DAILY_PRIZE_PROMPT));
            dispatch(new SettingsEvent(SettingsEvent.UPDATE_SETTINGS, 1, "dailyPrize"));
            this.model.enablePrize = true;
        }
        private function onClose():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
