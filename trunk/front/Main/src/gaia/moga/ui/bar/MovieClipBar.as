//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.ui.bar {
    import flash.display.*;
    import com.gskinner.motion.*;

    public class MovieClipBar {

        protected var _bar:MovieClip;
        protected var _width:Number;
        protected var _value:Number;
        protected var _proportion:Number;
        protected var _min:Number;
        protected var _max:Number;
        protected var _step:Number;
        protected var _range:Number;
        protected var _invrange:Number;
        protected var _initialXPos:Number;
        private var tween:GTween;

        public static const TIME:Number = 1;

        public function MovieClipBar(_arg1:MovieClip){
            this._bar = _arg1;
            this._width = this._bar.getRect(this._bar).width;
            this._initialXPos = _arg1.x;
            this._value = 0;
            this._min = 0;
            this._max = 1;
            this._step = 0;
            this.tween = new GTween(this._bar, 1);
            this._range = (this.max - this.min);
            this._invrange = (1 / this._range);
            this._proportion = this.assertValue(this._value);
            this._bar.x = (this._width * (this._proportion - 1));
            this._bar.x = -(this._width);
        }
        public function get bar():MovieClip{
            return (this._bar);
        }
        public function get value():Number{
            return (this._value);
        }
        public function get min():Number{
            return (this._min);
        }
        public function get max():Number{
            return (this._max);
        }
        public function get step():Number{
            return (this._step);
        }
        public function setBounds(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=0):void{
            this._min = _arg2;
            this._max = _arg3;
            this._range = (_arg3 - _arg2);
            this._invrange = (1 / this._range);
            this._step = _arg4;
            this.value = _arg1;
        }
        public function set value(_arg1:Number):void{
            this._proportion = this.assertValue(_arg1);
            this.tween.setValue("x", ((this._width * (this._proportion - 1)) + this._initialXPos));
        }
        private function assertValue(_arg1:Number):Number{
            var _local3:Number;
            if (_arg1 < this._min){
                _arg1 = this._min;
            } else {
                if (_arg1 > this._max){
                    _arg1 = this._max;
                };
            };
            var _local2:Number = (_arg1 - this._min);
            if (this._step != 0){
                _local3 = (_local2 / this._step);
                _arg1 = (this._min + (this._step * Math.round(_local3)));
                _local2 = (_arg1 - this._min);
            };
            _local2 = (_local2 * this._invrange);
            if (this._value == _arg1){
                return (_local2);
            };
            this._value = _arg1;
            return (_local2);
        }
        public function get proportion():Number{
            return (this._proportion);
        }

    }
}//package gaia.moga.ui.bar 
