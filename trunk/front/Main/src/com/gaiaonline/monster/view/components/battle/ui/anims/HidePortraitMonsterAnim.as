//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui.anims {
    import com.gskinner.motion.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gskinner.motion.easing.*;

    public class HidePortraitMonsterAnim extends BasicAnim {

        private var portrait:BattleUIPortrait;

        private static const DURATION:Number = 0.4;

        public function HidePortraitMonsterAnim(_arg1:BattleUIPortrait){
            this.portrait = _arg1;
        }
        override public function play():void{
            new GTween(this.portrait.container, DURATION, {x:-180}, {ease:Quadratic.easeIn, onComplete:this.onTweenComplete});
        }
        private function onTweenComplete(_arg1:GTween):void{
            this.portrait = null;
            complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui.anims 
