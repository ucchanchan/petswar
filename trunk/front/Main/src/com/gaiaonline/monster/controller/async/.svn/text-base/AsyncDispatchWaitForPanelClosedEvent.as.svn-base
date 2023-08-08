//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.async {
    import flash.events.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;

    public class AsyncDispatchWaitForPanelClosedEvent extends AsyncBase implements Async {

        private var clazz:Class;
        private var event:Event;
        private var dispatcher:IEventDispatcher;

        public function AsyncDispatchWaitForPanelClosedEvent(_arg1:IEventDispatcher, _arg2:Event, _arg3:Class=null){
            this.clazz = _arg3;
            this.dispatcher = _arg1;
            this.event = _arg2;
            _arg1.addEventListener(PanelsEvent.REMOVE_OVERLAY, this.onPanelClosed);
        }
        override protected function onInit():void{
            this.dispatcher.dispatchEvent(this.event);
            if (this.clazz == null){
                asyncComplete();
            };
        }
        private function onPanelClosed(_arg1:PanelsEvent):void{
            if ((_arg1.panel is this.clazz)){
                asyncComplete();
                this.dispatcher.removeEventListener(PanelsEvent.REMOVE_OVERLAY, this.onPanelClosed);
                this.dispatcher = null;
                this.event = null;
            };
        }

    }
}//package com.gaiaonline.monster.controller.async 
