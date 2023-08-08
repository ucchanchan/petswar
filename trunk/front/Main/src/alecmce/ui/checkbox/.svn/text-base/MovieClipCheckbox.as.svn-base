//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.checkbox {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;

    public class MovieClipCheckbox implements Checkbox {

        protected var _ui:MovieClip;
        private var _isSelected:Boolean;
        private var _clicked:Signal;
        private var _isVisible:Boolean;
        private var _isEnabled:Boolean;
        public var falseFrame;// = 1
        public var trueFrame;// = 2

        public function MovieClipCheckbox(_arg1:MovieClip, _arg2:Boolean=false){
            this._ui = _arg1;
            this._clicked = new Signal(MovieClipCheckbox, Boolean);
            this._isEnabled = true;
            this._isVisible = true;
            this._isSelected = _arg2;
            if (this._ui){
                this._ui.buttonMode = true;
                this._ui.mouseChildren = false;
                this._ui.mouseEnabled = true;
            };
            this.addEventListeners();
            this.update();
        }
        public function get ui():MovieClip{
            return (this._ui);
        }
        public function get isSelected():Boolean{
            return (this._isSelected);
        }
        public function set isSelected(_arg1:Boolean):void{
            if (this._isSelected == _arg1){
                return;
            };
            this._isSelected = _arg1;
            this._clicked.dispatch(this, this._isSelected);
        }
        public function get isVisible():Boolean{
            return (false);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (this._isVisible == _arg1){
                return;
            };
            this._isVisible = _arg1;
            this._ui.visible = _arg1;
            if (((this._isEnabled) && (this._isVisible))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
            this.update();
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            if (((this._isEnabled) && (this._isVisible))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
            this.update();
        }
        public function update():void{
            this._ui.gotoAndStop((this._isSelected) ? this.trueFrame : this.falseFrame);
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }
        private function addEventListeners():void{
            this._ui.addEventListener(MouseEvent.CLICK, this.onClick);
            this._ui.useHandCursor = true;
        }
        private function removeEventListeners():void{
            this._ui.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._ui.useHandCursor = false;
        }
        private function onClick(_arg1:MouseEvent):void{
            this._isSelected = !(this._isSelected);
            this.update();
            this._clicked.dispatch(this, this._isSelected);
        }
        public function assert(_arg1:Boolean):void{
            this._isSelected = _arg1;
            this.update();
        }

    }
}//package alecmce.ui.checkbox 
