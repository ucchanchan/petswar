//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import flash.geom.*;
    import com.gaiaonline.monster.*;
    import com.gskinner.motion.easing.*;
    import flash.filters.*;

    public class DexUIItem {

        private var ui:MovieClip;
        private var bitmap:BitmapData;
        private var tween:GTween;
        private var tint:uint;
        private var baseIndex:uint;
        private var topIndex:uint;
        private var _isEnabled:Boolean;
        private var _moga:DexMoga;
        private var _click:Signal;
        private var _over:Signal;
        private var _out:Signal;

        private static const CAN_HIGHLIGHT_UNCAUGHT_MOGAS:Boolean = true;
        private static const WIDTH:uint = 34;
        private static const HEIGHT:uint = 34;
        private static const ORIGIN:Point = new Point();
        private static const DURATION:Number = 0.3;
        private static const M:Number = 0.075;
        private static const GREYSCALE:ColorMatrixFilter = new ColorMatrixFilter([M, M, M, 0, 0, M, M, M, 0, 0, M, M, M, 0, 0, 0, 0, 0, 1, 0]);
        private static const GREY:uint = 4284900966;

        public function DexUIItem(_arg1:MovieClip){
            this.ui = _arg1;
            _arg1.visible = false;
            this.baseIndex = _arg1.parent.getChildIndex(_arg1);
            this.topIndex = (_arg1.parent.numChildren - 1);
            this.bitmap = new BitmapData(WIDTH, HEIGHT, true, 0);
            _arg1.container.addChild(new Bitmap(this.bitmap));
            this.tween = new GTween(_arg1.outline, DURATION, null, {ease:Quadratic.easeOut});
            this.tint = GREY;
            this._click = new Signal(DexUIItem);
            this._over = new Signal(DexUIItem);
            this._out = new Signal(DexUIItem);
        }
        public function get moga():DexMoga{
            return (this._moga);
        }
        public function set moga(_arg1:DexMoga):void{
            if (this._moga == _arg1){
                return;
            };
            this._moga = _arg1;
            var _local2 = !((this._moga == null));
            this.ui.visible = _local2;
            this.isEnabled = ((_local2) && (((CAN_HIGHLIGHT_UNCAUGHT_MOGAS) || ((this._moga.count > 0)))));
            this.tint = (_local2) ? Color.fromRarity(this._moga.rarity) : GREY;
            this.updateImage();
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            if (((((this._isEnabled) && (this._moga))) && (((CAN_HIGHLIGHT_UNCAUGHT_MOGAS) || ((this._moga.count > 0)))))){
                this.ui.useHandCursor = true;
                this.ui.buttonMode = true;
                this.ui.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                this.ui.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                this.ui.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            } else {
                this.ui.useHandCursor = false;
                this.ui.buttonMode = false;
                this.ui.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                this.ui.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                this.ui.removeEventListener(MouseEvent.CLICK, this.onClick);
            };
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }
        public function get click():ISignal{
            return (this._click);
        }
        public function get x():Number{
            return (this.ui.x);
        }
        public function get y():Number{
            return (this.ui.y);
        }
        private function updateImage():void{
            this.bitmap.fillRect(this.bitmap.rect, 0);
            if (!this._moga){
                return;
            };
            var _local1:DexMogaBundle = this._moga.bundle;
            if (_local1.isComplete){
                this.drawImage(_local1);
            } else {
                _local1.complete.addOnce(this.drawImage);
                _local1.error.addOnce(this.drawError);
                _local1.init();
            };
        }
        private function drawImage(_arg1:DexMogaBundle):void{
            _arg1.error.removeAll();
            var _local2:BitmapData = _arg1.icon;
            this.bitmap.copyPixels(_local2, _local2.rect, ORIGIN);
            if (!(this._moga.count) > 0){
                this.bitmap.applyFilter(_local2, _local2.rect, ORIGIN, GREYSCALE);
            };
        }
        private function drawError(_arg1:DexMogaBundle, _arg2:String):void{
            _arg1.complete.addOnce(this.drawImage);
            var _local3:BitmapData = _arg1.icon;
            if (_local3){
                this.bitmap.fillRect(_local3.rect, 4294901760);
                if (!(this._moga.count) > 0){
                    this.bitmap.applyFilter(_local3, _local3.rect, ORIGIN, GREYSCALE);
                };
            };
        }
        private function onOver(_arg1:MouseEvent):void{
            this.tween.setValue("tint", this.tint);
            this._over.dispatch(this);
            this.ui.parent.setChildIndex(this.ui, this.topIndex);
        }
        private function onOut(_arg1:MouseEvent):void{
            this.tween.setValue("tint", GREY);
            this._out.dispatch(this);
            this.ui.parent.setChildIndex(this.ui, this.baseIndex);
        }
        private function onClick(_arg1:MouseEvent):void{
            this.onOut(null);
            this._click.dispatch(this);
        }

    }
}//package gaia.moga.dex.view.ui 
