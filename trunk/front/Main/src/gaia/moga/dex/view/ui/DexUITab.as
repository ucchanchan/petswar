//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import alecmce.ui.button.*;

    public class DexUITab extends MovieClipButton {

        private var _label:String;
        private var selectedFrame;
        private var _isSelected:Boolean;

        public function DexUITab(_arg1:MovieClip){
            super(_arg1, 2, 1, 1, 3);
            isVisible = false;
            this.selectedFrame = 1;
        }
        public function set label(_arg1:String):void{
            this._label = _arg1;
            _ui.label.label.text = _arg1;
            isVisible = !((_arg1 == ""));
        }
        public function get label():String{
            return (this._label);
        }
        public function get isSelected():Boolean{
            return (this._isSelected);
        }
        public function set isSelected(_arg1:Boolean):void{
            this._isSelected = _arg1;
            this.update();
        }
        override public function update():void{
            if (this._isSelected){
                _ui.gotoAndStop(this.selectedFrame);
            } else {
                super.update();
            };
        }

    }
}//package gaia.moga.dex.view.ui 
