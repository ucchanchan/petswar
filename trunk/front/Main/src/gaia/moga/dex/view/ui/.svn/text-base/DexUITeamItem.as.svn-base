//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import flash.filters.*;

    public class DexUITeamItem {

        public var ui:MovieClip;
        private var bitmap:BitmapData;
        private var colorables:DexUITeamItemColorables;
        private var selector:MovieClipButton;
        private var button:DexUITeamItemButton;
        public var step:uint;
        private var fade:GTween;
        private var _selected:Signal;
        private var _removed:Signal;
        private var _isLocked:Boolean;
        private var _isActive:Boolean;
        private var _moga:DexMogaInstance;

        private static const WIDTH:int = 60;
        private static const HEIGHT:int = 60;
        private static const ORIGIN:Point = new Point();
        private static const STEP:uint = 10;
        private static const DURATION:Number = 0.5;
        private static const M:Number = 0.9;
        private static const FADE:ColorMatrixFilter = new ColorMatrixFilter([M, 0, 0, 0, 0, 0, M, 0, 0, 0, 0, 0, M, 0, 0, 0, 0, 0, M, 0]);

        public function DexUITeamItem(_arg1:MovieClip){
            this.ui = _arg1;
            _arg1.stop();
            this._selected = new Signal(DexMogaInstance);
            this._removed = new Signal(DexMogaInstance);
            this.bitmap = new BitmapData(WIDTH, HEIGHT, true, 0);
            _arg1.container.addChild(new Bitmap(this.bitmap));
            this.selector = new MovieClipButton(_arg1.selector);
            this.selector.isEnabled = false;
            this.button = new DexUITeamItemButton(_arg1.button, _arg1.buttonBack);
            this.fade = new GTween(this, DURATION, null, {onChange:this.onFade, onComplete:this.onFadeComplete});
            this.updatePosition();
            this.colorables = new DexUITeamItemColorables(_arg1.button, _arg1.outline);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            this.updatePosition();
            if (((!(this._isActive)) && (this._moga))){
                this.moga = null;
            } else {
                this.updateColorables();
            };
        }
        public function get moga():DexMogaInstance{
            return (this._moga);
        }
        public function set moga(_arg1:DexMogaInstance):void{
            if (this._moga == _arg1){
                return;
            };
            this.cancelImage();
            this._moga = _arg1;
            if (this._moga){
                this.selector.clicked.add(this.onMogaSelected);
            } else {
                this.selector.clicked.removeAll();
            };
            this.selector.isEnabled = !((this._moga == null));
            this.updateImage();
            this.updatePosition();
            this.updateColorables();
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get removed():ISignal{
            return (this._removed);
        }
        private function cancelImage():void{
            if (!this._moga){
                return;
            };
            this.step = 0;
            this.fade.setValue("step", STEP);
        }
        private function onFade(_arg1:GTween):void{
            this.bitmap.applyFilter(this.bitmap, this.bitmap.rect, ORIGIN, FADE);
        }
        private function onFadeComplete(_arg1:GTween):void{
            this.bitmap.fillRect(this.bitmap.rect, 0);
        }
        private function updateImage():void{
            if (!this._moga){
                return;
            };
            var _local1:DexMogaBundle = this._moga.generic.bundle;
            if (_local1.isComplete){
                this.drawImage(_local1);
            } else {
                _local1.complete.addOnce(this.drawImage);
                _local1.error.addOnce(this.drawError);
                _local1.init();
            };
        }
        private function drawImage(_arg1:DexMogaBundle):void{
            if (!this._moga){
                return;
            };
            var _local2:BitmapData = _arg1.team;
            this.bitmap.copyPixels(_local2, _local2.rect, ORIGIN);
            this.fade.paused = true;
        }
        private function drawError(_arg1:DexMogaBundle, _arg2:String):void{
            if (!this._moga){
                return;
            };
            var _local3:BitmapData = _arg1.team;
            this.bitmap.fillRect(_local3.rect, 4294901760);
            this.fade.paused = true;
        }
        private function updatePosition():void{
            var _local1 = !((this._moga == null));
            this.ui.gotoAndStop((_local1) ? 1 : (this._isLocked) ? 3 : 2);
            this.button.isVisible = !(((_local1) && (this._isLocked)));
            this.ui.buttonBack.visible = this.button.isVisible;
            this.button.isEnabled = _local1;
            if (_local1){
                this.button.click.addOnce(this.onButtonClick);
            } else {
                this.button.click.removeAll();
            };
        }
        private function updateColorables():void{
            this.colorables.setState(this._isLocked, !((this._moga == null)));
        }
        private function onButtonClick():void{
            this._moga.isOnTeam = false;
            this._removed.dispatch(this._moga);
            this.moga = null;
        }
        private function onMogaSelected(_arg1:MovieClipButton):void{
            this._selected.dispatch(this._moga);
        }

    }
}//package gaia.moga.dex.view.ui 
