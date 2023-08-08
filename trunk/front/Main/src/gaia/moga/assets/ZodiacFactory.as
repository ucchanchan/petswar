//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import flash.display.*;
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import flash.geom.*;

    public class ZodiacFactory {

        private var assets:AssetService;
        private var model:ZodiacModel;
        private var map:Object;

        public function ZodiacFactory(_arg1:AssetService, _arg2:ZodiacModel){
            this.assets = _arg1;
            this.model = _arg2;
            this.map = {};
            this.init();
        }
        private function init():void{
            var _local2:ZodiacVO;
            var _local3:uint;
            var _local4:String;
            var _local5:Asset;
            var _local1:Vector.<ZodiacVO> = this.model.zodiacs;
            for each (_local2 in _local1) {
                _local3 = _local2.id;
                _local4 = (("assets/horoscope/" + _local3) + ".swf");
                _local5 = this.assets.createWrapper(_local4);
                _local5.init();
                this.map[_local3] = _local5;
            };
        }
        public function generate(_arg1:uint, _arg2:uint):Bitmap{
            var _local3:DisplayObject = (this.map[_arg1] as Asset).self;
            var _local4:Rectangle = _local3.getRect(_local3);
            var _local5:Number = Math.sqrt(((_local4.width * _local4.width) + (_local4.height * _local4.height)));
            var _local6:Number = (_arg2 * 2);
            var _local7:Number = (_local6 / _local5);
            var _local8:BitmapData = new BitmapData(_local4.width, _local4.height, true, 0);
            var _local9:Matrix = new Matrix(_local7, 0, 0, _local7, (-(_local4.left) * _local7), (-(_local4.top) * _local7));
            _local8.draw(_local3, _local9, null, null, null, true);
            var _local10:Bitmap = new Bitmap(_local8);
            _local10.x = ((-(_local4.width) * _local7) * 0.5);
            _local10.y = ((-(_local4.height) * _local7) * 0.5);
            return (_local10);
        }

    }
}//package gaia.moga.assets 
