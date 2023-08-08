//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data.locations {
    import __AS3__.vec.*;
    import alecmce.async.*;
    import gaia.moga.data.parser.*;
    import alecmce.io.*;

    public class LocationData extends AsyncBase {

        private var _config:Data;
        private var _language:Data;
        private var _map:Object;

        public function LocationData(_arg1:Data, _arg2:Data=null){
            this._config = _arg1;
            this._language = _arg2;
        }
        public function getData(_arg1:uint):LocationDataVO{
            return ((this._map) ? this._map[_arg1] : null);
        }
        override protected function onInit():void{
            var _local1:AsyncStack = new AsyncStack("LocationData-Stack");
            _local1.push(this._config);
            _local1.push(this._language);
            if (_local1.isComplete){
                this.onComplete(_local1);
            } else {
                if (_local1.isError){
                    this.onError(_local1, "Unable to parse data bundle");
                } else {
                    _local1.complete.addOnce(this.onComplete);
                    _local1.error.addOnce(this.onError);
                    _local1.init();
                };
            };
        }
        private function onComplete(_arg1:Async):void{
            _arg1.error.removeAll();
            this.parseConfig(this._config.data);
            if (this._language){
                this.parseLanguage(this._language.data);
            };
            asyncComplete();
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            _arg1.complete.removeAll();
            asyncError(_arg2);
        }
        private function parseConfig(_arg1:String):void{
            var _local4:CategoryData;
            this._map = {};
            var _local2:ParseData = new ParseData();
            var _local3:Vector.<CategoryData> = _local2.parse(_arg1);
            for each (_local4 in _local3) {
                this.mapCategory(_local4);
            };
        }
        private function mapCategory(_arg1:CategoryData):void{
            var _local2:uint = uint(_arg1.name);
            var _local3:LocationDataVO = new LocationDataVO(_local2);
            _local3.music = _arg1.map.MUSIC;
            _local3.storyMusic = _arg1.map.STORY_MUSIC;
            this._map[_local2] = _local3;
        }
        private function parseLanguage(_arg1:String):void{
            var _local4:CategoryData;
            var _local2:ParseData = new ParseData();
            var _local3:Vector.<CategoryData> = _local2.parse(_arg1);
            for each (_local4 in _local3) {
                this.addLanguage(_local4);
            };
        }
        private function addLanguage(_arg1:CategoryData):void{
            var _local2:uint = uint(_arg1.name);
            var _local3:LocationDataVO = this._map[_local2];
            if (!_local3){
                return;
            };
            if (_arg1.map.NAME){
                _local3.name = _arg1.map.NAME;
            };
            if (_arg1.map.DESCRIPTION){
                _local3.description = _arg1.map.DESCRIPTION;
            };
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._map = null;
            if (this._config){
                this._config.dispose(_arg1);
                this._config = null;
            };
            if (this._language){
                this._language.dispose();
                this._language = null;
            };
        }

    }
}//package gaia.moga.data.locations 
