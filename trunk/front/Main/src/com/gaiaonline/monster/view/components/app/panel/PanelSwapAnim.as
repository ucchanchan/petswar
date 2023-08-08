//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.app.panel {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class PanelSwapAnim extends BasicAnim {

        private var _isPlaying:Boolean;
        private var container:DisplayObjectContainer;
        private var current:Panel;
        private var target:Panel;
        private var top:DisplayObjectContainer;
        private var streak:Asset;
        private var bitmap:Bitmap;
        private var mask:Shape;
        private var frames:int;

        private static const DURATION:Number = 0.5;
        private static const TINT:Number = 0.6;
        private static const DELAY:int = 2;

        public function PanelSwapAnim(_arg1:DisplayObjectContainer, _arg2:Panel, _arg3:Panel, _arg4:DisplayObjectContainer, _arg5:Asset){
            this.container = _arg1;
            this.current = _arg2;
            this.target = _arg3;
            this.top = _arg4;
            this.streak = _arg5;
            this._isPlaying = false;
            _arg5.init();
        }
        override public function play():void{
            var _local1:Boolean;
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            if (this.current){
                this.bitmap = this.generateBitmap();
                this.mask = this.generateMask();
                this.bitmap.mask = this.mask;
                this.top.addChild(this.bitmap);
                this.top.addChild(this.mask);
                _local1 = this.removeCurrentPanel();
                this.target.setup();
                if (!_local1){
                    this.startAnimation();
                };
            } else {
                this.container.addChild(this.target);
                this.target.setup();
                _complete.dispatch(this);
            };
        }
        private function removeCurrentPanel():Boolean{
            if (!this.current){
                return (false);
            };
            var _local1:Boolean;
            if (this.current.parent){
                _local1 = true;
                this.current.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, -100);
                this.current.parent.removeChild(this.current);
            };
            this.current.dispose();
            return (_local1);
        }
        private function onRemovedFromStage(_arg1:Event):void{
            this.current.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.frames = DELAY;
            this.container.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
        private function onEnterFrame(_arg1:Event):void{
            if (this.frames--){
                return;
            };
            this.container.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.startAnimation();
        }
        private function startAnimation():void{
            var _local1:DisplayObject = this.streak.self;
            _local1.x = -1000;
            _local1.y = -1000;
            this.top.addChild(_local1);
            this.container.addChild(this.target);
            new GTween(this.mask, DURATION, {x:660, y:-760}, {onChange:this.onChange, onComplete:this.onComplete});
        }
        private function onChange(_arg1:GTween):void{
            var _local2:DisplayObject = this.streak.self;
            _local2.x = this.mask.x;
            _local2.y = this.mask.y;
        }
        private function onComplete(_arg1:GTween):void{
            this.top.removeChild(this.streak.self);
            this.top.removeChild(this.bitmap);
            this.bitmap.bitmapData.dispose();
            this.bitmap.bitmapData = null;
            this.bitmap = null;
            _complete.dispatch(this);
        }
        private function generateBitmap():Bitmap{
            var _local1:Stage = this.top.stage;
            var _local2:BitmapData = new BitmapData(_local1.stageWidth, _local1.stageHeight);
            var _local3:ColorTransform = new ColorTransform(TINT, TINT, TINT, 1);
            _local2.draw(this.current, null, _local3);
            return (new Bitmap(_local2));
        }
        private function generateMask():Shape{
            var _local1:Shape = new Shape();
            var _local2:Graphics = _local1.graphics;
            _local2.beginFill(0xFF00);
            _local2.drawRect(0, 0, 1524, -1524);
            _local2.endFill();
            _local1.x = -660;
            _local1.y = 760;
            _local1.rotation = 41;
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.view.components.app.panel 
