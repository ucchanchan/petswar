//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import flash.display.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.background.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gskinner.motion.easing.*;

    public class ScrollBackgroundAnim implements Anim {

        private var _complete:AnimSignal;
        private var _background:Background;
        private var _parallax:BackgroundScroll;
        private var _bound:Vector.<DisplayObject>;

        private static const WIDTH:int = 760;
        private static const PROPORTION:Number = 1;

        public function ScrollBackgroundAnim(_arg1:Background, _arg2:BackgroundScroll, _arg3:Vector.<DisplayObject>=null){
            this._complete = new AnimSignal();
            this._background = _arg1;
            this._parallax = _arg2;
            this._bound = (_arg3) ? _arg3 : new Vector.<DisplayObject>(0, true);
        }
        public function play():void{
            this.prepBackground();
            var _local1:BackgroundScrollLayer = this._parallax.getLayer(1);
            var _local2:uint = this._bound.length;
            var _local3:int;
            while (_local3 < _local2) {
                this._parallax.bindToLayer(this._bound[_local3], _local1, ((_local1.left + ((_local1.right - _local1.left) * PROPORTION)) + this._bound[_local3].x));
                this._bound[_local3].visible = true;
                _local3++;
            };
            this._parallax.complete.addOnce(this.onParallaxComplete);
            this._parallax.goto(PROPORTION, 1, Quadratic.easeOut);
        }
        private function prepBackground():void{
            var _local1:Rectangle;
            var _local2:DisplayObject;
            var _local3:BackgroundScrollLayer;
            var _local4:int;
            while (_local4 < 3) {
                _local3 = this._parallax.getLayer(_local4);
                _local2 = _local3.target;
                _local1 = _local2.getRect(_local2);
                _local3.setRange(_local1.left, (_local1.right - WIDTH));
                _local4++;
            };
        }
        private function onParallaxComplete():void{
            var _local1:uint = this._bound.length;
            var _local2:int;
            while (_local2 < _local1) {
                this._parallax.unbind(this._bound[_local2]);
                _local2++;
            };
            this._bound = null;
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
