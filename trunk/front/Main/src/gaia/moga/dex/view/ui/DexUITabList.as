//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import alecmce.ui.button.*;

    public class DexUITabList extends Sprite {

        private var _selected:Signal;
        private var _close:Signal;
        private var closeButton:MovieClipButton;
        private var map:Dictionary;
        private var tabs:Vector.<DexUITab>;
        private var selectedTab:DexUITab;

        public static const COUNT:uint = 7;

        public function DexUITabList(_arg1:Asset){
            this._selected = new Signal(Tab);
            this._close = new Signal();
            this.closeButton = new MovieClipButton((_arg1.content as MovieClip).close);
            this.closeButton.clicked.add(this.onClose);
            this.map = new Dictionary(true);
            this.tabs = this.generateTabs(_arg1);
            addChild(_arg1.self);
        }
        public function get close():ISignal{
            return (this._close);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function setData(_arg1:Vector.<Tab>, _arg2:Tab=null):void{
            var _local5:DexUITab;
            var _local3:uint = _arg1.length;
            var _local4:int;
            while (_local4 < COUNT) {
                _local5 = this.tabs[_local4];
                if (_local4 < _local3){
                    _local5.label = _arg1[_local4].label;
                    _local5.clicked.add(this.onTabClicked);
                    this.map[_local5] = _arg1[_local4];
                    if (_arg1[_local4] == _arg2){
                        this.selectedTab = _local5;
                        _local5.isSelected = true;
                    };
                } else {
                    _local5.label = "";
                    _local5.clicked.removeAll();
                    delete this.map[_local5];
                };
                _local4++;
            };
        }
        private function generateTabs(_arg1:Asset):Vector.<DexUITab>{
            var _local2:MovieClip = (_arg1.content as MovieClip);
            var _local3:Vector.<DexUITab> = new Vector.<DexUITab>(COUNT, true);
            var _local4:int;
            while (_local4 < COUNT) {
                _local3[_local4] = new DexUITab(_local2[("tab" + _local4)]);
                _local4++;
            };
            return (_local3);
        }
        private function onTabClicked(_arg1:DexUITab):void{
            if (this.selectedTab == _arg1){
                return;
            };
            if (this.selectedTab){
                this.selectedTab.isSelected = false;
            };
            this.selectedTab = _arg1;
            this.selectedTab.isSelected = true;
            this._selected.dispatch(this.map[_arg1]);
        }
        private function onClose(_arg1:MovieClipButton):void{
            this._close.dispatch();
        }

    }
}//package gaia.moga.dex.view.ui 
