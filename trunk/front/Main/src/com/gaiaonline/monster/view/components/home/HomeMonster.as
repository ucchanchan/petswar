//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import org.osflash.signals.natives.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.home.ui.*;
    import com.gaiaonline.monster.service.*;

    public class HomeMonster extends Sprite {

        private const WIDTH:uint = 760;
        private const HEIGHT:uint = 425;
        private const MONSTER_SCALE:Number = 0.75;
        private const MONSTER_BOUNCE_BACK_X:int = 3;
        private const MONSTER_BOUNCE_BACK_Y:int = 1;
        private const WALK_ANIM:String = "walk";
        private const IDLE_ANIM:String = "battleIdle";
        private const STOP_ANIM:String = "stop";

        private var _monster:FightMonster;
        private var _hitLayer:MovieClip;
        private var _tween:GTween;
        private var _monsterClicked:NativeSignal;
        private var _monsterRollOver:NativeSignal;
        private var _monsterRollOut:NativeSignal;
        private var _isInNap:Boolean;
        private var _emote:Sprite;
        private var _messageLayer:Sprite;
        private var _napEffect:Asset;
        private var _timer:NapTimer;
        private var _napEndTime:int;
        private var _currentTime:int;
        private var _napTime:int;

        public function HomeMonster(_arg1:FightMonster, _arg2:MovieClip){
            this._monster = _arg1;
            this._hitLayer = _arg2;
            x = Utils.randRange(200, (this.WIDTH / 2));
            y = Utils.randRange((this.HEIGHT / 2), this.HEIGHT);
            this._monsterClicked = new NativeSignal(this, MouseEvent.CLICK);
            this._monsterRollOver = new NativeSignal(this, MouseEvent.ROLL_OVER);
            this._monsterRollOut = new NativeSignal(this, MouseEvent.ROLL_OUT);
            this._emote = new Sprite();
            this._messageLayer = new Sprite();
            this._monster.buttonMode = true;
            if (_arg1.isComplete){
                this.setupMonster(_arg1);
            } else {
                _arg1.complete.addOnce(this.setupMonster);
            };
        }
        public function getNonShadowMonster():DisplayObject{
            var _local2:DisplayObject;
            var _local4:DisplayObject;
            var _local1:Sprite = (this._monster.content as Sprite);
            if (_local1 == null){
                return (this._monster);
            };
            var _local3:int;
            while (_local3 < _local1.numChildren) {
                _local4 = _local1.getChildAt(_local3);
                if ((((_local2 == null)) || ((_local4.y < _local2.y)))){
                    _local2 = _local4;
                };
                _local3++;
            };
            return (_local2);
        }
        private function setupMonster(_arg1:FightMonster):void{
            addChild(_arg1);
            addChild(this._messageLayer);
            addChild(this._emote);
            this._monster.scaleX = this.MONSTER_SCALE;
            this._monster.scaleY = this.MONSTER_SCALE;
            this.initMonsterMove();
        }
        public function showEmote(_arg1:MonsterEmote):void{
            this._emote.addChild(_arg1);
            _arg1.y = (_arg1.y - 100);
        }
        public function removeEmote():void{
            if (this._emote.numChildren > 0){
                this._emote.removeChildAt(0);
            };
        }
        public function pause():void{
            this._monster.removeEventListener(Event.ENTER_FRAME, this.onUpdateMonster);
            this._monster.playAnim("stop");
            if (this._tween){
                this._tween.paused = true;
                this._tween = null;
            };
        }
        public function resume():void{
            if (!this._isInNap){
                if (this._tween){
                    this._tween.paused = false;
                } else {
                    this.initMonsterMove();
                };
                this._monster.playAnim(this.WALK_ANIM);
                this.startMoveListener();
            };
        }
        public function get monsterRollOut():NativeSignal{
            return (this._monsterRollOut);
        }
        public function get monsterClicked():NativeSignal{
            return (this._monsterClicked);
        }
        public function get monsterRollOver():NativeSignal{
            return (this._monsterRollOver);
        }
        public function requestDragForce():void{
            dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
        }
        public function setInNap(_arg1:Asset, _arg2:NapTimer, _arg3:int, _arg4:int, _arg5:int):void{
            this._isInNap = true;
            this._timer = _arg2;
            this._napTime = _arg3;
            this._napEndTime = _arg4;
            this._currentTime = _arg5;
            this.pause();
            this._monster.playAnim("stop");
            this.scaleX = 1;
            if (this._napEffect){
                this._napEffect.dispose();
            };
            this._napEffect = _arg1;
            if (_arg1.isComplete){
                this.onNapEffectLoaded(_arg1);
            } else {
                _arg1.complete.addOnce(this.onNapEffectLoaded);
            };
        }
        private function onUpdateTimer(_arg1:uint, _arg2:NapTimer):void{
            var _local3:MovieClip = MovieClip(this._napEffect.content).nap;
            _local3.napTimer.text = Utils.formatTime(_arg1);
            _local3.napLifebar.scaleX = ((this._napEndTime - (this._currentTime + _arg2.currentCount)) / this._napTime);
        }
        private function onNapEffectLoaded(_arg1:Asset):void{
            if (this._monster.parent){
                this._monster.parent.removeChild(this._monster);
            };
            var _local2:MovieClip = MovieClip(_arg1.content).nap;
            _local2.napLifebar.scaleX = 0;
            _local2.monster.addChild(this._monster);
            addChild(_arg1.self);
            this._timer.napUpdate.add(this.onUpdateTimer);
        }
        public function resumeAfterNap():void{
            this._isInNap = false;
            this.resume();
            if (((this._napEffect) && (contains(this._napEffect.self)))){
                removeChild(this._napEffect.self);
                this._napEffect.dispose();
            };
            if (this._monster){
                addChild(this._monster);
            };
            if (this._timer){
                this._timer.dispose();
                this._timer = null;
            };
        }
        private function initMonsterMove():void{
            if (!this._isInNap){
                this.startMoveListener();
                this.moveMonster(null, 0);
            };
        }
        private function startMoveListener():void{
            this._monster.addEventListener(Event.ENTER_FRAME, this.onUpdateMonster, false, 0, true);
        }
        private function onUpdateMonster(_arg1:Event):void{
            if (((!(this._hitLayer)) || (this._hitLayer.hitTestPoint(x, y, true)))){
                return;
            };
            this._tween.paused = true;
            this.adjustMonsterPosition();
            this._monster.playAnim(this.IDLE_ANIM);
            this.moveMonster();
        }
        private function moveMonster(_arg1:Point=null, _arg2:int=1):void{
            if (_arg2 != 0){
                _arg2 = Utils.randRange(1, 1.7);
            };
            if (this._monster){
                this._monster.playAnim(this.STOP_ANIM);
            };
            if (!this._hitLayer){
                return;
            };
            if (!_arg1){
                _arg1 = this.nextMonsterPoint();
            };
            var _local3:int = _arg1.x;
            var _local4:int = _arg1.y;
            if (_local3 > this.x){
                this.scaleX = 1;
                this._messageLayer.scaleX = 1;
            } else {
                this.scaleX = -1;
                this._messageLayer.scaleX = -1;
            };
            var _local5:Point = new Point(this.x, this.y);
            var _local6:Point = new Point(_local3, _local4);
            var _local7:uint = this.getDistance(_local5, _local6);
            var _local8:uint = this.getDuration(_local7);
            this._tween = new GTween(this, _local8, {x:_local3, y:_local4}, {onComplete:this.onMonsterMoveComplete, onInit:this.onStartAnim, delay:_arg2});
        }
        private function onStartAnim(_arg1:GTween):void{
            this._monster.playAnim(this.WALK_ANIM);
        }
        private function getDuration(_arg1:uint):uint{
            var _local2:uint = (Math.round((_arg1 / Utils.randRange(40, 120))) + 1);
            return (_local2);
        }
        private function getDistance(_arg1:Point, _arg2:Point):Number{
            var _local3:Number;
            var _local4:Number;
            var _local5:Number;
            _local4 = (_arg2.x - _arg1.x);
            _local5 = (_arg2.y - _arg1.y);
            _local3 = Math.sqrt(((_local4 * _local4) + (_local5 * _local5)));
            return (_local3);
        }
        private function adjustMonsterPosition():void{
            if (this.x > (this.WIDTH * 0.5)){
                this.x = (this.x - this.MONSTER_BOUNCE_BACK_X);
            } else {
                this.x = (this.x + this.MONSTER_BOUNCE_BACK_X);
            };
            if (this.y > (this.HEIGHT * 0.9)){
                this.y = (this.y - this.MONSTER_BOUNCE_BACK_Y);
            } else {
                this.y = (this.y + this.MONSTER_BOUNCE_BACK_Y);
            };
        }
        private function onMonsterMoveComplete(_arg1:GTween):void{
            this.moveMonster();
        }
        public function showNapOption(_arg1:NapOption):void{
            this._messageLayer.addChild(_arg1);
        }
        private function onRemoveNapOption(_arg1:NapOption):void{
            this._messageLayer.removeChild(_arg1);
        }
        public function removeMessaging():void{
            if (this._messageLayer.numChildren > 0){
                this._messageLayer.removeChildAt(0);
            };
        }
        public function dispose(_arg1:Boolean=true):void{
            if (!this._monster){
                return;
            };
            this.pause();
            this._hitLayer = null;
            this._monster.buttonMode = false;
            this._monster.dispose(_arg1);
            this._monster = null;
            this._tween = null;
            this._monsterClicked.removeAll();
            this._monsterClicked = null;
            this._monsterRollOver.removeAll();
            this._monsterRollOver = null;
            this._monsterRollOut.removeAll();
            this._monsterRollOut = null;
        }
        public function get fightMonster():FightMonster{
            return (this._monster);
        }
        public function swarmTo(_arg1:Point):void{
            if (!this._isInNap){
                this.pause();
                this.startMoveListener();
                this.moveMonster(_arg1, 0);
            };
        }
        private function nextMonsterPoint():Point{
            var _local1:Point;
            var _local2:int;
            var _local3:int;
            if (this._hitLayer){
                _local2 = Utils.randRange(0, this.WIDTH);
                _local3 = Utils.randRange(0, this.HEIGHT);
                _local1 = new Point(_local2, _local3);
            };
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
