//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import org.osflash.signals.*;
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class ExternalInterfaceService extends Actor {

        public var pause:Signal;
        public var unpause:Signal;

        public function ExternalInterfaceService(){
            this.pause = new Signal();
            this.unpause = new Signal();
        }
        public function pauseGame():void{
            eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.INVOKE_SMALLSCREEN));
            this.pause.dispatch();
        }
        protected function onClosePopup(_arg1=null):void{
            this.unpauseGame();
        }
        public function unpauseGame():void{
            this.unpause.dispatch();
        }

    }
}//package com.gaiaonline.monster.service 
