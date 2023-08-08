//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;

    public class StatusHpSetAnim implements Anim {

        private var stats:BattleUIStatus;
        private var hp:int;
        private var max:int;
        private var _complete:AnimSignal;

        public function StatusHpSetAnim(_arg1:BattleUIStatus, _arg2:int, _arg3:int){
            this.stats = _arg1;
            this.hp = _arg2;
            this.max = _arg3;
            this._complete = new AnimSignal();
        }
        public function play():void{
            this.stats.setHp(this.hp, this.max);
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
