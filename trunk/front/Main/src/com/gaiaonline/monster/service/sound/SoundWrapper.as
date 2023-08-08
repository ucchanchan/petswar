//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.async.*;
    import flash.net.*;
    import flash.media.*;

    class SoundWrapper extends AsyncBase {

        public var id:String;
        public var sound:Sound;
        private var _volume:Number;
        public var volumeChanged:Signal;
        public var proxies:int;
        public var disposable:Signal;

        function SoundWrapper(_arg1:String, _arg2:Number){
            this.id = _arg1;
            this._volume = _arg2;
            this.volumeChanged = new Signal(Number);
            this.proxies = 0;
            this.disposable = new Signal(SoundWrapper);
        }
        public function load(_arg1:String):void{
            this.sound = new Sound();
            this.sound.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.sound.addEventListener(Event.COMPLETE, this.onLoadComplete);
            this.sound.load(new URLRequest(_arg1));
        }
        public function close():void{
            if (!this.sound){
                return;
            };
            this.removeListeners();
            try {
                this.sound.close();
            } catch(error:Error) {
            };
            this.sound = null;
        }
        private function onLoadComplete(_arg1:Event):void{
            this.removeListeners();
            asyncComplete();
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            this.removeListeners();
            this.sound = null;
            asyncError(("Sound not found: " + this.id));
        }
        private function removeListeners():void{
            this.sound.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.sound.removeEventListener(Event.COMPLETE, this.onLoadComplete);
        }
        public function get volume():Number{
            return (this._volume);
        }
        public function set volume(_arg1:Number):void{
            this._volume = _arg1;
            this.volumeChanged.dispatch(this._volume);
        }
        override public function get name():String{
            return ((("[SOUND " + this.id) + "]"));
        }

    }
}//package com.gaiaonline.monster.service.sound 
