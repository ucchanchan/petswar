//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class SetMonsterHPAnim extends BasicAnim {

        private var monster:MonsterModel;
        private var hp:int;

        public function SetMonsterHPAnim(_arg1:MonsterModel, _arg2:int){
            this.monster = _arg1;
            this.hp = _arg2;
        }
        override public function play():void{
            this.monster.hp = this.hp;
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
