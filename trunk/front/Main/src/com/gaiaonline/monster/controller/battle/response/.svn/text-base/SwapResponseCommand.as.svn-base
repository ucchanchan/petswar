//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.*;

    public class SwapResponseCommand extends Command {

        public var event:BattleResponseEvent;
        public var model:BattleModel;
        public var roster:HomeRanchModel;
        public var mogas:MogaFactory;
        public var data:Object;
        public var state:Object;
        public var result:Object;

        override public function execute():void{
            this.getData();
            var _local1:MonsterModel = this.mogas.read(this.result.user_monster.tap_in.id);
            var _local2:int = _local1.hp;
            if (!this.updateData()){
                return;
            };
            this.processAttack();
            this.model.playerMonster = _local1;
            dispatch(new FightEvent(FightEvent.SWAP_PLAYER_MONSTER, _local2));
        }
        protected function getData():void{
            this.data = this.event.data;
            this.state = this.data.battle_state;
            this.result = this.data.battle_result;
        }
        protected function updateData():Boolean{
            var _local1:Boolean = ((!((this.result.error == null))) || ((this.state == null)));
            if (_local1){
                this.dataError();
            } else {
                this.model.update(this.state);
            };
            return (!(_local1));
        }
        protected function processAttack():void{
            var _local1:MonsterModel = this.model.playerMonster;
            var _local2:MonsterModel = this.model.npcMonster;
            this.model.attack = new AttackResponseVO(this.result, _local1, _local2, this.roster.team);
        }
        protected function dataError():void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.SERVER_REPORTED_ERROR_AFTER_PLAYER_SWAP));
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
