//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.sound {
    import gaia.lib.*;
    import gaia.moga.app.*;

    public class SoundService {

		[Inject]
        public var config:AppConfig;
        private var cookie:Cookie;
        private var _volume:Number;
        private var map:Object;

        private static const FX_VOLUME:String = "fx";

        public function SoundService(_arg1:Cookie){
            this.cookie = _arg1;
            this._volume = _arg1.getValue(FX_VOLUME, 1);
            this.map = {};
        }
        public function get volume():Number{
            return (this._volume);
        }
        public function set volume(_arg1:Number):void{
            _arg1 = ((_arg1 < 0)) ? 0 : ((_arg1 > 1)) ? 1 : _arg1;
            if (this._volume == _arg1){
                return;
            };
            this._volume = _arg1;
            this.updateVolume(_arg1);
            this.cookie.setValue(FX_VOLUME, _arg1);
        }
        public function getFX(_arg1:String, _arg2:Boolean=false):SoundProxy{
            return (this.getSound(_arg1, this.map, this._volume, _arg2));
        }
        private function getSound(_arg1:String, _arg2:Object, _arg3:Number, _arg4:Boolean=false):SoundProxy{
            var _local7:String;
            var _local5:SoundWrapper = _arg2[_arg1];
            if (!_local5){
                _local5 = new SoundWrapper(_arg1, _arg3);
                _arg2[_arg1] = _local5;
                _local7 = this.config.parseURL(_arg1);
                _local5.load(_local7);
                _local5.disposable.addOnce(this.onSoundDisposed);
            };
            var _local6:SoundProxy = new SoundProxy();
            _local6.inject(_local5, _arg4);
            if (_local6.loop){
                _local6.endOfStream.add(this.onEndOfStream);
            };
            _local5.proxies++;
            return (_local6);
        }
        private function onEndOfStream(_arg1:SoundProxy):void{
            _arg1.play();
        }
        private function onSoundDisposed(_arg1:SoundWrapper):void{
            var _local2:String = _arg1.id;
            delete this.map[_local2];
            _arg1.close();
        }
        private function updateVolume(_arg1:Number):void{
            var _local2:SoundWrapper;
            for each (_local2 in this.map) {
                _local2.volume = _arg1;
            };
        }

    }
}//package com.gaiaonline.monster.service.sound 
