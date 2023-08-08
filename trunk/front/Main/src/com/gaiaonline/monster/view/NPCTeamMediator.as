//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.smallteam.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.smallteam.anim.*;

    public class NPCTeamMediator extends Mediator {

		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var battle:BattleModel;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var view:NPCTeam;

        override public function onRegister():void{
            eventDispatcher.addEventListener(NPCTeamEvent.UPDATE_TEAM, this.onUpdateTeam);
            eventDispatcher.addEventListener(NPCTeamEvent.UPDATE_MONSTER, this.onUpdateMonster);
            this.setTeam(this.battle.npc.monsters);
            this.setNpcPortrait(this.battle.npc);
            this.view.isEnabled = false;
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(NPCTeamEvent.UPDATE_TEAM, this.onUpdateTeam);
            eventDispatcher.removeEventListener(NPCTeamEvent.UPDATE_MONSTER, this.onUpdateMonster);
            this.view.selected.removeAll();
        }
        private function setNpcPortrait(_arg1:NpcVO):void{
            if (((_arg1) && (!((_arg1.id == -1))))){
                this.view.npc = this.assets.npcPortrait(_arg1.id);
            };
        }
        private function setTeam(_arg1:Vector.<MonsterModel>):void{
            var _local5:SmallTeamVO;
            var _local6:MonsterModel;
            var _local2:uint = _arg1.length;
            var _local3:Vector.<SmallTeamVO> = new Vector.<SmallTeamVO>(_local2, true);
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = new SmallTeamVO();
                _local6 = _arg1[_local4];
                _local5.monster = _local6;
                _local5.icon = this.monsters.monsterIconByID(_local6.monsterID);
                _local3[_local4] = _local5;
                _local4++;
            };
            this.view.setTeam(_local3);
        }
        private function onUpdateTeam(_arg1:NPCTeamEvent):void{
            this.view.update();
        }
        private function onUpdateMonster(_arg1:NPCTeamEvent):void{
            var _local2:MonsterModel = _arg1.data;
            this.view.updateMonster(_local2);
        }
        private function onMonsterSelected(_arg1:MonsterModel):void{
            this.view.isEnabled = false;
            dispatch(new TeamEvent(TeamEvent.MONSTER_SELECTED, _arg1));
        }

    }
}//package com.gaiaonline.monster.view 
