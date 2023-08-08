//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.app.overlay.*;

    public class OverlayMediator extends Mediator {

		[Inject]
        public var view:PanelStack;

        override public function onRegister():void{
            eventDispatcher.addEventListener(PanelsEvent.ADD_OVERLAY, this.onAddOverlay);
            eventDispatcher.addEventListener(PanelsEvent.REMOVE_OVERLAY, this.onRemoveOverlay);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(PanelsEvent.ADD_OVERLAY, this.onAddOverlay);
            eventDispatcher.removeEventListener(PanelsEvent.REMOVE_OVERLAY, this.onRemoveOverlay);
            this.dispose();
        }
        private function onAddOverlay(_arg1:PanelsEvent):void{
            this.view.push(_arg1.panel);
        }
        private function onRemoveOverlay(_arg1:PanelsEvent):void{
            this.view.remove(_arg1.panel);
        }
        private function dispose():void{
            var _local1:Panel = this.view.pop();
            while (_local1) {
                _local1.dispose();
                _local1 = this.view.pop();
            };
        }

    }
}//package com.gaiaonline.monster.view 
