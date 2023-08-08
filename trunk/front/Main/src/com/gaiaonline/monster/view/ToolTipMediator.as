//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.tooltip.*;

    public class ToolTipMediator extends Mediator {

		[Inject]
        public var view:ToolTips;

        override public function onRegister():void{
            eventDispatcher.addEventListener(ToolTipEvent.ADD_TOOLTIP, this.addTip);
            eventDispatcher.addEventListener(ToolTipEvent.REMOVE_TOOLTIP, this.removeTip);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(ToolTipEvent.ADD_TOOLTIP, this.addTip);
            eventDispatcher.removeEventListener(ToolTipEvent.REMOVE_TOOLTIP, this.removeTip);
            this.view.removeAll();
        }
        private function addTip(_arg1:ToolTipEvent):void{
            this.view.add(_arg1.object, _arg1.tip, _arg1.autoRemove);
        }
        private function removeTip(_arg1:ToolTipEvent):void{
            this.view.remove(_arg1.object);
        }

    }
}//package com.gaiaonline.monster.view 
