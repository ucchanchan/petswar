//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class SpecialBattleIntroAnim implements Anim {

        private var _complete:AnimSignal;
        private var container:DisplayObjectContainer;
        private var _asset:Asset;
        private var sound:SoundProxy;

        public function SpecialBattleIntroAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:SoundProxy=null){
            this.container = _arg1;
            this._complete = new AnimSignal();
            this._asset = _arg2;
            _arg1.addChild(this._asset.self);
            this.sound = _arg3;
        }
        public function play():void{
            if (!this._asset.isComplete){
                this._asset.complete.addOnce(this.init);
            } else {
                this.init();
            };
        }
        private function init(_arg1:Asset=null):void{
            var _local2:SignallingAsset = SignallingAsset(this._asset.content);
            _local2.signal.addOnce(this.onEffectComplete);
            MovieClip(this._asset.content).gotoAndPlay(2);
            if (this.sound){
                this.sound.play();
            };
        }
        private function onEffectComplete(_arg1:Object):void{
            this.container.removeChild(this._asset.self);
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
