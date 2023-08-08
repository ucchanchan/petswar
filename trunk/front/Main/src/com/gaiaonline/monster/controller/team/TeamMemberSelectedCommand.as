//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.battle.swap.*;

    public class TeamMemberSelectedCommand extends Command {

		[Inject]
        public var event:TeamEvent;
		[Inject]
        public var battle:BattleModel;
		[Inject]
        public var text:TextService;
        private var current:MonsterModel;
        private var target:MonsterModel;

        private static const SWAP_MONSTERS:String = "SWAP_MONSTERS";

        override public function execute():void{
            var _local1:String;
            this.current = this.battle.playerMonster;
            this.target = this.event.data;
            if (this.current == this.target){
                dispatch(new TeamEvent(TeamEvent.ENABLE_SMALLTEAM));
                return;
            };
            if (!this.target){
                _local1 = ("Attempting to swap to null team member from battle state " + this.battle.state);
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 130));
                return;
            };
            switch (this.battle.state){
                case BattleState.BEFORE_BATTLE_HAS_STARTED:
                case BattleState.SET_FIRST_MONSTER:
                case BattleState.SET_FIRST_MONSTER_PENDING:
                    this.changeMonsterBeforeBattleStarts();
                    break;
                default:
                    this.changeMonsterDuringBattle();
                    break;
            };
        }
        private function changeMonsterBeforeBattleStarts():void{
            this.battle.state = BattleState.SET_FIRST_MONSTER_PENDING;
            this.battle.playerMonster = this.target;
            dispatch(new FightEvent(FightEvent.PLAYER_CHANGE_FIRST_MONSTER, this.target));
        }
        private function changeMonsterDuringBattle():void{
            if (((this.current) && ((this.current.hp > 0)))){
                this.changeMonsterTactically();
            } else {
                this.changeMonsterBecausePreviousMonsterIsDead();
            };
        }
        private function changeMonsterTactically():void{
            var _local1:String = this.text.getText(SWAP_MONSTERS, {TARGET:this.target.name});
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.YES_NO);
            _local2.yes = SwapUserConfirmedCommand;
            _local2.no = SwapUserCancelledCommand;
            _local2.data = this.target;
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
        }
        private function changeMonsterBecausePreviousMonsterIsDead():void{
            this.battle.state = BattleState.FORCED_SWAP_MONSTER_PENDING;
            this.battle.playerMonster = this.target;
            dispatch(new FightEvent(FightEvent.SWAP_DEAD_MONSTER, this.target));
        }

    }
}//package com.gaiaonline.monster.controller.team 
