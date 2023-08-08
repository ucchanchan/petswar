//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.combatlog.event.*;

    public class FadeBuffsAnim extends BasicAnim {

        private var dispatcher:IEventDispatcher;
        private var monster:MonsterModel;
        private var status:BattleUIStatus;
        private var text:TextService;

        public function FadeBuffsAnim(_arg1:IEventDispatcher, _arg2:MonsterModel, _arg3:BattleUIStatus, _arg4:TextService){
            this.dispatcher = _arg1;
            this.monster = _arg2;
            this.status = _arg3;
            this.text = _arg4;
        }
        override public function play():void{
            var _local2:BuffVO;
            var _local1:Vector.<BuffVO> = this.status.updateBuffs(this.monster);
            for each (_local2 in _local1) {
                this.fadeBuff(_local2);
            };
            _complete.dispatch(this);
        }
        private function fadeBuff(_arg1:BuffVO):void{
            var _local2:String = this.text.describeBuffFade(_arg1, this.monster.name);
            var _local3:Boolean = (((_arg1.result == BuffResult.PROPERTY_MODIFIER)) && ((_arg1.fn.input == "hp")));
            this.dispatcher.dispatchEvent(new CombatLogEvent(CombatLogEvent.LOG, _local2));
            if (_local3){
                this.status.setHp(this.monster.hp, this.monster.naturalMaxHP);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
