//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import org.robotlegs.mvcs.*;

    public class PanelsMediator extends Mediator {

		[Inject]
        public var view:Panels;

        override public function onRegister():void{
            eventDispatcher.addEventListener(PanelsEvent.SET_PANEL, this.onPushPanel);
            this.view.swapped.add(this.onPanelsSwapped);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(PanelsEvent.SET_PANEL, this.onPushPanel);
            this.view.swapped.remove(this.onPanelsSwapped);
        }
        private function onPushPanel(_arg1:PanelsEvent):void{
            this.view.panel = _arg1.panel;
        }
        private function onPanelsSwapped():void{
            var _local1:Panel = this.view.previous;
            if (_local1){
                _local1.dispose();
                while (_local1.numChildren > 0) {
                    _local1.removeChildAt(0);
                };
                this.view.clearPrevious();
            };
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
        }

    }
}//package com.gaiaonline.monster.view 
