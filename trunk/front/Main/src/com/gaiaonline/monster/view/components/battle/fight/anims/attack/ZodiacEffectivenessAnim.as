//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.lib.assets.*;

    public class ZodiacEffectivenessAnim implements Anim {

        private var _complete:AnimSignal;
        private var container:DisplayObjectContainer;
        private var _asset:Asset;
        private var amount:Number;
        private var playerZodiac:Asset;
        private var npcZodiac:Asset;
        private var msg:String;
        private var sound:SoundProxy;

        public function ZodiacEffectivenessAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Number, _arg4:Asset, _arg5:Asset, _arg6:String, _arg7:SoundProxy){
            this.container = _arg1;
            this.msg = _arg6;
            this._complete = new AnimSignal();
            this.amount = _arg3;
            this._asset = _arg2;
            _arg1.addChild(this._asset.self);
            this.playerZodiac = _arg4;
            this.npcZodiac = _arg5;
            this.sound = _arg7;
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
            MovieClip(this._asset.content).rpsAnim.rps.rpsText.text = this.msg;
            MovieClip(this._asset.content).rpsAnim.playerZodiac.addChild(this.playerZodiac.self);
            MovieClip(this._asset.content).rpsAnim.npcZodiac.addChild(this.npcZodiac.self);
            MovieClip(this._asset.content).gotoAndPlay(2);
            MovieClip(this._asset.content).rpsAnim.gotoAndPlay(2);
            this.sound.play();
        }
        private function onEffectComplete(_arg1:Object):void{
            if (_arg1 == "endAnim"){
                this._complete.dispatch(this);
            } else {
                this.container.removeChild(this._asset.self);
            };
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
