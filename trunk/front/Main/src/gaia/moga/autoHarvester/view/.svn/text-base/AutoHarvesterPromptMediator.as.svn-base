//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class AutoHarvesterPromptMediator extends Mediator {

        public var view:AutoHarvesterPrompt;
        public var player:PlayerModel;

        override public function onRegister():void{
            this.view.confirm.addOnce(this.onConfirm);
            this.view.close.addOnce(this.onClose);
            dispatch(new TrackingEvent(TrackingEvent.TRACK, "autoharvester_open"));
        }
        override public function onRemove():void{
            this.view.confirm.removeAll();
            this.view.close.removeAll();
        }
        private function onConfirm():void{
            if (this.player.premiumCurrency >= 10){
                dispatch(new HomeEvent(HomeEvent.ACTIVATE_AUTO_HARVESTER));
            } else {
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
            };
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
            dispatch(new HomeEvent(HomeEvent.CLOSE_AUTO_HARVESTER_PROMPT));
        }
        private function onClose():void{
            dispatch(new HomeEvent(HomeEvent.CLOSE_AUTO_HARVESTER_PROMPT));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package gaia.moga.autoHarvester.view 
