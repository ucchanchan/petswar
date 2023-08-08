//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import gaia.lib.assets.*;
    import com.gskinner.motion.easing.*;

    public class CaptureDialog {

        public var working:Number;
        private var _response:Signal;
        private var _container:Sprite;
        private var _asset:Asset;
        private var _percentage:int;
        private var content:MovieClip;
        private var signaller:SignallingAsset;
        private var dialog:MovieClip;
        private var button:MovieClip;

        public function CaptureDialog(_arg1:Asset, _arg2:Sprite){
            this._response = new Signal(Boolean);
            this._asset = _arg1;
            this._container = _arg2;
            this.working = 0;
        }
        public function show(_arg1:uint, _arg2:int, _arg3:String, _arg4:Boolean=true):void{
            this._percentage = _arg2;
            this.content = MovieClip(this._asset.content);
            this.signaller = SignallingAsset(this.content);
            this.signaller.signal.add(this.onSignal);
            this.dialog = this.content.dialog;
            this.dialog.captureDifficulty.text = _arg3;
            this.button = this.dialog.captureButton;
            this.button.visible = _arg4;
            if (_arg4){
                this.button.percentage.label.text = (_arg2 + "%");
            };
            this.dialog.yes_mask.visible = (this._percentage == 0);
            this.dialog.captureNA.visible = !(_arg4);
            if (_arg4){
                new GTween(this, 1, {working:_arg2}, {ease:Quadratic.easeOut, onChange:this.iterate});
            };
            this.content.gotoAndPlay(1);
            this._container.addChild(this._asset.self);
        }
        private function iterate(_arg1:GTween):void{
            var _local2 = (this.working | 0);
            this.button.highlight.gotoAndStop(_local2);
            this.button.piechart.gotoAndStop(_local2);
        }
        private function onSignal(_arg1:Object):void{
            switch (_arg1){
                case "ready":
                    this.content.stop();
                    this.readyAssets();
                    break;
                default:
                    this.signaller.signal.removeAll();
                    this.signaller = null;
                    this._container.removeChild(this._asset.self);
            };
        }
        private function readyAssets():void{
            if (this._percentage > 0){
                this.dialog.yes.addEventListener(MouseEvent.CLICK, this.onYes);
            };
            this.dialog.no.addEventListener(MouseEvent.CLICK, this.onNo);
        }
        private function onYes(_arg1:MouseEvent):void{
            this.cleanup();
            this._response.dispatch(true);
        }
        private function onNo(_arg1:MouseEvent):void{
            this.cleanup();
            this._response.dispatch(false);
        }
        private function cleanup():void{
            this.dialog.yes.removeEventListener(MouseEvent.CLICK, this.onYes);
            this.dialog.no.removeEventListener(MouseEvent.CLICK, this.onNo);
            this.content.play();
            this.content = null;
            this.dialog = null;
        }
        public function get response():ISignal{
            return (this._response);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
