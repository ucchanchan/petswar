//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.itemGrant.*;

    public class ItemGrantMediator extends Mediator {

        public var view:ItemGrant;

        override public function onRegister():void{
            this.view.close.add(this.onClose);
        }
        override public function onRemove():void{
            this.view.close.remove(this.onClose);
            this.view.dispose();
        }
        private function onClose(_arg1:int):void{
            if (_arg1 == ItemEnum.DAILY_PRIZE){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_OPEN_RIG));
            };
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
