//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;

    public class DexUIMultiplesItem {

        private var ui:MovieClip;
        private var bitmap:BitmapData;
        public var addToTeamButton:DexUIAddToTeamButton;
        private var removeFromTeamButton:MovieClipButton;
        private var outline:MovieClip;
        private var mogaName:TextField;
        private var level:TextField;
        private var tween:GTween;
        private var ct:ColorTransform;
        private var _enabled:Boolean;
        private var _instance:DexMogaInstance;
        private var _moga:DexMoga;
        private var _isHighlighted:Boolean;
        private var _add:Signal;
        private var _remove:Signal;
        private var _click:Signal;
        private var _over:Signal;
        private var _out:Signal;
        private var _isLocked:Boolean;

        private static const WIDTH:int = 60;
        private static const HEIGHT:int = 60;
        private static const ORIGIN:Point = new Point();
        private static const DURATION:Number = 0.3;

        public function DexUIMultiplesItem(_arg1:MovieClip){
            this.ui = _arg1;
            this.bitmap = new BitmapData(WIDTH, HEIGHT, true, 0);
            this.addToTeamButton = new DexUIAddToTeamButton(_arg1.addToTeam);
            this.removeFromTeamButton = new MovieClipButton(_arg1.removeFromTeam);
            _arg1.container.addChild(new Bitmap(this.bitmap));
            this.level = _arg1.level;
            this.mogaName = _arg1.mogaName;
            this.outline = _arg1.outline;
            this.tween = new GTween(this.outline, DURATION);
            this.outline.alpha = 0;
            this.ct = new ColorTransform();
            this._over = new Signal(DexUIMultiplesItem);
            this._out = new Signal(DexUIMultiplesItem);
            this._click = new Signal(DexUIMultiplesItem);
            this._add = new Signal(DexUIMultiplesItem);
            this._remove = new Signal(DexUIMultiplesItem);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            this.addToTeamButton.isEnabled = !(_arg1);
            this.removeFromTeamButton.isEnabled = !(_arg1);
        }
        public function get enabled():Boolean{
            return (this._enabled);
        }
        public function set enabled(_arg1:Boolean):void{
            if (this._enabled == _arg1){
                return;
            };
            this._enabled = _arg1;
            this.updateListeners();
        }
        public function set moga(_arg1:DexMoga):void{
            if (this._moga == _arg1){
                return;
            };
            this.clear();
            this._moga = _arg1;
            this.drawMoga();
            this.setRarity();
            this.updateListeners();
        }
        public function get moga():DexMoga{
            return (this._moga);
        }
        public function set y(_arg1:Number):void{
            this.ui.y = _arg1;
        }
        public function get isHighlighted():Boolean{
            return (this._isHighlighted);
        }
        public function set isHighlighted(_arg1:Boolean):void{
            if (this._isHighlighted == _arg1){
                return;
            };
            this._isHighlighted = _arg1;
            this.tween.setValue("alpha", (this._isHighlighted) ? 1 : 0);
        }
        public function get instance():DexMogaInstance{
            return (this._instance);
        }
        public function set instance(_arg1:DexMogaInstance):void{
            if (this._instance){
                this._instance.changed.remove(this.onInstanceChanged);
            };
            this._instance = _arg1;
            this.ui.visible = !((_arg1 == null));
            if (!this.ui.visible){
                return;
            };
            var _local2:MonsterModel = _arg1.model;
            this.addToTeamButton.isVisible = !(_arg1.isOnTeam);
            this.removeFromTeamButton.isVisible = _arg1.isOnTeam;
            _arg1.changed.add(this.onInstanceChanged);
            this.mogaName.text = _local2.name;
            this.level.text = ("Lv " + _local2.level.toString());
            this.ui.cacheAsBitmap = true;
        }
        private function onInstanceChanged(_arg1:DexMogaInstance):void{
            this.addToTeamButton.isVisible = !(_arg1.isOnTeam);
            this.removeFromTeamButton.isVisible = _arg1.isOnTeam;
        }
        private function updateListeners():void{
            if (((this._enabled) && (!((this._moga == null))))){
                this.ui.container.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
                this.ui.container.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
                this.ui.container.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
                this.addToTeamButton.clicked.add(this.onAdd);
                this.removeFromTeamButton.clicked.add(this.onRemove);
            } else {
                this.onMouseOut(null);
                this.ui.container.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
                this.ui.container.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
                this.ui.container.removeEventListener(MouseEvent.CLICK, this.onClick);
                this.addToTeamButton.clicked.remove(this.onAdd);
                this.removeFromTeamButton.clicked.remove(this.onRemove);
            };
        }
        private function onAdd(_arg1:DexUIAddToTeamButton):void{
            this.ui.parent.setChildIndex(this.ui, (this.ui.parent.numChildren - 1));
            this._add.dispatch(this);
        }
        private function onRemove(_arg1:MovieClipButton):void{
            this._remove.dispatch(this);
        }
        private function onMouseOver(_arg1:MouseEvent):void{
            this._over.dispatch(this);
        }
        private function onMouseOut(_arg1:MouseEvent):void{
            this._out.dispatch(this);
        }
        private function onClick(_arg1:MouseEvent):void{
            this._click.dispatch(this);
        }
        private function clear():void{
            this.bitmap.fillRect(this.bitmap.rect, 0);
            this.tween.paused = true;
            this.outline.alpha = 0;
        }
        private function drawMoga():void{
            if (!this._moga){
                return;
            };
            var _local1:BitmapData = this._moga.bundle.team;
            this.bitmap.copyPixels(_local1, _local1.rect, ORIGIN);
        }
        private function setRarity():void{
            if (!this._moga){
                return;
            };
            var _local1:uint = Color.fromRarity(this._moga.rarity);
            this.ct.alphaMultiplier = (this._isHighlighted) ? (((_local1 >>> 24) & 0xFF) / 0xFF) : 0;
            this.ct.redMultiplier = (((_local1 >>> 16) & 0xFF) / 0xFF);
            this.ct.greenMultiplier = (((_local1 >>> 8) & 0xFF) / 0xFF);
            this.ct.blueMultiplier = ((_local1 & 0xFF) / 0xFF);
            this.outline.transform.colorTransform = this.ct;
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
        public function get add():ISignal{
            return (this._add);
        }
        public function get remove():ISignal{
            return (this._remove);
        }

    }
}//package gaia.moga.dex.view.ui 
