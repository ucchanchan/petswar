//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class MonsterInternalAttackAnim extends BasicAnim implements IMonsterAttackAnim {

        private var monster:FightMonster;
        private var _hit:AnimSignal;

        public function MonsterInternalAttackAnim(_arg1:FightMonster){
            this._hit = new AnimSignal();
            this.monster = _arg1;
        }
        override public function play():void{
            this.monster.attacked.addOnce(this.onMonsterAttacked);
            this.monster.attack();
            this._hit.dispatch(this);
        }
        private function onMonsterAttacked():void{
            _complete.dispatch(this);
            this.monster = null;
        }
        public function get hit():AnimSignal{
            return (this._hit);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
