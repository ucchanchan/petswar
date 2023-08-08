//Created by Action Script Viewer - http://www.buraks.com/asv
package com.adobe.utils {

    public class ArrayUtil {

        public static function arraysAreEqual(_arg1:Array, _arg2:Array):Boolean{
            if (_arg1.length != _arg2.length){
                return (false);
            };
            var _local3:Number = _arg1.length;
            var _local4:Number = 0;
            while (_local4 < _local3) {
                if (_arg1[_local4] !== _arg2[_local4]){
                    return (false);
                };
                _local4++;
            };
            return (true);
        }
        public static function arrayContainsValue(_arg1:Array, _arg2:Object):Boolean{
            return (!((_arg1.indexOf(_arg2) == -1)));
        }
        public static function copyArray(_arg1:Array):Array{
            return (_arg1.slice());
        }
        public static function removeValueFromArray(_arg1:Array, _arg2:Object):void{
            var _local3:uint = _arg1.length;
            var _local4:Number = _local3;
            while (_local4 > -1) {
                if (_arg1[_local4] === _arg2){
                    _arg1.splice(_local4, 1);
                };
                _local4--;
            };
        }
        public static function createUniqueCopy(_arg1:Array):Array{
            var _local4:Object;
            var _local2:Array = new Array();
            var _local3:Number = _arg1.length;
            var _local5:uint;
            while (_local5 < _local3) {
                _local4 = _arg1[_local5];
                if (ArrayUtil.arrayContainsValue(_local2, _local4)){
                } else {
                    _local2.push(_local4);
                };
                _local5++;
            };
            return (_local2);
        }

    }
}//package com.adobe.utils 
