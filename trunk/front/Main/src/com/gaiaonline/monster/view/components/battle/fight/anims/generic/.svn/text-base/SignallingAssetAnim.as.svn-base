//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.generic {
    import flash.display.*;
    import alecmce.ui.*;
    import gaia.lib.assets.*;

    public class SignallingAssetAnim extends BasicAnim {

        protected var container:DisplayObjectContainer;
        protected var content:MovieClip;
        protected var asset:Asset;
        protected var signaller:SignallingAsset;
        protected var isPlaying:Boolean;

        public function SignallingAssetAnim(_arg1:DisplayObjectContainer, _arg2:Asset){
            this.container = _arg1;
            this.asset = _arg2;
            if (_arg2.isComplete){
                this.setup(_arg2);
            } else {
                _arg2.complete.addOnce(this.setup);
            };
        }
        protected function setup(_arg1:Asset):void{
            if (this.isPlaying){
                this.play();
            };
        }
        override public function play():void{
            if (!this.isPlaying){
                this.isPlaying = true;
            };
            if (!this.asset.isComplete){
                return;
            };
            this.content = MovieClip(this.asset.content);
            this.signaller = SignallingAsset(this.content);
            this.container.addChild(this.asset.self);
            this.actuallyPlay();
        }
        protected function actuallyPlay():void{
            this.container.removeChild(this.asset.self);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.generic 
