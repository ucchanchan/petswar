//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight {
    import flash.events.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.model.battle.*;

    public class DeselectDeadMonster extends BasicAnim {

        private var eventDispatcher:IEventDispatcher;
        private var battle:BattleModel;

        public function DeselectDeadMonster(_arg1:IEventDispatcher, _arg2:BattleModel){
            this.eventDispatcher = _arg1;
            this.battle = _arg2;
        }
        override public function play():void{
            this.eventDispatcher.dispatchEvent(new TeamEvent(TeamEvent.DESELECT_MONSTER));
            this.eventDispatcher.dispatchEvent(new TeamEvent(TeamEvent.UPDATE_TEAM));
            this.battle.playerMonster = null;
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight 
