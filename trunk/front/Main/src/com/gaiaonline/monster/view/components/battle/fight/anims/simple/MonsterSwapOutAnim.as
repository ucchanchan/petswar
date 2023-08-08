//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import com.gskinner.motion.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gskinner.motion.easing.*;

    public class MonsterSwapOutAnim implements Anim {

        private var monster:FightMonster;
        private var _complete:AnimSignal;

        private static const FADE_TIME:Number = 0.8;

        public function MonsterSwapOutAnim(_arg1:FightMonster){
            this.monster = _arg1;
            if (!_arg1){
                throw (new Error("MonsterSwapOutAnim didn't get a monster!"));
            };
            this._complete = new AnimSignal();
        }
        public function play():void{
            var _local1:GTween = new GTween(this.monster, FADE_TIME, {alpha:0}, {ease:Quadratic.easeIn});
            _local1.onComplete = this.dispatchComplete;
        }
        private function dispatchComplete(_arg1:GTween):void{
            if (this.monster.parent){
                this.monster.parent.removeChild(this.monster);
            };
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
