//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.async.*;
    import flash.net.*;
    import flash.media.*;

    public class MusicProxy extends AsyncBase {

        private var _url:String;
        private var _preloadBytes:int;
        private var _volume:Number;
        private var _playing:Signal;
        private var _endOfStream:Signal;
        private var sound:Sound;
        private var transform:SoundTransform;
        private var channel:SoundChannel;
        private var _loop:Boolean;

        public function MusicProxy(_arg1:String, _arg2:Number, _arg3:int, _arg4:Boolean){
            this._url = _arg1;
            this._volume = _arg2;
            this._preloadBytes = _arg3;
            this._loop = _arg4;
            this._playing = new Signal(MusicProxy);
            this._endOfStream = new Signal(MusicProxy, Boolean);
        }
        public function get playing():ISignal{
            return (this._playing);
        }
        override protected function onInit():void{
            var _local1:URLRequest = new URLRequest(this.url);
            this.sound = new Sound();
            this.sound.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.sound.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.sound.addEventListener(Event.COMPLETE, this.onLoadComplete);
            this.sound.load(_local1);
        }
        private function onProgress(_arg1:ProgressEvent):void{
            if ((((_arg1.bytesLoaded < this._preloadBytes)) && ((_arg1.bytesTotal > this._preloadBytes)))){
                return;
            };
            this.sound.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            asyncComplete();
        }
        public function play():void{
            init();
            this._playing.dispatch(this);
            if (isComplete){
                this.playOnComplete(this);
            } else {
                complete.addOnce(this.playOnComplete);
            };
        }
        private function playOnComplete(_arg1:MusicProxy):void{
            var _local2 = (this.sound == null);
            if (!_local2){
                if (this.channel){
                    this.channel.stop();
                };
                this.channel = this.sound.play();
                if (!this.channel){
                    _local2 = true;
                };
            };
            if (_local2){
                this._loop = false;
                this.onSoundComplete(null);
                return;
            };
            this.transform = new SoundTransform(this._volume);
            this.channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
            this.channel.soundTransform = this.transform;
        }
        public function stop():void{
            if (!this.channel){
                return;
            };
            this.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
            this.channel.stop();
            this.channel = null;
            this.transform = null;
        }
        override public function dispose(_arg1:Boolean=true):void{
            var gc = _arg1;
            this.stop();
            this._endOfStream.removeAll();
            super.dispose(gc);
            if (!this.sound){
                return;
            };
            try {
                this.sound.close();
            } catch(error:Error) {
            };
            this.removeListeners();
            this.sound = null;
        }
        public function get endOfStream():ISignal{
            return (this._endOfStream);
        }
        override public function get name():String{
            return (("MusicProxy " + this._url));
        }
        public function get url():String{
            return (this._url);
        }
        private function onSoundComplete(_arg1:Event):void{
            this.stop();
            this._endOfStream.dispatch(this, !((_arg1 == null)));
        }
        private function onLoadComplete(_arg1:Event):void{
            this.removeListeners();
            asyncComplete();
        }
        private function onIOError(_arg1:IOErrorEvent):void{
            this.removeListeners();
            this.sound = null;
            asyncError(("Sound not found: " + this.url));
        }
        private function removeListeners():void{
            this.sound.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.sound.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.sound.removeEventListener(Event.COMPLETE, this.onLoadComplete);
        }
        public function get volume():Number{
            return (this._volume);
        }
        public function set volume(_arg1:Number):void{
            this._volume = _arg1;
            if (!this.channel){
                return;
            };
            this.transform.volume = _arg1;
            this.channel.soundTransform = this.transform;
        }
        public function get loop():Boolean{
            return (this._loop);
        }

    }
}//package com.gaiaonline.monster.service.sound 
