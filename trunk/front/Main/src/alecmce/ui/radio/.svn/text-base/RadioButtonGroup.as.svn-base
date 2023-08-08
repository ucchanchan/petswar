//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.radio {
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class RadioButtonGroup {

        private var group:Vector.<RadioButton>;
        private var _current:RadioButton;
        private var _deselected:Signal;
        private var _selected:Signal;

        public function RadioButtonGroup(){
            this.group = new Vector.<RadioButton>();
            this._deselected = new Signal(RadioButton);
            this._selected = new Signal(RadioButton);
        }
        public function add(_arg1:RadioButton, _arg2:Boolean=false):void{
            var _local3:int = this.group.indexOf(_arg1);
            if (_local3 != -1){
                return;
            };
            this.group.push(_arg1);
            if (_arg2){
                this.onSelected(_arg1);
            };
            _arg1.selected.add(this.onSelected);
        }
        public function get count():uint{
            return (this.group.length);
        }
        public function get(_arg1:int):RadioButton{
            return (this.group[_arg1]);
        }
        public function get current():RadioButton{
            return (this._current);
        }
        private function onSelected(_arg1:RadioButton):void{
            if (this._current == _arg1){
                return;
            };
            if (this._current){
                this._current.isSelected = false;
                this._deselected.dispatch(this._current);
            };
            this._current = _arg1;
            if (this._current){
                this._current.isSelected = true;
                this._selected.dispatch(this._current);
            };
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get deselected():ISignal{
            return (this._deselected);
        }

    }
}//package alecmce.ui.radio 
