//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.dialog {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import org.osflash.signals.natives.*;
    import flash.geom.*;
    import flash.text.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import com.gaiaonline.monster.*;
    import com.gskinner.motion.easing.*;

    public class Dialog extends Sprite {

        private var ui:Asset;
        private var _messageTF:TextField;
        private var _button1:MovieClip;
        private var _positionX:Number;
        private var _centerX:Number;
        private var _button2:MovieClip;
        private var _dialog:DialogVO;
        private var _error:Signal;
        private var _language:DialogButtonsLanguageVO;
        private var _click1:NativeSignal;
        private var _click2:NativeSignal;
        private var _response:Signal;

        private static const FADE_DURATION:Number = 0.2;
        public static const YES:String = "YES";
        public static const NO:String = "NO";
        public static const OK:String = "OK";
        public static const CANCEL:String = "CANCEL";

        public function Dialog(_arg1:Asset){
            this.ui = _arg1;
            addChild(_arg1.self);
            this._error = new Signal();
            this._response = new Signal(String);
            visible = false;
            alpha = 0;
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1=null):void{
            var _local2:MovieClip = (this.ui.content as MovieClip);
            this._messageTF = (_local2.message as TextField);
            this._button1 = (_local2.button1 as MovieClip);
            this._positionX = this._button1.x;
            this._click1 = new NativeSignal(this._button1, MouseEvent.CLICK);
            this._click1.add(this.onClick1);
            this._button2 = (_local2.button2 as MovieClip);
            this._click2 = new NativeSignal(this._button2, MouseEvent.CLICK);
            this._click2.add(this.onClick2);
            this._centerX = ((this._button1.x + this._button2.x) * 0.5);
            if (this._dialog){
                this.show(this._dialog, this._language);
            };
        }
        public function show(_arg1:DialogVO, _arg2:DialogButtonsLanguageVO):void{
            this._dialog = _arg1;
            this._language = _arg2;
            if (!this.ui.isComplete){
                return;
            };
            this._messageTF.text = _arg1.message;
            switch (this._dialog.buttons){
                case DialogVO.YES_NO:
                    this._button1.x = this._positionX;
                    this._button2.visible = true;
                    this.configureButton(this._button1, this._language.yes, Color.DARK_GREEN);
                    this.configureButton(this._button2, this._language.no, Color.RED);
                    break;
                case DialogVO.OK_ONLY:
                    this._button1.x = this._centerX;
                    this._button2.visible = false;
                    this.configureButton(this._button1, this._language.ok, Color.DARK_GREEN);
                    break;
                case DialogVO.OK_CANCEL:
                    this._button1.x = this._positionX;
                    this._button2.visible = true;
                    this.configureButton(this._button1, this._language.ok, Color.DARK_GREEN);
                    this.configureButton(this._button2, this._language.cancel, Color.BLUE);
                    break;
            };
            visible = true;
            new GTween(this, FADE_DURATION, {alpha:1}, {ease:Quadratic.easeOut});
        }
        private function onClick1(_arg1:MouseEvent):void{
            switch (this._dialog.buttons){
                case DialogVO.YES_NO:
                    this._response.dispatch(YES);
                    break;
                case DialogVO.OK_ONLY:
                case DialogVO.OK_CANCEL:
                    this._response.dispatch(OK);
                    break;
            };
        }
        public function hide():void{
            new GTween(this, FADE_DURATION, {alpha:0}, {ease:Quadratic.easeOut, onComplete:this.completeListener});
        }
        private function onClick2(_arg1:MouseEvent):void{
            switch (this._dialog.buttons){
                case DialogVO.YES_NO:
                    this._response.dispatch(NO);
                    break;
                case DialogVO.OK_ONLY:
                case DialogVO.OK_CANCEL:
                    this._response.dispatch(CANCEL);
                    break;
            };
            new GTween(this, FADE_DURATION, {alpha:0}, {ease:Quadratic.easeOut, onComplete:this.completeListener});
        }
        private function completeListener(_arg1:GTween):void{
            visible = false;
        }
        private function configureButton(_arg1:MovieClip, _arg2:String, _arg3:uint):void{
            _arg1.useHandCursor = true;
            _arg1.buttonMode = true;
            _arg1.mouseChildren = false;
            var _local4:ColorTransform = new ColorTransform(0, 0, 0, 1, ((_arg3 >> 16) & 0xFF), ((_arg3 >> 8) & 0xFF), (_arg3 & 0xFF));
            TextField(_arg1.label).text = _arg2;
            Sprite(_arg1.bg).transform.colorTransform = _local4;
        }
        public function get error():Signal{
            return (this._error);
        }
        public function get response():Signal{
            return (this._response);
        }

    }
}//package com.gaiaonline.monster.view.dialog 
