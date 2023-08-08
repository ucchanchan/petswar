//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.async {
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class AnimAsyncWrapper implements Anim {

        private var async:Async;
        private var _complete:AnimSignal;

        public function AnimAsyncWrapper(_arg1:Async){
            this._complete = new AnimSignal();
            this.async = _arg1;
        }
        public function play():void{
            if (this.async.isComplete){
                this._complete.dispatch(this);
                return;
            };
            this.async.complete.addOnce(this.onAsyncComplete);
            this.async.error.addOnce(this.onAsyncComplete);
            this.async.init();
        }
        private function onAsyncComplete(_arg1:Async, _arg2:String=""):void{
            _arg1.complete.removeAll();
            _arg1.error.removeAll();
            _arg1 = null;
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.controller.async 
