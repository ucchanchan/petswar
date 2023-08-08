//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.combattext {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class MiscSCTAnim extends BasicAnim {

        private var container:DisplayObjectContainer;
        private var asset:Asset;
        private var block:Boolean;
        private var dX:Number;
        private var ddX:Number;
        private var dY:Number;
        private var ddY:Number;
        private var content:DisplayObject;
        private var isPlaying:Boolean;

        private static const DURATION:Number = 0.2;

        public function MiscSCTAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Boolean){
            this.container = _arg1;
            this.asset = _arg2;
            this.block = _arg3;
            this.dX = 0;
            this.ddX = ((Math.random() * 0.08) - 0.04);
            this.dY = -10;
            this.ddY = 0.4;
            if (_arg2.isComplete){
                this.setup(_arg2);
            } else {
                _arg2.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
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
            this.content = this.asset.content;
            this.content.x = 0;
            this.content.y = 0;
            this.content.addEventListener(Event.ENTER_FRAME, this.iterate);
            this.container.addChild(this.asset.self);
            if (!this.block){
                _complete.dispatch(this);
            };
        }
        private function iterate(_arg1:Event):void{
            this.content.x = (this.content.x + this.dX);
            this.content.y = (this.content.y + this.dY);
            this.dX = (this.dX + this.ddX);
            this.dY = (this.dY + this.ddY);
            if (this.dY >= 0){
                this.content.removeEventListener(Event.ENTER_FRAME, this.iterate);
                new GTween(this.content, DURATION, {alpha:0}, {onComplete:this.onComplete});
                if (this.block){
                    _complete.dispatch(this);
                };
            };
        }
        private function onComplete(_arg1:GTween):void{
            this.content = null;
            this.container.removeChild(this.asset.self);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.combattext 
