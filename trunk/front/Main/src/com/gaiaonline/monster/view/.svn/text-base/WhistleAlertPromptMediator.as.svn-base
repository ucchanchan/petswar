//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.whistleAlert.*;

    public class WhistleAlertPromptMediator extends Mediator {

        public var view:WhistleAlertPrompt;

        override public function onRegister():void{
            this.view.confirm.add(this.onConfirm);
            this.view.close.add(this.onClose);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onConfirm():void{
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.HOME));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onClose():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
