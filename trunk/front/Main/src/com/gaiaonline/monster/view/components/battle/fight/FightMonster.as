//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;

    public class FightMonster extends AssetWrapper {

        private var _pending:DisplayObject;
        private var _content:MovieClip;
        private var _labels:Dictionary;
        private var _anim:String;
        private var _useButt:Boolean;
        private var _attacked:Signal;
        private var frameEndsAttack:uint;

        private static const BATTLE_IDLE:String = "battleIdle";

        public function FightMonster(_arg1:Asset){
            super(_arg1);
            this._anim = BATTLE_IDLE;
            this._attacked = new Signal();
        }
        override public function get content():DisplayObject{
            return (this._content);
        }
        public function playAnim(_arg1:String):void{
            this._anim = _arg1;
            if (!this._content){
                return;
            };
            if (((this._labels) && (this._labels[_arg1]))){
                this._content.gotoAndPlay(this._labels[_arg1]);
            } else {
                this._content.stop();
            };
        }
        public function attack():void{
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.playAnim("attack");
        }
        private function onEnterFrame(_arg1:Event):void{
            if (this._content.currentFrameLabel != "attack"){
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this._attacked.dispatch();
            };
        }
        override protected function onComplete(_arg1:Asset):void{
            this._content = MovieClip(_asset.content).monster;
            addChild(_asset.self);
            if (this._pending){
                removeChild(this._pending);
            };
            this._pending = null;
            this.parseLabels();
            this.playAnim(this._anim);
        }
        private function parseLabels():void{
            var _local1:uint;
            var _local3:FrameLabel;
            var _local4:String;
            var _local5:int;
            this._labels = new Dictionary();
            var _local2:Vector.<uint> = new Vector.<uint>();
            for each (_local3 in this._content.currentLabels) {
                _local4 = _local3.name;
                _local5 = _local3.frame;
                this._labels[_local4] = _local5;
                if (_local4 == "attack"){
                    _local1 = _local5;
                } else {
                    _local2.push(_local5);
                };
            };
            _local2.sort(this.compareFunction);
            while (_local2[0] < _local1) {
                _local2.shift();
            };
            this.frameEndsAttack = (_local2[0] - 1);
        }
        private function compareFunction(_arg1:uint, _arg2:uint):int{
            return (((_arg1 < _arg2)) ? -1 : ((_arg1 > _arg2)) ? 1 : 0);
        }
        public function get attacked():Signal{
            return (this._attacked);
        }
        public function get useButt():Boolean{
            return (this._useButt);
        }
        public function set useButt(_arg1:Boolean):void{
            this._useButt = _arg1;
            _asset.self.scaleX = (this._useButt) ? -1 : 1;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight 
