//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {
    import __AS3__.vec.*;

    public class AutoAnimStack implements Anim {

        protected var _anims:Vector.<Anim>;
        protected var _current:Anim;
        protected var _complete:AnimSignal;

        public function AutoAnimStack(){
            this._anims = new Vector.<Anim>();
            this._complete = new AnimSignal();
        }
        public function push(_arg1:Anim):void{
            this._anims.push(_arg1);
            if (this._current == null){
                this.play();
            };
        }
        public function play():void{
            if (this._current){
                return;
            };
            if (this._anims.length){
                this._current = this._anims.shift();
                this._current.complete.addOnce(this.onAnimComplete);
                this._current.play();
            } else {
                this._complete.dispatch(this);
            };
        }
        private function onAnimComplete(_arg1:Anim):void{
            this._current = null;
            this.play();
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
