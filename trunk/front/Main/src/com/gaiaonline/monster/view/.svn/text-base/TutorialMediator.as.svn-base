//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.tutorial.*;

    public class TutorialMediator extends Mediator {

		[Inject]
        public var view:Tutorial;

        override public function onRegister():void{
            this.view.complete.addOnce(this.onTutorialComplete);
            eventDispatcher.addEventListener(ApplicationEvent.SET_STATE, this.onChangeState);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onTutorialComplete():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onChangeState(_arg1:ApplicationEvent):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
