//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data.attacks {
    import __AS3__.vec.*;
    import alecmce.async.*;
    import gaia.moga.data.parser.*;
    import alecmce.io.*;

    public class AttackData extends AsyncBase {

        private var _config:Data;
        private var _language:Data;
        private var _map:Object;
        private var _categories:Object;

        public function AttackData(_arg1:Data, _arg2:Data){
            this._config = _arg1;
            this._language = _arg2;
        }
        public function getData(_arg1:String):AttackDataVO{
            return ((this._map) ? this._map[_arg1] : null);
        }
        override protected function onInit():void{
            var _local1:AsyncStack = new AsyncStack("AttackData-Stack");
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
            this.parseLanguage(this._language.data);
            asyncComplete();
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            _arg1.complete.removeAll();
            asyncError(_arg2);
        }
        private function parseConfig(_arg1:String):void{
            var _local4:CategoryData;
            this._map = {};
            this._categories = {};
            var _local2:ParseData = new ParseData();
            var _local3:Vector.<CategoryData> = _local2.parse(_arg1);
            for each (_local4 in _local3) {
                this.mapCategory(_local4);
            };
        }
        private function mapCategory(_arg1:CategoryData):void{
            var _local2:Vector.<uint> = this.parseIDs(_arg1.map["IDS"]);
            var _local3:AttackCategoryDataVO = new AttackCategoryDataVO(_arg1.name);
            _local3.chargeAnim = _arg1.map["CHARGE"];
            _local3.attackAnim = _arg1.map["ANIM"];
            _local3.castAnim = _arg1.map["BUFF"];
            _local3.hitAnim = _arg1.map["HIT"];
            this._categories[_local3.name] = _local3;
            var _local4:uint = _local2.length;
            var _local5:int;
            while (_local5 < _local4) {
                this._map[_local2[_local5]] = new AttackDataVO(_local3, (_local5 + 1));
                _local5++;
            };
        }
        private function parseIDs(_arg1:String):Vector.<uint>{
            var _local4:String;
            var _local5:Array;
            var _local6:uint;
            var _local7:uint;
            if ((((_arg1 == null)) || ((_arg1 == "")))){
                return (Vector.<uint>([]));
            };
            var _local2:Vector.<uint> = new Vector.<uint>();
            var _local3:Array = _arg1.split(",");
            for each (_local4 in _local3) {
                if (_local4.indexOf(".") == -1){
                    _local2.push(uint(_local4));
                } else {
                    _local5 = _local4.match(/(\d+)..(\d+)/);
                    if (((!((_local5 == null))) && ((_local5.length > 1)))){
                        _local6 = _local5[2];
                        _local7 = _local5[1];
                        while (_local7 <= _local6) {
                            _local2.push(_local7);
                            _local7 = (_local7 + 2);
                        };
                    };
                };
            };
            return (_local2);
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
            var _local2:AttackCategoryDataVO = this._categories[_arg1.name];
            if (!_local2){
                return;
            };
            if (_arg1.map["NAME"]){
                _local2.name = _arg1.map["NAME"];
            };
            _local2.description = _arg1.map["DESCRIPTION"];
            _local2.hitText = _arg1.map["DAMAGE"];
            _local2.castText = _arg1.map["CAST"];
            _local2.criticalText = _arg1.map["CRITICAL"];
            _local2.missText = _arg1.map["MISS"];
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
}//package gaia.moga.data.attacks 
