//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {
    import __AS3__.vec.*;

    public class ParallelAnims implements Anim {

        private var _anims:Vector.<Anim>;
        private var _count:uint;
        private var _waiting:uint;
        private var _isPlaying:Boolean;
        private var _complete:AnimSignal;
        public var debug:String;

        private static const DEFAULT_ANIM:String = "[ParallelAnim]";

        public function ParallelAnims(){
            this.debug = DEFAULT_ANIM;
            this._anims = new Vector.<Anim>();
            this._count = 0;
            this._isPlaying = false;
            this._complete = new AnimSignal();
        }
        public function add(_arg1:Anim):void{
            var _local2 = this._count++;
            this._anims[_local2] = _arg1;
        }
        public function play():void{
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            this.innerPlay();
        }
        private function innerPlay():void{
            var _local3:Anim;
            this._waiting = this._count;
            if (!this._waiting){
                this._complete.dispatch(this);
                return;
            };
            var _local1:uint = this._count;
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = this._anims[_local2];
                _local3.complete.addOnce(this.onAnimComplete);
                _local3.play();
                _local2++;
            };
            this._anims.length = 0;
            this._count = 0;
        }
        private function onAnimComplete(_arg1:Anim):void{
            if (--this._waiting){
                return;
            };
            this._anims.length = 0;
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
