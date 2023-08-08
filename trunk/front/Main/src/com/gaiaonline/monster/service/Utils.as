//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import flash.display.*;
    import flash.geom.*;

    public class Utils {

        public static function randRange(_arg1:Number, _arg2:Number):Number{
            return ((Math.floor((Math.random() * ((_arg2 - _arg1) + 1))) + _arg1));
        }
        public static function formatTime(_arg1:int):String{
            var _local2 = "";
            var _local3:Number = _arg1;
            var _local4:Number = Math.floor((_local3 / 3600));
            _local3 = (_local3 - (_local4 * 3600));
            var _local5:Number = Math.floor((_local3 / 60));
            _local3 = (_local3 - (_local5 * 60));
            var _local6:Number = _local3;
            var _local7:String = _local6.toString();
            if (_local6 < 10){
                _local7 = ("0" + _local7);
            };
            var _local8:String = _local5.toString();
            if (_local5 < 10){
                _local8 = ("0" + _local8);
            };
            var _local9:String = _local4.toString();
            if (_local4 < 10){
                _local9 = ("0" + _local9);
            };
            _local2 = (_local2 + (_local9 + ": "));
            _local2 = (_local2 + (_local8 + ":"));
            _local2 = (_local2 + (_local7 + " "));
            return (_local2);
        }
        public static function createBitmapFromDisplayObject(_arg1:DisplayObject, _arg2:Number=0, _arg3:Number=0):Bitmap{
            var _local5:BitmapData;
            var _local6:Bitmap;
            var _local4:Matrix = new Matrix();
            if (_arg2 == 0){
                _arg2 = _arg1.width;
            };
            if (_arg3 == 0){
                _arg3 = _arg1.height;
            };
            _local4.scale((_arg2 / _arg1.width), (_arg3 / _arg1.height));
            _local5 = new BitmapData(_arg2, _arg3, true);
            _local5.draw(_arg1, _local4);
            _local6 = new Bitmap(_local5, "auto", true);
            return (_local6);
        }

    }
}//package com.gaiaonline.monster.service 
