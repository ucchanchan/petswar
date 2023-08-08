//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.app.overlay {
    import flash.display.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class PanelStack extends Sprite {

        private var _panels:Vector.<Panel>;

        public function PanelStack(){
            this._panels = new Vector.<Panel>();
        }
        public function push(_arg1:Panel):void{
            if (this.promote(_arg1)){
                return;
            };
            this._panels.push(_arg1);
            addChild(_arg1);
            _arg1.setup();
        }
        public function promote(_arg1:Panel):Boolean{
            var _local2:int = this._panels.indexOf(_arg1);
            if (_local2 == -1){
                return (false);
            };
            this._panels.splice(_local2, 1);
            this._panels.push(_arg1);
            setChildIndex(_arg1, (this._panels.length - 1));
            return (true);
        }
        public function remove(_arg1:Panel):Boolean{
            var _local2:int = this._panels.indexOf(_arg1);
            if (_local2 == -1){
                return (false);
            };
            this._panels.splice(_local2, 1);
            if (_arg1.parent == this){
                removeChild(_arg1);
            };
            return (true);
        }
        public function pop():Panel{
            if (this._panels.length == 0){
                return (null);
            };
            var _local1:Panel = this._panels.pop();
            removeChild(_local1);
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.view.components.app.overlay 
