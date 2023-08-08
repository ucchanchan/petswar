//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import alecmce.ui.button.*;

    public class DexUIToken extends MovieClipButton {

        private var _isSelected:Boolean;
        private var _baseIndex:uint;
        private var _topIndex:uint;

        public function DexUIToken(_arg1:MovieClip){
            super(_arg1, 2, 1, 1, 2);
            this._baseIndex = _arg1.parent.getChildIndex(_arg1);
            this._topIndex = (_arg1.parent.numChildren - 1);
        }
        public function get isSelected():Boolean{
            return (this._isSelected);
        }
        public function set isSelected(_arg1:Boolean):void{
            if (this._isSelected == _arg1){
                return;
            };
            this._isSelected = _arg1;
            this.update();
        }
        override public function update():void{
            if (this._isSelected){
                ui.gotoAndPlay(5);
            } else {
                super.update();
            };
            ui.parent.setChildIndex(ui, (((this._isSelected) || (isOver))) ? this._topIndex : this._baseIndex);
        }

    }
}//package gaia.moga.dex.view.ui 
