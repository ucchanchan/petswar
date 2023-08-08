//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class SwapInNPCAnim implements Anim {

        private var view:Fight;
        private var monster:FightMonster;
        private var _complete:AnimSignal;

        public function SwapInNPCAnim(_arg1:Fight, _arg2:FightMonster){
            this.view = _arg1;
            this.monster = _arg2;
            this._complete = new AnimSignal();
        }
        public function play():void{
            this.view.npc = this.monster;
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
