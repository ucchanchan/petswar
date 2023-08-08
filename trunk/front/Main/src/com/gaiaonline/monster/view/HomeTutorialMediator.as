//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.homeTutorial.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class HomeTutorialMediator extends Mediator {

        public var view:HomeTutorial;
        public var tracking:OmnitureService;

        override public function onRegister():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.START_TUTORIAL));
            this.view.complete.addOnce(this.onComplete);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onComplete():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
