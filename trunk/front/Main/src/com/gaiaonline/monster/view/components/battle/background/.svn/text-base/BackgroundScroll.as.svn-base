//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.background {
    import flash.display.*;
    import com.gskinner.motion.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class BackgroundScroll {

        private var _proportion:Number;
        private var _complete:Signal;
        private var tween:GTween;
        private var layers:Vector.<BackgroundScrollLayer>;
        private var layerCount:uint;
        private var bindMap:Dictionary;
        private var binds:Vector.<BackgroundScrollBindVO>;
        private var bindCount:int;

        public function BackgroundScroll(){
            this._complete = new Signal();
            this._proportion = 0;
            this.layers = new Vector.<BackgroundScrollLayer>();
            this.layerCount = 0;
            this.tween = new GTween(this);
            this.tween.onComplete = this.onTweenComplete;
            this.bindMap = new Dictionary();
            this.binds = new Vector.<BackgroundScrollBindVO>();
            this.bindCount = 0;
        }
        public function addLayer(_arg1:BackgroundScrollLayer):void{
            var _local2 = this.layerCount++;
            this.layers[_local2] = _arg1;
        }
        public function getLayer(_arg1:uint):BackgroundScrollLayer{
            return (this.layers[_arg1]);
        }
        public function bindToLayer(_arg1:DisplayObject, _arg2:BackgroundScrollLayer, _arg3:Number):void{
            this.unbind(_arg1);
            var _local4:BackgroundScrollBindVO = new BackgroundScrollBindVO(_arg1, _arg2, _arg3);
            _local4.update();
            this.bindMap[_arg1] = _local4;
            this.binds.push(_local4);
            this.bindCount++;
        }
        public function unbind(_arg1:DisplayObject):void{
            var _local2:BackgroundScrollBindVO = this.bindMap[_arg1];
            if (!_local2){
                return;
            };
            delete this.bindMap[_arg1];
            this.binds.splice(this.binds.indexOf(_local2), 1);
            this.bindCount--;
        }
        public function goto(_arg1:Number, _arg2:Number, _arg3:Function=null, _arg4:Number=-1):void{
            var _local5:int;
            if (_arg4 != -1){
                _local5 = 0;
                while (_local5 < this.layerCount) {
                    this.layers[_local5].update(_arg4, false);
                    _local5++;
                };
            };
            this.tween.ease = _arg3;
            this.tween.duration = _arg2;
            this.tween.setValue("proportion", _arg1);
        }
        public function get proportion():Number{
            return (this._proportion);
        }
        public function set proportion(_arg1:Number):void{
            var _local2:int;
            this._proportion = _arg1;
            _local2 = 0;
            while (_local2 < this.layerCount) {
                this.layers[_local2].update(this._proportion, (this._proportion < 1));
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.bindCount) {
                this.binds[_local2].update();
                _local2++;
            };
        }
        public function get complete():Signal{
            return (this._complete);
        }
        private function onTweenComplete(_arg1:GTween):void{
            this._complete.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.background 
