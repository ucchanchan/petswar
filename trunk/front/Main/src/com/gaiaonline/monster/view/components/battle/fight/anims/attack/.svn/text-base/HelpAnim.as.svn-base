//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class HelpAnim implements Anim {

        private var _complete:AnimSignal;
        private var _container:DisplayObjectContainer;
        private var _parent:DisplayObjectContainer;
        private var _animIn:Asset;
        private var _attack:Anim;
        private var _animOut:Asset;
        private var _pending:ParallelAsyncs;
        private var _player:FightMonster;
        private var _friend:FightMonster;
        private var _isPlaying:Boolean;

        public function HelpAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Anim, _arg4:Asset, _arg5:FightMonster, _arg6:FightMonster){
            this._complete = new AnimSignal();
            this._container = _arg1;
            this._animIn = _arg2;
            this._attack = _arg3;
            this._animOut = _arg4;
            this._player = _arg5;
            this._friend = _arg6;
            this._pending = new ParallelAsyncs("HelpAnim-Parallel");
            this._pending.add(_arg2);
            this._pending.add(_arg4);
            this._pending.add(_arg5);
            this._pending.add(_arg6);
            this._pending.init();
        }
        public function play():void{
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            if (this._pending.isComplete){
                this.animateFriendIn(this._pending);
            } else {
                this._pending.complete.addOnce(this.animateFriendIn);
            };
        }
        private function animateFriendIn(_arg1:ParallelAsyncs):void{
            var _local2:MovieClip;
            _local2 = MovieClip(this._animIn.content);
            var _local3:SignallingAsset = SignallingAsset(_local2);
            _local3.signal.addOnce(this.onAnimateFriendInComplete);
            this._parent = this._player.parent;
            _local2.monster.addChild(this._player);
            _local2.friend.addChild(this._friend);
            var _local4:Point = this._parent.localToGlobal(new Point(0, 0));
            var _local5:DisplayObject = this._animIn.self;
            _local5.x = _local4.x;
            _local5.y = _local4.y;
            this._container.addChild(_local5);
            _local2.play();
        }
        private function onAnimateFriendInComplete(_arg1:Object):void{
            var _local2:Point = new Point(this._player.x, this._player.y);
            _local2 = this._player.parent.localToGlobal(_local2);
            _local2 = this._parent.globalToLocal(_local2);
            this._player.x = _local2.x;
            this._player.y = _local2.y;
            this._parent.addChild(this._player);
            if (_arg1 == "complete"){
                this.showAttack();
            };
        }
        private function showAttack():void{
            var _local1:DisplayObject = this._animIn.self;
            _local1.parent.removeChild(_local1);
            this._parent.addChild(this._friend);
            this._attack.complete.addOnce(this.onAttackComplete);
            this._attack.play();
        }
        private function onAttackComplete(_arg1:Anim):void{
            this.animateFriendOut();
        }
        private function animateFriendOut():void{
            var _local1:MovieClip = MovieClip(this._animOut.content);
            var _local2:SignallingAsset = SignallingAsset(_local1);
            _local2.signal.addOnce(this.onAnimateFriendOutComplete);
            this._player.x = 0;
            this._player.y = 0;
            _local1.monster.addChild(this._player);
            _local1.friend.addChild(this._friend);
            this._parent.addChild(this._animOut.self);
            _local1.play();
        }
        private function onAnimateFriendOutComplete(_arg1:Object):void{
            if (_arg1 == "complete"){
                this.completeEffect();
            };
        }
        private function completeEffect():void{
            this._parent.addChild(this._player);
            this._parent.removeChild(this._animOut.self);
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
