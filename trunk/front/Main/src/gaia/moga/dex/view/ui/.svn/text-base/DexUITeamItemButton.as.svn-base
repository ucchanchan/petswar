//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import com.gskinner.motion.easing.*;

    public class DexUITeamItemButton {

        private var ui:MovieClip;
        private var back:MovieClip;
        private var uiTween:GTween;
        private var backTween:GTween;
        private var values:Object;
        private var _isEnabled:Boolean;
        private var _click:Signal;

        private static const SCALE:Number = 1.4;
        private static const DURATION:Number = 0.6;

        public function DexUITeamItemButton(_arg1:MovieClip, _arg2:MovieClip){
            this.ui = _arg1;
            this.back = _arg2;
            this.uiTween = new GTween(_arg1, DURATION, null, {ease:Elastic.easeOut});
            this.backTween = new GTween(_arg2, DURATION, null, {ease:Elastic.easeOut});
            this.values = {scaleX:1, scaleY:1};
            this._click = new Signal();
        }
        public function get isVisible():Boolean{
            return (this.ui.visible);
        }
        public function set isVisible(_arg1:Boolean):void{
            this.ui.visible = _arg1;
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
                this.ui.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                this.ui.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                this.ui.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            } else {
                this.ui.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                this.ui.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                this.ui.removeEventListener(MouseEvent.CLICK, this.onClick);
            };
        }
        public function get click():ISignal{
            return (this._click);
        }
        private function onOver(_arg1:MouseEvent):void{
            this.values.scaleX = (this.values.scaleY = SCALE);
            this.uiTween.setValues(this.values);
            this.backTween.setValues(this.values);
        }
        private function onOut(_arg1:MouseEvent):void{
            this.values.scaleX = (this.values.scaleY = 1);
            this.uiTween.setValues(this.values);
            this.backTween.setValues(this.values);
        }
        private function onClick(_arg1:MouseEvent):void{
            this._click.dispatch();
            this.onOut(_arg1);
        }

    }
}//package gaia.moga.dex.view.ui 
