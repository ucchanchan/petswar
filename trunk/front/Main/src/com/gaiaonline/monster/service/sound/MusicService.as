//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import __AS3__.vec.*;
    import alecmce.async.*;
    import gaia.lib.*;
    import gaia.moga.app.*;

    public class MusicService {

        private var _config:AppConfig;
        private var _cookie:Cookie;
        private var _volume:Number;
        private var _current:MusicProxy;
        private var _stack:Vector.<MusicProxy>;
        private var _fade:CrossFade;

        private static const MUSIC_VOLUME:String = "MUSIC_VOLUME";
        private static const PRELOAD_BYTES:int = 100000;

        public function MusicService(_arg1:Cookie, _arg2:AppConfig){
            this._cookie = _arg1;
            this._config = _arg2;
            this._volume = _arg1.getValue(MUSIC_VOLUME, 1);
            this._stack = new Vector.<MusicProxy>();
        }
        public function get current():MusicProxy{
            return (this._current);
        }
        public function loadAndPlay(_arg1:String, _arg2:Boolean=true):MusicProxy{
            var _local3:MusicProxy = this.load(_arg1, _arg2);
            _local3.play();
            return (_local3);
        }
        public function load(_arg1:String, _arg2:Boolean=true):MusicProxy{
            _arg1 = this._config.parseURL(_arg1);
            var _local3:MusicProxy = new MusicProxy(_arg1, this._volume, PRELOAD_BYTES, _arg2);
            _local3.playing.add(this.onProxyPlaying);
            _local3.init();
            return (_local3);
        }
        private function onProxyPlaying(_arg1:MusicProxy):void{
            if (_arg1.loop){
                _arg1.endOfStream.add(this.onEndOfStream);
            };
            if (((this._current) && (!((this._current == _arg1))))){
                this.crossFade(this._current, _arg1);
            };
            this._current = _arg1;
        }
        public function push(_arg1:String, _arg2:Boolean=true):MusicProxy{
            var _local3:MusicProxy = this._current;
            this.loadAndPlay(_arg1, _arg2);
            if (_local3){
                this._stack.push(_local3);
            };
            return (this._current);
        }
        public function pop():MusicProxy{
            if (this._stack.length > 0){
                this._stack.pop().play();
            };
            return (this._current);
        }
        private function onEndOfStream(_arg1:MusicProxy, _arg2:Boolean):void{
            if (_arg2){
                _arg1.play();
            };
        }
        private function crossFade(_arg1:MusicProxy, _arg2:MusicProxy):void{
            if (this._fade){
                this._fade.finalize();
            };
            this._fade = new CrossFade(_arg1, _arg2, this._volume);
            this._fade.complete.addOnce(this.onCrossFadeComplete);
            if (_arg2.isComplete){
                this.playCrossfade(_arg2);
            } else {
                _arg2.complete.addOnce(this.playCrossfade);
            };
        }
        private function playCrossfade(_arg1:Async):void{
            this._fade.init();
        }
        private function onCrossFadeComplete(_arg1:Async):void{
            this._fade.outgoing.dispose();
            this._fade = null;
        }
        public function stop():void{
            if (this._current){
                this._current.endOfStream.remove(this.onEndOfStream);
                this._current.stop();
                this._current = null;
            };
        }
        public function get volume():Number{
            return (this._volume);
        }
        public function set volume(_arg1:Number):void{
            _arg1 = ((_arg1 < 0)) ? 0 : ((_arg1 > 1)) ? 1 : _arg1;
            this._volume = _arg1;
            this._cookie.setValue(MUSIC_VOLUME, _arg1);
            if (this._current){
                this._current.volume = _arg1;
            };
            if (this._fade){
                this._fade.volume = _arg1;
            };
        }

    }
}//package com.gaiaonline.monster.service.sound 
