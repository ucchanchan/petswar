//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.monster {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class MonsterAnim extends BasicAnim {

        protected var _pending:ParallelAsyncs;
        protected var _asset:Asset;
        protected var _monster:Asset;
        protected var _isPlaying:Boolean;
        protected var _container:DisplayObjectContainer;
        protected var _parent:DisplayObjectContainer;
        protected var _signaller:SignallingAsset;

        public function MonsterAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset){
            this._container = _arg1;
            this._pending = new ParallelAsyncs("MonsterAnimParallel");
            this._pending.add((this._asset = _arg2));
            this._pending.add((this._monster = _arg3));
        }
        override public function play():void{
            if (this._isPlaying){
                return;
            };
            this._isPlaying = true;
            if (this._pending.isComplete){
                this.setup(this._pending);
            } else {
                this._pending.complete.addOnce(this.setup);
            };
            this._pending.init();
        }
        protected function setup(_arg1:ParallelAsyncs):void{
            var _local2:MovieClip = MovieClip(this._asset.content);
            this._signaller = SignallingAsset(_local2);
            this._signaller.signal.add(this.onSignal);
            this._parent = this._monster.self.parent;
            var _local3:DisplayObjectContainer = DisplayObjectContainer(_local2.monster);
            if (_local3){
                _local3.addChild(this._monster.self);
            };
            this._container.addChild(this._asset.self);
            _local2.gotoAndPlay(1);
        }
        protected function onSignal(_arg1:Object):void{
            this.completeEffect();
        }
        protected function completeEffect():void{
            if (((this._parent) && (!((this._parent == this._container))))){
                this._parent.addChild(this._monster.self);
            };
            this._container.removeChild(this._asset.self);
            this._signaller.signal.removeAll();
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.monster 
