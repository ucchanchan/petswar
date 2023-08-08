//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.app.*;

    public class LoadingMediator extends Mediator {

		[Inject]
        public var view:Loading;

        override public function onRegister():void{
            eventDispatcher.addEventListener(ApplicationEvent.LOADING, this.onLoading);
            eventDispatcher.addEventListener(ApplicationEvent.NOT_LOADING, this.onNotLoading);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(ApplicationEvent.LOADING, this.onLoading);
            eventDispatcher.removeEventListener(ApplicationEvent.NOT_LOADING, this.onNotLoading);
        }
        private function onLoading(_arg1:ApplicationEvent):void{
            this.view.visible = true;
        }
        private function onNotLoading(_arg1:ApplicationEvent):void{
            this.view.visible = false;
        }

    }
}//package com.gaiaonline.monster.view 
