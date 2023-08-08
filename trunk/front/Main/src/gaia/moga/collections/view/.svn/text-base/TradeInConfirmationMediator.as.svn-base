//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class TradeInConfirmationMediator extends Mediator {

        public var view:TradeInConfirmation;

        override public function onRegister():void{
            this.view.complete.addOnce(this.onViewComplete);
            this.view.okClick.addOnce(this.onOKClick);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onOKClick():void{
            this.view.transitionOut();
        }
        private function onViewComplete():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package gaia.moga.collections.view 
