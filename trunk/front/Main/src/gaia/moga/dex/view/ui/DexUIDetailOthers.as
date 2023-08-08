//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import alecmce.ui.button.*;
    import alecmce.list.*;

    public class DexUIDetailOthers {

        private var mc:MovieClip;
        private var list:List;
        private var left:MovieClipButton;
        private var right:MovieClipButton;
        private var tween:GTween;
        private var maxIndex:uint;
        private var _moga:DexMoga;
        private var _selected:Signal;
        private var selectedDatum:DexUIDetailOthersDatum;

        private static const DURATION:Number = 0.3;

        public function DexUIDetailOthers(_arg1:MovieClip){
            this.mc = _arg1;
            this.addBitmaps(_arg1.list);
            this.list = new List(_arg1.list);
            this.left = new MovieClipButton(_arg1.left);
            this.right = new MovieClipButton(_arg1.right);
            this.tween = new GTween(this.list, DURATION, null, {onComplete:this.onTweenComplete});
            this._selected = new Signal(DexMogaInstance);
        }
        public function show(_arg1:DexMogaInstance):void{
            var _local4:int;
            var _local7:DexMogaInstance;
            var _local8:DexUIDetailOthersDatum;
            var _local9:Boolean;
            this._moga = _arg1.generic;
            var _local2:Vector.<ListDatum> = new Vector.<ListDatum>();
            var _local3:uint = this._moga.count;
            var _local5:int;
            while (_local5 < _local3) {
                _local7 = this._moga.getInstance(_local5);
                _local8 = new DexUIDetailOthersDatum(_local7);
                _local8.over.add(this.onDatumOver);
                _local8.out.add(this.onDatumOut);
                _local8.selected.add(this.onDatumSelected);
                _local9 = (_local7 == _arg1);
                _local8.isSelected = _local9;
                if (_local9){
                    _local4 = _local5;
                    this.selectedDatum = _local8;
                };
                _local2.push(_local8);
                _local5++;
            };
            this.list.data = _local2;
            this.maxIndex = _local2.length;
            this.maxIndex = (((this.maxIndex - 3) < 0)) ? 0 : (this.maxIndex - 3);
            var _local6:int = (((_local4 - 1) > this.maxIndex)) ? this.maxIndex : (_local4 - 1);
            if (_local6 < 0){
                _local6 = 0;
            };
            this.list.position = _local6;
            this.left.clicked.add(this.onLeftClicked);
            this.right.clicked.add(this.onRightClicked);
            this.updateButtons();
            this.onTweenComplete(this.tween);
        }
        private function onDatumOver(_arg1:DexUIDetailOthersDatum):void{
            this.selectedDatum.isSelected = false;
            _arg1.isSelected = true;
        }
        private function onDatumOut(_arg1:DexUIDetailOthersDatum):void{
            _arg1.isSelected = false;
            this.selectedDatum.isSelected = true;
        }
        private function onDatumSelected(_arg1:DexUIDetailOthersDatum):void{
            this.selectedDatum.isSelected = false;
            this._selected.dispatch(_arg1.instance);
            this.selectedDatum = _arg1;
            this.selectedDatum.isSelected = true;
        }
        public function cleanUp():void{
            if (this.list.data){
                this.cleanUpList();
            };
            this.left.clicked.remove(this.onLeftClicked);
            this.right.clicked.remove(this.onRightClicked);
        }
        private function cleanUpList():void{
            var _local3:DexUIDetailOthersDatum;
            var _local1:uint = this.list.data.length;
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = (this.list.data[_local2] as DexUIDetailOthersDatum);
                _local3.over.removeAll();
                _local3.out.removeAll();
                _local3.selected.removeAll();
                _local3.dispose();
                _local2++;
            };
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        private function addBitmaps(_arg1:MovieClip):void{
            var _local3:MovieClip;
            var _local4:Bitmap;
            var _local2:int;
            while (_local2 < 6) {
                _local3 = _arg1[("item_" + _local2)];
                _local4 = new Bitmap(new BitmapData(34, 34, true, 0));
                _local4.name = "bitmap";
                _local3.container.addChild(_local4);
                _local2++;
            };
        }
        private function onLeftClicked(_arg1:MovieClipButton):void{
            var _local2:Number = (this.list.position - 3);
            if (_local2 < 0){
                _local2 = 0;
            };
            this.tween.setValue("position", _local2);
            this.updateButtons();
        }
        private function onRightClicked(_arg1:MovieClipButton):void{
            var _local2:Number = (this.list.position + 3);
            if (_local2 > this.maxIndex){
                _local2 = this.maxIndex;
            };
            this.tween.setValue("position", _local2);
            this.updateButtons();
        }
        private function updateButtons():void{
            this.left.isVisible = (this.right.isVisible = (this.maxIndex > 0));
            this.left.isEnabled = (this.right.isEnabled = false);
        }
        private function onTweenComplete(_arg1:GTween):void{
            this.left.isEnabled = (this.list.index > 0);
            this.right.isEnabled = (this.list.index < this.maxIndex);
        }

    }
}//package gaia.moga.dex.view.ui 
