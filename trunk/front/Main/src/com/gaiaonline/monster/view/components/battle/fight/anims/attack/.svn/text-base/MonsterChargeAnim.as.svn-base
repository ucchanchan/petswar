//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class MonsterChargeAnim extends BasicAnim {

        private var _asset:Asset;
        private var _monster:FightMonster;
        private var _autoComplete:int;
        private var _isPlaying:Boolean;
        private var _isFinished:Boolean;
        private var _container:DisplayObjectContainer;
        private var _signaller:SignallingAsset;

        private static const MONSTER:String = "monster";

        public function MonsterChargeAnim(_arg1:Asset, _arg2:FightMonster, _arg3:int=-1){
            this._asset = _arg1;
            this._monster = _arg2;
            if (!_arg2){
                throw (new Error("throw a wobbly!"));
            };
            this._autoComplete = _arg3;
            this._isFinished = false;
            this._isPlaying = false;
        }
        override public function play():void{
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            if (this._asset.isComplete){
                this.setup(this._asset);
            } else {
                this._asset.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
            var _local2:MovieClip = MovieClip(this._asset.content);
            this._signaller = SignallingAsset(_local2);
            if (this._isFinished){
                this._signaller.signal.addOnce(this.onSignal);
            } else {
                if (this._autoComplete != -1){
                    this._signaller.signal.add(this.onLoop);
                    this._autoComplete = (this._autoComplete + getTimer());
                };
            };
            this._container = this._monster.parent;
            var _local3:DisplayObjectContainer = DisplayObjectContainer(_local2.getChildByName(MONSTER));
            if (_local3){
                _local3.addChild(this._monster);
            };
            this._container.addChild(this._asset.self);
        }
        private function onLoop(_arg1:Object):void{
            if (getTimer() < this._autoComplete){
                return;
            };
            this._signaller.signal.remove(this.onLoop);
            this.onSignal(_arg1);
        }
        public function finish():void{
            if (this._isFinished){
                return;
            };
            this._isFinished = true;
            if (this._signaller){
                this._signaller.signal.addOnce(this.onSignal);
            };
        }
        private function onSignal(_arg1:Object):void{
            this._monster.x = 0;
            this._monster.y = 0;
            if (this._monster.parent != this._container){
                this._container.addChild(this._monster);
            };
            this._container.removeChild(this._asset.self);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
