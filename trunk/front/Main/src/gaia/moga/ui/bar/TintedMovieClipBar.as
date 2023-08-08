//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.ui.bar {
    import flash.display.*;
    import com.gskinner.motion.*;

    public class TintedMovieClipBar extends MovieClipBar {

        private var _colorFn:Function;
        private var _tinted:MovieClip;

        public function TintedMovieClipBar(_arg1:MovieClip, _arg2:MovieClip, _arg3:Function){
            super(_arg1);
            this._tinted = _arg2;
            this._colorFn = _arg3;
            if (this._colorFn == null){
                return;
            };
            var _local4:uint = this._colorFn(_proportion);
            new GTween(this._tinted, 0.001, {tint:_local4});
        }
        override public function set value(_arg1:Number):void{
            super.value = _arg1;
            if (this._colorFn == null){
                return;
            };
            var _local2:uint = this._colorFn(_proportion);
            new GTween(this._tinted, TIME, {tint:_local2});
        }

    }
}//package gaia.moga.ui.bar 
