//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.assets.*;
    import flash.geom.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.*;

    public class DexUIDetailEffectiveness {

        private var mc:MovieClip;
        private var zodiac:ZodiacFactory;

        public function DexUIDetailEffectiveness(_arg1:MovieClip, _arg2:ZodiacFactory){
            this.mc = _arg1;
            this.zodiac = _arg2;
        }
        public function show(_arg1:DexMoga):void{
            var _local2:MogaEffectiveness = _arg1.effectiveness;
            this.showEffectiveness(this.mc.list_0, _local2.getZodiacs("0.33"));
            this.showEffectiveness(this.mc.list_1, _local2.getZodiacs("0.66"));
            this.showEffectiveness(this.mc.list_2, _local2.getZodiacs("1"));
            this.showEffectiveness(this.mc.list_3, _local2.getZodiacs("1.33"));
            this.showEffectiveness(this.mc.list_4, _local2.getZodiacs("1.66"));
        }
        private function showEffectiveness(_arg1:MovieClip, _arg2:Vector.<uint>):void{
            var _local5:String;
            var _local6:MovieClip;
            var _local7:Boolean;
            var _local8:MovieClip;
            var _local9:Bitmap;
            var _local10:ColorTransform;
            var _local3:uint = _arg2.length;
            var _local4:int;
            while (_local4 < 4) {
                _local5 = ("item_" + _local4);
                _local6 = (_arg1.getChildByName(_local5) as MovieClip);
                _local7 = (_local4 < _local3);
                _local6.visible = _local7;
                _local8 = _local6.symbol;
                if (_local8.numChildren){
                    (_local8.removeChildAt(0) as Bitmap).bitmapData.dispose();
                };
                if (_local7){
                    _local9 = this.zodiac.generate(_arg2[_local4], 14);
                    _local10 = new ColorTransform();
                    Color.setTransform(_local10, 4282763498);
                    _local9.transform.colorTransform = _local10;
                    _local8.addChild(_local9);
                };
                _local4++;
            };
        }
        public function cleanUp():void{
            var _local2:int;
            var _local3:MovieClip;
            var _local1:int;
            while (_local1 < 4) {
                _local2 = 0;
                while (_local2 < 4) {
                    _local3 = this.mc[("list_" + _local1)][("item_" + _local2)].symbol;
                    while (_local3.numChildren) {
                        _local3.removeChildAt(0);
                    };
                    _local2++;
                };
                _local1++;
            };
        }

    }
}//package gaia.moga.dex.view.ui 
