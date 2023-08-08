//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import gaia.moga.world.events.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.whistleAlert.*;

    public class WhistleAlertMediator extends Mediator {

        public var view:WhistleAlert;
        public var model:FriendsModel;
        public var assets:AssetService;

        override public function onRegister():void{
            this.view.ready.add(this.onUpdate);
            this.view.confirm.add(this.onConfirm);
            this.view.close.add(this.onClose);
            eventDispatcher.addEventListener(WorldAnimateTravelEvent.WALK, this.onClose);
            eventDispatcher.addEventListener(WorldAnimateTravelEvent.TAXI, this.onClose);
        }
        override public function onRemove():void{
            this.view.dispose();
            this.view.stopTimer();
            this.view.ready.remove(this.onUpdate);
            this.view.confirm.remove(this.onConfirm);
            this.view.close.remove(this.onClose);
            eventDispatcher.removeEventListener(WorldAnimateTravelEvent.WALK, this.onClose);
            eventDispatcher.removeEventListener(WorldAnimateTravelEvent.TAXI, this.onClose);
        }
        private function onClose(_arg1:WorldAnimateTravelEvent=null):void{
            this.view.removeAlert();
        }
        private function onUpdate():void{
            this.view.updateText(this.model.whistleCount);
        }
        private function onConfirm():void{
            var _local1:WhistleAlertPrompt = new WhistleAlertPrompt(this.assets.whistleAlertPrompt);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local1));
            this.view.removeAlert();
        }

    }
}//package com.gaiaonline.monster.view 
