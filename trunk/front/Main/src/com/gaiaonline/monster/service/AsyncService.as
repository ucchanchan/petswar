//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import __AS3__.vec.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import org.robotlegs.mvcs.*;

    public class AsyncService extends Actor {

        private var stack:Vector.<Async>;
        private var current:Async;

        public function AsyncService(){
            this.stack = new Vector.<Async>();
        }
        public function push(_arg1:Async):void{
            if (!this.current){
                this.initAsCurrent(_arg1);
            } else {
                this.stack.push(_arg1);
            };
        }
        public function pushAnim(_arg1:Anim):void{
            if (!_arg1){
                return;
            };
            this.push(new AnimWrapper(_arg1));
        }
        private function initAsCurrent(_arg1:Async):void{
            this.current = _arg1;
            if (this.current.isComplete){
                this.onComplete(_arg1);
            } else {
                if (this.current.isError){
                    this.onError(_arg1, "AsyncService cannot init async that isError");
                } else {
                    this.current.complete.addOnce(this.onComplete);
                    if (this.current.error.numListeners == 0){
                        this.current.error.addOnce(this.onError);
                    } else {
                        this.current.error.addOnce(this.ignoreError);
                    };
                    this.current.init();
                };
            };
        }
        private function onComplete(_arg1:Async):void{
            this.cleanupCurrent();
            if (this.stack.length){
                this.initAsCurrent(this.stack.shift());
            };
        }
        private function onError(_arg1:Async, _arg2:String):void{
            this.cleanupCurrent();
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 113));
        }
        private function ignoreError(_arg1:Async, _arg2:String):void{
            this.onComplete(_arg1);
        }
        private function cleanupCurrent():void{
            this.current.complete.removeAll();
            this.current.error.removeAll();
            this.current = null;
        }

    }
}//package com.gaiaonline.monster.service 

import alecmce.async.*;
import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

class AnimWrapper extends AsyncBase {

    private var anim:Anim;

    public function AnimWrapper(_arg1:Anim){
        this.anim = _arg1;
    }
    override protected function onInit():void{
        this.anim.complete.addOnce(this.onComplete);
        this.anim.play();
    }
    private function onComplete(_arg1:Anim):void{
        this.anim = null;
        asyncComplete();
    }
    override public function get name():String{
        return (("WrappedAnim - " + this.anim));
    }

}
