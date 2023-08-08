//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import alecmce.ui.*;

    public class DexUIBottomLeft extends Sprite {

        private var ui:Asset;
        private var _isLocked:Boolean;

        public function DexUIBottomLeft(_arg1:Asset){
            this.ui = _arg1;
            addChild(_arg1.self);
            this.isLocked = false;
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            this._isLocked = _arg1;
            this.ui.self.visible = _arg1;
        }

    }
}//package gaia.moga.dex.view.ui 
