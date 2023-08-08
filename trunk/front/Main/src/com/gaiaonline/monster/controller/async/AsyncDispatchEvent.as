//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.async {
    import flash.events.*;
    import alecmce.async.*;

    public class AsyncDispatchEvent extends AsyncBase implements Async {

        private var event:Event;
        private var dispatcher:IEventDispatcher;

        public function AsyncDispatchEvent(_arg1:IEventDispatcher, _arg2:Event){
            this.dispatcher = _arg1;
            this.event = _arg2;
        }
        override protected function onInit():void{
            this.dispatcher.dispatchEvent(this.event);
            this.dispatcher = null;
            this.event = null;
            asyncComplete();
        }
        override public function get name():String{
            return (((super.name + " ") + this.event.type));
        }

    }
}//package com.gaiaonline.monster.controller.async 
