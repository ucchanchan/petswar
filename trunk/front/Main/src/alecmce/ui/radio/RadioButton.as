//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.radio {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.button.*;

    public class RadioButton extends MovieClipButton {

        public var selectedFrame;
        private var _selected:Signal;
        private var _isSelected:Boolean;

        public function RadioButton(_arg1:MovieClip, _arg2=1, _arg3=2, _arg4=3, _arg5=4, _arg6=5){
            this.selectedFrame = _arg6;
            this._selected = new Signal(RadioButton);
            super(_arg1, _arg2, _arg3, _arg4, _arg5);
            clicked.add(this.onClicked);
        }
        private function onClicked(_arg1:MovieClipButton):void{
            if (isEnabled){
                this.isSelected = true;
            };
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
            if (this._isSelected){
                this._selected.dispatch(this);
            };
        }
        override public function set isEnabled(_arg1:Boolean):void{
            super.isEnabled = _arg1;
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        override public function update():void{
            if (this._isSelected){
                _ui.gotoAndStop(this.selectedFrame);
            } else {
                super.update();
            };
        }

    }
}//package alecmce.ui.radio 
