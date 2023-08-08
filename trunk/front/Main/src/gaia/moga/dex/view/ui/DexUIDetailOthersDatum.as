//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import flash.geom.*;
    import flash.text.*;
    import alecmce.list.*;
    import com.gaiaonline.monster.*;

    public class DexUIDetailOthersDatum implements ListDatum {

        private var _instance:DexMogaInstance;
        private var ct:ColorTransform;
        private var _mc:MovieClip;
        private var _isSelected:Boolean;
        private var _over:Signal;
        private var _out:Signal;
        private var _selected:Signal;
        private var mc:MovieClip;

        private static const ORIGIN:Point = new Point(0, 0);

        public function DexUIDetailOthersDatum(_arg1:DexMogaInstance){
            this._instance = _arg1;
            this.ct = new ColorTransform();
            this._over = new Signal(DexUIDetailOthersDatum);
            this._out = new Signal(DexUIDetailOthersDatum);
            this._selected = new Signal(DexUIDetailOthersDatum);
        }
        public function clear(_arg1:MovieClip):void{
            this.removeListeners(_arg1);
        }
        public function apply(_arg1:MovieClip):void{
            this.mc = _arg1;
            var _local2:DexMogaBundle = this._instance.generic.bundle;
            if (_local2.isComplete){
                this.do_apply(_local2);
            } else {
                _local2.complete.addOnce(this.do_apply);
            };
        }
        private function do_apply(_arg1:DexMogaBundle):void{
            var _local2:BitmapData = _arg1.icon;
            Color.setTransform(this.ct, Color.fromRarity(this._instance.generic.rarity));
            var _local3:Bitmap = (this.mc.container.getChildAt(0) as Bitmap);
            var _local4:TextField = this.mc.level;
            _local3.bitmapData.copyPixels(_local2, _local2.rect, ORIGIN);
            _local4.text = ("Lv " + this._instance.model.level.toString());
            this._mc = this.mc;
            this._mc.selectionMC.transform.colorTransform = this.ct;
            this._mc.selectionMC.visible = this._isSelected;
            this.updateListeners();
        }
        public function toString():String{
            return (((((this._instance.model.name + " (") + this._instance.generic.genericName) + ") ") + this._instance.model.level));
        }
        public function get isSelected():Boolean{
            return (this._isSelected);
        }
        public function set isSelected(_arg1:Boolean):void{
            if (this._isSelected == _arg1){
                return;
            };
            this._isSelected = _arg1;
            if (this._mc){
                this._mc.selectionMC.visible = this._isSelected;
            };
        }
        private function updateListeners():void{
            this._mc.addEventListener(MouseEvent.CLICK, this.onClick);
            this._mc.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._mc.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
        private function onClick(_arg1:MouseEvent):void{
            this._selected.dispatch(this);
        }
        private function onRollOver(_arg1:MouseEvent):void{
            this._over.dispatch(this);
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this._out.dispatch(this);
        }
        private function removeListeners(_arg1:MovieClip):void{
            _arg1.removeEventListener(MouseEvent.CLICK, this.onClick);
            _arg1.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            _arg1.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }
        public function dispose():void{
            if (this._mc){
                this.removeListeners(this._mc);
            };
            this._mc = null;
        }
        public function get instance():DexMogaInstance{
            return (this._instance);
        }

    }
}//package gaia.moga.dex.view.ui 
