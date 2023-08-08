//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import com.gskinner.motion.*;
    import alecmce.async.*;

    public class CrossFade extends AsyncBase {

        public var fader:Number;
        public var volume:Number;
        public var outgoing:MusicProxy;
        public var incoming:MusicProxy;
        private var _tween:GTween;

        private static const DURATION:Number = 2;

        public function CrossFade(_arg1:MusicProxy, _arg2:MusicProxy, _arg3:Number){
            this.fader = 0;
            this.volume = _arg3;
            this.incoming = _arg2;
            this.outgoing = _arg1;
        }
        override protected function onInit():void{
            if (((this.incoming) && (this.outgoing))){
                this._tween = new GTween(this, DURATION, {fader:1}, {onChange:this.changeFade, onComplete:this.completeListener});
            } else {
                if (this.incoming){
                    this.incoming.volume = 1;
                };
                asyncComplete();
            };
        }
        public function finalize():void{
            if (this._tween){
                this._tween.onChange = null;
                this._tween.onComplete = null;
                this._tween.paused = true;
            };
            this.fader = 1;
            if (this.outgoing){
                this.outgoing.volume = 0;
            };
            this.completeListener(this._tween);
        }
        private function changeFade(_arg1:GTween):void{
            this.incoming.volume = (this.fader * this.volume);
            this.outgoing.volume = ((1 - this.fader) * this.volume);
        }
        private function completeListener(_arg1:GTween):void{
            this._tween = null;
            asyncComplete();
        }
        override public function get name():String{
            return ("CrossFade");
        }

    }
}//package com.gaiaonline.monster.service.sound 
