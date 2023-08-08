//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.tooltip {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import flash.geom.*;
    import flash.text.*;

    public class ToolTipDisplay {

        private var _container:DisplayObjectContainer;
        private var _asset:Asset;
        private var _position:Point;
        private var _tip:String;
        private var isShowing:Boolean;
        private var tween:GTween;
        private var buffer:Number;

        private static const ALPHA:String = "alpha";
        private static const DURATION:Number = 0.1;
        private static const BUFFER:int = 3;

        public function ToolTipDisplay(_arg1:DisplayObjectContainer, _arg2:Asset){
            this._container = _arg1;
            this._asset = _arg2;
            if (!this._asset.isComplete){
                this._asset.complete.addOnce(this.onReady);
            };
            var _local3:Sprite = Sprite(this._asset.self);
            _local3.alpha = 0;
            _local3.mouseEnabled = false;
            _local3.mouseChildren = false;
            this.isShowing = false;
            this.tween = new GTween(_local3, DURATION, {alpha:0}, {onComplete:this.onComplete});
        }
        private function onReady(_arg1:Asset):void{
            if (((this._position) || (this._tip))){
                this.fadeIn();
            };
        }
        public function show(_arg1:DisplayObject, _arg2:String):void{
            var _local3:Point = new Point(_arg1.mouseX, _arg1.mouseY);
            this._position = _arg1.localToGlobal(_local3);
            this._tip = _arg2;
            if (this.isShowing){
                this.fadeOut();
                return;
            };
            if (this._asset.isComplete){
                this.fadeIn();
            };
        }
        public function hide():void{
            this.fadeOut();
        }
        private function fadeOut():void{
            var _local1:MovieClip = MovieClip(this._asset.content);
            _local1.removeEventListener(Event.ENTER_FRAME, this.waitAFrame);
            this.tween.paused = true;
            this.tween.setValue(ALPHA, 0);
        }
        private function onComplete(_arg1:GTween):void{
            var _local2:DisplayObject;
            if (((this._position) || (this._tip))){
                this.fadeIn();
            } else {
                _local2 = this._asset.self;
                if ((((_local2.alpha == 0)) && (_local2.parent))){
                    this._container.removeChild(_local2);
                };
            };
        }
        private function fadeIn():void{
            this._container.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._container.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.buffer = BUFFER;
            this.prepareContent();
        }
        private function onMouseMove(_arg1:MouseEvent):void{
            if (--this.buffer){
                return;
            };
            this.onMouseDown(_arg1);
        }
        private function onMouseDown(_arg1:MouseEvent):void{
            this._container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._container.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.fadeOut();
        }
        private function prepareContent():void{
            var _local1:MovieClip = MovieClip(this._asset.content);
            var _local2:TextField = _local1.message;
            _local2.text = this._tip;
            _local1.addEventListener(Event.ENTER_FRAME, this.waitAFrame);
        }
        private function waitAFrame(_arg1:Event):void{
            var _local2:MovieClip = MovieClip(this._asset.content);
            var _local3:Sprite = _local2.shape;
            _local2.removeEventListener(Event.ENTER_FRAME, this.waitAFrame);
            var _local4:TextField = _local2.message;
            var _local5:Rectangle = _local4.getCharBoundaries((this._tip.length - 1));
            var _local6:int = _local5.bottom;
            var _local7:int = ((_local5.bottom < 20)) ? 26 : (_local5.bottom + 6);
            var _local8:Graphics = _local3.graphics;
            _local8.clear();
            _local8.beginFill(7459575);
            _local8.drawRoundRect(-64, -(_local7), 128, _local7, 10);
            _local8.endFill();
            _local4.y = -(((_local7 + _local6) * 0.5));
            this.positionAsset(_local6);
            this._position = null;
            this._tip = null;
            this._container.addChild(this._asset.self);
            this.tween.setValue(ALPHA, 1);
        }
        private function positionAsset(_arg1:Number):void{
            var _local2:DisplayObject = this._asset.self;
            if (this._position.y < (_arg1 + 10)){
                this._position.y = (_arg1 + 10);
                if (this._position.x > 380){
                    this._position.x = (this._position.x - 74);
                } else {
                    this._position.x = (this._position.x + 74);
                };
            } else {
                this._position.y = (this._position.y - 10);
                if (this._position.x < 74){
                    this._position.x = 74;
                } else {
                    if (this._position.x > (760 - 74)){
                        this._position.x = (760 - 74);
                    };
                };
            };
            _local2.x = this._position.x;
            _local2.y = this._position.y;
        }

    }
}//package com.gaiaonline.monster.view.components.tooltip 
