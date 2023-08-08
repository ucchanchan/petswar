//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class WinItemDisplayAnim extends BasicAnim {

        private var asset:Asset;
        private var container:DisplayObjectContainer;
        private var content:MovieClip;
        private var display:SignallingAsset;
        private var items:Vector.<WinXPDisplay>;
        private var results:Vector.<WinResultVO>;
        private var itemsPlaying:int;
        private var _itemAsset:MovieClip;
        private var _isPlaying:Boolean;
        private var _itemQuantity:String;
        private var _itemName:String;
        private var _itemIcon:Asset;
        private var foundItemSound:SoundProxy;

        private static const FADE_OUT_DELAY:uint = 1500;

        public function WinItemDisplayAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:uint, _arg4:Asset, _arg5:Asset, _arg6:String, _arg7:String, _arg8:SoundProxy){
            this.asset = _arg2;
            this.container = _arg1;
            this.results = this.results;
            this.foundItemSound = _arg8;
            this._itemName = _arg7;
            this._itemQuantity = _arg6;
            this._itemIcon = _arg5;
            _arg4.complete.add(this.onItemAssetReady);
            this._isPlaying = false;
            if (_arg2.isComplete){
                this.setup(_arg2);
            } else {
                _arg2.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
            this.content = MovieClip(_arg1.content);
            this.content.stop();
            if (!this.display){
                return;
            };
            if (this._isPlaying){
                this.play();
            };
        }
        override public function play():void{
            this._isPlaying = true;
            if (!this.asset.isComplete){
                return;
            };
            this.display = SignallingAsset(this.asset.content);
            this.display.signal.add(this.onSignal);
            this.container.addChild(this.asset.self);
            this._itemAsset.x = 215;
            this._itemAsset.y = 360;
            this._itemAsset.itemIcon.addChild(this._itemIcon.self);
            this._itemAsset.itemQuantity.text = this._itemQuantity;
            this._itemAsset.itemName.text = this._itemName;
            this._itemAsset.alpha = 0;
            new GTween(this._itemAsset, 0.4, {alpha:1});
            new GTween(this._itemAsset, 0.3, {y:340});
            var _local1:Timer = new Timer(FADE_OUT_DELAY, 1);
            _local1.addEventListener(TimerEvent.TIMER, this.onFadeIn, false, 0, true);
            _local1.start();
            this.container.addChild(this._itemAsset);
            this._itemAsset.play();
            this.content.play();
            this.foundItemSound.play();
        }
        private function onFadeIn(_arg1:TimerEvent):void{
            new GTween(this._itemAsset, 0.2, {alpha:0});
        }
        private function onItemAssetReady(_arg1:Asset):void{
            this._itemAsset = MovieClip(_arg1.content);
        }
        private function onSignal(_arg1:Object):void{
            if (_arg1 == "complete"){
                this.container.removeChild(this.asset.self);
                this.container.removeChild(this._itemAsset);
                _complete.dispatch(this);
                this.display.signal.remove(this.onSignal);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win 
