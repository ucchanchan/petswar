//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.view.ui {
    import flash.display.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import alecmce.ui.radio.*;

    public class InventoryUITabs {

        private var clip:MovieClip;
        private var top:int;
        private var _selected:Signal;
        private var mapToButton:Object;
        private var mapToID:Dictionary;
        private var group:RadioButtonGroup;
        private var _categories:Vector.<String>;

        public function InventoryUITabs(_arg1:MovieClip){
            this.clip = _arg1;
            this.top = (_arg1.numChildren - 1);
            this._selected = new Signal(String);
            this.mapToButton = {};
            this.mapToID = new Dictionary();
            this.group = new RadioButtonGroup();
            this.group.deselected.add(this.onButtonDeselected);
            this.group.selected.add(this.onButtonSelected);
            this.register(_arg1.tab_0, "consume", true);
        }
        public function get categories():Vector.<String>{
            return (this._categories);
        }
        public function set categories(_arg1:Vector.<String>):void{
            var _local3:RadioButton;
            var _local4:String;
            this._categories = _arg1;
            var _local2:int = this.group.count;
            while (_local2--) {
                _local3 = this.group.get(_local2);
                _local4 = this.mapToID[_local3];
                _local3.isEnabled = !((_arg1.indexOf(_local4) == -1));
            };
        }
        private function onButtonSelected(_arg1:RadioButton):void{
            this.clip.setChildIndex(_arg1.ui, this.top);
            var _local2:String = this.mapToID[_arg1];
            this._selected.dispatch(_local2);
        }
        private function onButtonDeselected(_arg1:RadioButton):void{
            this.clip.setChildIndex(_arg1.ui, 0);
        }
        private function register(_arg1:MovieClip, _arg2:String, _arg3:Boolean=false):RadioButton{
            var _local4:RadioButton = new RadioButton(_arg1);
            _local4.isEnabled = ((this._categories) && (!((this._categories.indexOf(_arg2) == -1))));
            this.mapToButton[_arg2] = _local4;
            this.mapToID[_local4] = _arg2;
            this.group.add(_local4, _arg3);
            return (_local4);
        }
        public function get selected():ISignal{
            return (this._selected);
        }

    }
}//package gaia.moga.inventory.view.ui 
