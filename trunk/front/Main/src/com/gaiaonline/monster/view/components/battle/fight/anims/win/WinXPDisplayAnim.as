//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class WinXPDisplayAnim extends BasicAnim {

        private var asset:Asset;
        private var container:DisplayObjectContainer;
        private var content:MovieClip;
        private var display:SignallingAsset;
        private var items:Vector.<WinXPDisplay>;
        private var results:Vector.<WinResultVO>;
        private var itemsPlaying:int;
        private var levelUpSound:SoundProxy;
        private var monsterId:String;
        private var _isPlaying:Boolean;
        public var share:Signal;

        private static const MONSTER:String = "monster";
        private static const TEXT:String = "text";

        public function WinXPDisplayAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Vector.<WinResultVO>, _arg4:SoundProxy, _arg5:String){
            this.share = new Signal();
            this.asset = _arg2;
            this.container = _arg1;
            this.results = _arg3;
            this.levelUpSound = _arg4;
            this.monsterId = _arg5;
            this._isPlaying = false;
            if (_arg2.isComplete){
                this.setup(_arg2);
            } else {
                _arg2.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
            var _local3:String;
            var _local4:Sprite;
            var _local5:Sprite;
            this.content = MovieClip(_arg1.content);
            this.content.stop();
            this.content.btns.sharePanel.visible = false;
            this.display = SignallingAsset(_arg1.content);
            if (!this.display){
                return;
            };
            this.items = new Vector.<WinXPDisplay>(6, true);
            var _local2:int;
            while (_local2 < 6) {
                _local3 = (MONSTER + (_local2 + 1));
                _local4 = Sprite(this.content.getChildByName((_local3 + TEXT)));
                _local5 = Sprite(this.content.getChildByName(_local3));
                this.items[_local2] = new WinXPDisplay(_local4, _local5);
                _local2++;
            };
            if (this._isPlaying){
                this.play();
            };
        }
        override public function play():void{
            var _local2:WinXPDisplay;
            this._isPlaying = true;
            if (!this.asset.isComplete){
                return;
            };
            this.container.addChild(this.asset.self);
            this.display.signal.add(this.onSignal);
            this.itemsPlaying = 0;
            var _local1:int;
            while (_local1 < 6) {
                _local2 = this.items[_local1];
                if (_local1 < this.results.length){
                    _local2.setup(this.results[_local1]);
                } else {
                    _local2.reset();
                };
                _local1++;
            };
            this.content.play();
        }
        private function onSignal(_arg1:Object):void{
            if ((_arg1 is int)){
                this.onPositionReady((int(_arg1) - 1));
            } else {
                if (_arg1 == "complete"){
                    this.onDisplayCompleted();
                } else {
                    if (_arg1 == "share"){
                        this.onShare();
                    };
                };
            };
        }
        private function onShare():void{
            var _local1:WinResultVO = this.results[0];
            this.share.dispatch(_local1.levelupReward.newLevel, _local1.moga.monsterID, _local1.name, this.monsterId);
            this.onDisplayCompleted();
        }
        private function onDisplayCompleted():void{
            this.content.stop();
            this.container.removeChild(this.asset.self);
            this.display.signal.removeAll();
            this.items = null;
            this.results = null;
            this.display = null;
            this.content = null;
            _complete.dispatch(this);
        }
        private function onPositionReady(_arg1:int):void{
            if (_arg1 < this.results.length){
                this.itemsPlaying++;
                this.items[_arg1].play();
                this.items[_arg1].completed.addOnce(this.onItemCompleted);
            };
            if ((((_arg1 == 5)) && (this.itemsPlaying))){
                this.content.stop();
                this.content.btns.sharePanel.visible = true;
                this.content.btns.continueButton.visible = false;
                this.levelUpSound.play();
            };
        }
        private function onItemCompleted(_arg1:WinXPDisplay):void{
            if (--this.itemsPlaying){
                return;
            };
            this.content.play();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win 
