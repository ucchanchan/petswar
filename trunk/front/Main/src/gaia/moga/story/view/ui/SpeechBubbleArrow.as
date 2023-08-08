//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;

    public class SpeechBubbleArrow {

        private var ui:MovieClip;
        private var _isVisible:Boolean;
        private var _click:Signal;

        public function SpeechBubbleArrow(_arg1:MovieClip){
            this.ui = _arg1;
            _arg1.useHandCursor = true;
            _arg1.buttonMode = true;
            this._click = new Signal();
        }
        public function get isVisible():Boolean{
            return (this._isVisible);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (this._isVisible == _arg1){
                return;
            };
            this._isVisible = _arg1;
            if (this._isVisible){
                this.activate();
            } else {
                this.deactivate();
            };
        }
        protected function activate():void{
            this.ui.visible = true;
            this.ui.addEventListener(MouseEvent.CLICK, this.onClick);
            this.ui.play();
        }
        protected function deactivate():void{
            this.ui.removeEventListener(MouseEvent.CLICK, this.onClick);
            this.ui.gotoAndPlay("out");
        }
        private function onClick(_arg1:MouseEvent):void{
            this._click.dispatch();
        }
        public function get click():ISignal{
            return (this._click);
        }
        public function dispose(_arg1:Boolean):void{
            this.ui.buttonMode = false;
        }

    }
}//package gaia.moga.story.view.ui 
