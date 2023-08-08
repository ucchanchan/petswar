//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui.anims {
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gskinner.motion.easing.*;

    public class ShowPortraitMonsterAnim extends BasicAnim {

        private var portrait:BattleUIPortrait;
        private var background:Asset;
        private var monster:Asset;
        private var parallel:ParallelAsyncs;

        private static const DURATION:Number = 0.4;

        public function ShowPortraitMonsterAnim(_arg1:BattleUIPortrait, _arg2:Asset, _arg3:Asset){
            this.portrait = _arg1;
            this.background = _arg2;
            this.monster = _arg3;
        }
        override public function play():void{
            this.parallel = new ParallelAsyncs("ShowPortraitMonsterAnimParallel");
            this.parallel.add(this.background);
            this.parallel.add(this.monster);
            if (this.parallel.isComplete){
                this.actuallyPlay(this.parallel);
            } else {
                this.parallel.complete.addOnce(this.actuallyPlay);
            };
            this.parallel.init();
        }
        private function actuallyPlay(_arg1:Async):void{
            this.parallel = null;
            this.portrait.background = this.background;
            this.portrait.monster = this.monster;
            new GTween(this.portrait.container, DURATION, {x:0}, {ease:Quadratic.easeOut, onComplete:this.onSecondTweenComplete});
        }
        private function onSecondTweenComplete(_arg1:GTween):void{
            this.portrait = null;
            this.background = null;
            this.monster = null;
            complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui.anims 
