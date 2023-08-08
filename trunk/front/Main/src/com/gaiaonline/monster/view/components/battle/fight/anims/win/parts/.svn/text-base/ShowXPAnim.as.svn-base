//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win.parts {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.win.*;

    public class ShowXPAnim extends BasicAnim implements Anim {

        private var display:WinXPDisplay;
        private var clip:Sprite;
        private var xp:int;
        private var maxXP:int;
        private var dXP:int;
        private var targetXP:int;
        private var currentXP:int;

        private static const SPEED:Number = 0.5;

        public function ShowXPAnim(_arg1:WinXPDisplay, _arg2:Sprite, _arg3:int, _arg4:int, _arg5:int){
            this.clip = _arg2;
            this.display = _arg1;
            this.xp = 0;
            this.maxXP = _arg4;
            this.targetXP = _arg3;
            this.currentXP = _arg5;
            this.dXP = (SPEED * this.targetXP);
            if (this.dXP < 1){
                this.dXP = 1;
            };
        }
        override public function play():void{
            this.display.currentXP = this.currentXP;
            this.display.maxXP = this.maxXP;
            this.clip.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
        private function onEnterFrame(_arg1:Event):void{
            this.xp = (this.xp + this.dXP);
            var _local2 = (this.xp >= this.targetXP);
            if (_local2){
                this.display.xp = this.targetXP;
                this.clip.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                _complete.dispatch(this);
            } else {
                this.display.xp = this.xp;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win.parts 
