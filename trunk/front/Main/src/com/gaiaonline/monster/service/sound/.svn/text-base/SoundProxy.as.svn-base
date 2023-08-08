//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import flash.events.*;
    import org.osflash.signals.*;
    import flash.media.*;

    public class SoundProxy {

        var sound:SoundWrapper;
        private var channel:SoundChannel;
        private var transform:SoundTransform;
        private var _disposed:Signal;
        private var _loop:Boolean;
        private var _endOfStream:Signal;

        function inject(_arg1:SoundWrapper, _arg2:Boolean):void{
            this.sound = _arg1;
            this._loop = _arg2;
            this._endOfStream = new Signal(SoundProxy);
            this._disposed = new Signal(SoundProxy);
        }
        public function play():void{
            if (((!(this.sound)) || (this.sound.isError))){
                return;
            };
            if (this.sound.isComplete){
                this.playNow(this.sound);
            } else {
                this.sound.complete.addOnce(this.playNow);
            };
        }
        private function playNow(_arg1:SoundWrapper):void{
            this.channel = _arg1.sound.play();
            if (!this.channel){
                return;
            };
            this.transform = new SoundTransform(_arg1.volume);
            _arg1.volumeChanged.add(this.onVolumeChanged);
            this.channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
            this.channel.soundTransform = this.transform;
        }
        private function onVolumeChanged(_arg1:Number):void{
            if (this.transform){
                this.transform.volume = _arg1;
                this.channel.soundTransform = this.transform;
            } else {
                this.sound.volumeChanged.remove(this.onVolumeChanged);
            };
        }
        private function onSoundComplete(_arg1:Event=null):void{
            if (this.sound){
                this.sound.volumeChanged.remove(this.onVolumeChanged);
            };
            if (this.channel){
                this.channel.stop();
                this.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
            };
            this.channel = null;
            this.transform = null;
            if (this._loop){
                this._endOfStream.dispatch(this);
            };
        }
        public function dispose():void{
            if (this.channel){
                this.onSoundComplete();
            };
            if (((this.sound) && ((--this.sound.proxies == 0)))){
                this.sound.disposable.dispatch(this.sound);
            };
            this._disposed.dispatch(this);
            this.sound = null;
        }
        public function get disposed():ISignal{
            return (this._disposed);
        }
        public function get loop():Boolean{
            return (this._loop);
        }
        public function get endOfStream():Signal{
            return (this._endOfStream);
        }

    }
}//package com.gaiaonline.monster.service.sound 
