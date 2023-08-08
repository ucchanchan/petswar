//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import flash.text.*;
    import com.gskinner.motion.easing.*;

    public class BattleUIFriend {

        private var _container:Sprite;
        private var _asset:Asset;
        private var _message:TextField;
        private var _icon:Sprite;
        private var _image:DisplayObject;
        private var _text:String;

        private static const DURATION:Number = 0.3;
        private static const DELAY:Number = 5;
        private static const MESSAGE:String = "message";
        private static const ICON:String = "icon";

        public function BattleUIFriend(_arg1:Asset, _arg2:Sprite){
            this._asset = _arg1;
            this._container = _arg2;
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset):void{
            var _local2:MovieClip = MovieClip(this._asset.content);
            this._message = TextField(_local2.getChildByName(MESSAGE));
            this._icon = Sprite(_local2.getChildByName(ICON));
            this._message.blendMode = BlendMode.LAYER;
        }
        public function show(_arg1:Asset, _arg2:String):void{
            var _local3:DisplayObject = this._asset.self;
            if (this._icon.numChildren){
                this._icon.removeChildAt(0);
            };
            this._icon.addChild(_arg1.self);
            this._message.text = _arg2;
            this._container.addChild(_local3);
            var _local4:GTween = new GTween(_local3, DURATION, {x:0}, {ease:Quadratic.easeOut});
            _local4.nextTween = new GTween(_local3, DURATION, {x:-270}, {autoPlay:false, delay:DELAY, onComplete:this.onComplete});
        }
        private function onLoadError(_arg1:ErrorEvent):void{
            var _local2:LoaderInfo = LoaderInfo(_arg1.target);
            this.removeEventListeners(_local2);
        }
        private function onLoadComplete(_arg1:Event):void{
            var _local2:LoaderInfo = LoaderInfo(_arg1.target);
            this.removeEventListeners(_local2);
        }
        private function removeEventListeners(_arg1:LoaderInfo):void{
            _arg1.addEventListener(Event.COMPLETE, this.onLoadComplete);
            _arg1.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            _arg1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
        }
        private function onComplete(_arg1:GTween):void{
            if (this._icon.numChildren){
                this._icon.removeChildAt(0);
            };
            this._image = null;
            this._text = null;
            if (this._asset.self.parent){
                this._asset.self.parent.removeChild(this._asset.self);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
