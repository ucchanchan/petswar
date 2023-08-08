//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {
    import __AS3__.vec.*;

    public class AnimStack implements Anim {

        protected var _anims:Vector.<Anim>;
        protected var _isPlaying:Boolean;
        protected var _complete:AnimSignal;
        public var debug:String;

        private static const DEFAULT_ANIM:String = "[AnimStack]";

        public function AnimStack(){
            this.debug = DEFAULT_ANIM;
            this._anims = new Vector.<Anim>();
            this._isPlaying = false;
            this._complete = new AnimSignal();
        }
        public function push(_arg1:Anim):void{
            this._anims.push(_arg1);
        }
        public function play():void{
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            this.playLoop();
        }
        private function playLoop(_arg1:Anim=null):void{
            if (this._anims.length){
                _arg1 = this._anims.shift();
                _arg1.complete.addOnce(this.playLoop);
                _arg1.play();
                return;
            };
            this._isPlaying = false;
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }
        public function toString():String{
            return (this.debug);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
