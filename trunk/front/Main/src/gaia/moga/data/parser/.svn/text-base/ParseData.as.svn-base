//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data.parser {
    import __AS3__.vec.*;

    public class ParseData {

        private static const IGNORED:String = "IGNORED";

        public function parse(_arg1:String):Vector.<CategoryData>{
            var _local2:Vector.<String> = this.parseLines(_arg1);
            return (this.parseCategories(_local2));
        }
        private function parseLines(_arg1:String):Vector.<String>{
            var _local4:String;
            var _local5:int;
            var _local6:Array;
            var _local2:Vector.<String> = Vector.<String>(_arg1.split(/\R/));
            var _local3:int = _local2.length;
            while (_local3--) {
                _local4 = _local2[_local3];
                _local5 = _local4.indexOf("#");
                if (_local5 != -1){
                    _local4 = _local4.substr(0, _local5);
                };
                _local6 = _local4.match(/\s*+(.+)\s*+$/);
                if (((!(_local6)) || ((_local6.length == 0)))){
                    _local2.splice(_local3, 1);
                } else {
                    _local2[_local3] = _local6[1];
                };
            };
            return (_local2);
        }
        private function parseCategories(_arg1:Vector.<String>):Vector.<CategoryData>{
            var _local7:String;
            var _local8:Array;
            var _local2:Vector.<CategoryData> = new Vector.<CategoryData>();
            var _local3:int = _arg1.length;
            var _local4:String = IGNORED;
            var _local5:Vector.<String> = new Vector.<String>();
            var _local6:int;
            while (_local6 < _local3) {
                _local7 = _arg1[_local6];
                _local8 = _local7.match(/\[(.+)\]/);
                if (((!(_local8)) || ((_local8.length == 0)))){
                    _local5.push(_local7);
                } else {
                    if (_local4 != IGNORED){
                        _local2.push(this.parseCategory(_local4, _local5));
                    };
                    _local4 = _local8[1];
                    _local5.length = 0;
                };
                _local6++;
            };
            if (_local4 != IGNORED){
                _local2.push(this.parseCategory(_local4, _local5));
            };
            return (_local2);
        }
        private function parseCategory(_arg1:String, _arg2:Vector.<String>):CategoryData{
            var _local6:String;
            var _local3 = "";
            var _local4:Array = _arg1.match(/(\S+) - (.+)\s*+/);
            if (((!((_local4 == null))) && ((_local4.length > 1)))){
                _arg1 = _local4[1];
                _local3 = _local4[2];
            };
            var _local5:CategoryData = new CategoryData(_arg1, _local3);
            for each (_local6 in _arg2) {
                _local4 = _local6.match(/(\S+)\s*+(.+\S)\s*+/);
                if (((!((_local4 == null))) && ((_local4.length > 1)))){
                    _local5.map[_local4[1]] = _local4[2];
                };
            };
            return (_local5);
        }

    }
}//package gaia.moga.data.parser 
