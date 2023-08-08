//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib.gsi {
    import gaia.lib.gsi.*;

    class SushiSerializer {

        public static const encodeName:String = "sushi";
        private static const DELIMITER:String = "";
        private static const ARRAY_DELIMITER:String = "";
        private static const END:String = "";
        private static const SUSHI_TRUE:String = "";
        private static const SUSHI_FALSE:String = "";

        public static function serialize(_arg1:Array):String{
            var _local5:Array;
            var _local6:Array;
            var _local7:uint;
            var _local8:uint;
            var _local2:uint = _arg1.length;
            var _local3 = "";
            var _local4:uint;
            while (_local4 < _local2) {
                _local5 = _arg1[_local4];
                _local3 = (_local3 + _local5[0]);
                _local6 = _local5[1];
                _local7 = (_local6) ? _local6.length : 0;
                _local8 = 0;
                while (_local8 < _local7) {
                    if ((_local6[_local8] is Array)){
                        _local3 = (_local3 + (DELIMITER + _local6[_local8].join(ARRAY_DELIMITER)));
                    } else {
                        _local3 = (_local3 + (DELIMITER + String(_local6[_local8])));
                    };
                    _local8++;
                };
                _local3 = (_local3 + END);
                _local4++;
            };
            return (_local3);
        }
        public static function unserialize(_arg1:String):Array{
            var _local6:Array;
            var _local7:uint;
            var _local8:uint;
            _arg1 = unwhitespace(_arg1);
            var _local2:Array = _arg1.split(END);
            var _local3:uint = _local2.length;
            var _local4:Array = new Array();
            var _local5:int;
            while (_local5 < _local3) {
                _local6 = _local2[_local5].split(DELIMITER);
                _local7 = _local6.length;
                _local4[_local5] = new Array();
                _local4[_local5][0] = _local6[0];
                _local4[_local5][1] = ((_local6[1])==SUSHI_TRUE) ? true : false;
                _local4[_local5][2] = new Array();
                _local8 = 2;
                while (_local8 < _local7) {
                    if (_local6[_local8].indexOf(ARRAY_DELIMITER) != -1){
                        _local4[_local5][2].push(_local6[_local8].split(ARRAY_DELIMITER));
                    } else {
                        _local4[_local5][2].push(_local6[_local8]);
                    };
                    _local8++;
                };
                _local5++;
            };
            return (_local4);
        }
        public static function unwhitespace(_arg1:String){
            var _local4:Number;
            var _local5:Number;
            var _local2:Boolean;
            var _local3:Number = -1;
            var _local6:String = new String(_arg1);
            while (!(_local2)) {
                _local3++;
                if (_local6.charCodeAt(_local3) > 32){
                    _local2 = true;
                };
            };
            _local4 = _local3;
            _local3 = _local6.length;
            _local2 = false;
            while (!(_local2)) {
                _local3--;
                if (_local6.charCodeAt(_local3) > 32){
                    _local2 = true;
                };
            };
            _local5 = (_local3 + 1);
            return (((_local5)>_local4) ? _local6.substring(_local4, _local5) : "");
        }

    }
}//package gaia.lib.gsi 
