//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;

    public class MenuButton {

        public var asset:MovieClip;
        public var id:String;
        public var over:Signal;
        public var clicked:Signal;
        private var toolTip:MovieClip;
        private var isTipSet:Boolean;
        private var _arrow:Boolean;
        protected var _enabled:Boolean;
        protected var _selected:Boolean;
        protected var _over:Boolean;
        protected var _visible:Boolean;
        private var _isEnabled:Boolean;

        protected static const BUTTON_ANIM_TIME:Number = 0.3;

        public function MenuButton(_arg1:MovieClip, _arg2:String){
            this.asset = _arg1;
            this.id = _arg2;
            this.over = new Signal(String);
            this.clicked = new Signal(String);
            this.toolTip = _arg1.toolTip;
            if (this.toolTip){
                this.toolTip.visible = false;
            };
            this.arrow = false;
            this._isEnabled = true;
            this.isEnabled = false;
        }
        public function setTip(_arg1:String, _arg2:String):void{
            if (!this.toolTip){
                return;
            };
            this.isTipSet = true;
            this.toolTip.title.text = _arg1;
            this.toolTip.main.text = _arg2;
        }
        public function get arrow():Boolean{
            return (this._arrow);
        }
        public function set arrow(_arg1:Boolean):void{
            this._arrow = this.arrow;
            if (!this.asset.arrow){
                return;
            };
            this.asset.arrow.visible = this._arrow;
            if (this._arrow){
                this.asset.arrow.play();
            } else {
                this.asset.arrow.stop();
            };
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            if (this._isEnabled){
                this.addMouseListeners();
                this.asset.gotoAndStop(1);
            } else {
                this.onRollOut(null);
                this.removeMouseListeners();
                this.asset.gotoAndStop("disabled");
            };
        }
        protected function addMouseListeners():void{
            this.asset.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.asset.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            this.asset.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
        }
        private function removeMouseListeners():void{
            this.asset.removeEventListener(MouseEvent.CLICK, this.onClick);
            this.asset.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this.asset.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
        public function dispose(_arg1:Boolean=true):void{
            this.asset.removeEventListener(MouseEvent.CLICK, this.onClick);
            this.asset.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this.asset.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
        private function onClick(_arg1:MouseEvent):void{
            if (this.toolTip){
                this.toolTip.visible = false;
            };
            this.clicked.dispatch(this.id);
        }
        protected function onRollOver(_arg1:MouseEvent):void{
            this._over = true;
            this.asset.removeEventListener(Event.ENTER_FRAME, this.reverse);
            this.asset.gotoAndPlay("over");
            this.over.dispatch(this.id);
            if (this.toolTip){
                this.toolTip.visible = this.isTipSet;
            };
        }
        protected function onRollOut(_arg1:MouseEvent):void{
            this._over = false;
            if (this._isEnabled){
                this.asset.addEventListener(Event.ENTER_FRAME, this.reverse);
            };
            if (this.toolTip){
                this.toolTip.visible = false;
            };
        }
        private function reverse(_arg1:Event):void{
            this.asset.prevFrame();
            if (this.asset.currentFrame == 1){
                this.asset.removeEventListener(Event.ENTER_FRAME, this.reverse);
            };
        }

    }
}//package gaia.moga.menu.view.ui 
