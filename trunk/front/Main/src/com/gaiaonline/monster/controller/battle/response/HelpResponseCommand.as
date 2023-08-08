//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class HelpResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var collectionModel:MogaCollectionsModel;
		[Inject]
        public var friends:FriendsModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var mogas:MogaFactory;
		[Inject]
        public var actions:ActionsFactory;

        override public function execute():void{
            var _local4:Boolean;
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_state;
            var _local3:Object = _local1.battle_result;
            if (((!((_local3.error == null))) || ((_local2 == null)))){
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 127));
                return;
            };
            this.model.update(_local2);
            if (((_local3.collection_props) && (_local3.collection_inventory))){
                this.collectionModel.initDropData(_local3.collection_props, _local3.collection_inventory);
            };
            _local4 = ((!((_local3.user_monster.friend_id == undefined))) && (!((_local3.user_monster.friend_id == null))));
            if (_local4){
                this.handleUsedWhistle();
            } else {
                this.handleLostTurn();
            };
        }
        private function handleUsedWhistle():void{
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_state;
            var _local3:Object = _local1.battle_result;
            var _local4:InventoryItem = this.inventory.getItem(ItemEnum.WHISTLE);
            this.inventory.getItem(ItemEnum.WHISTLE).quantity = (_local4.quantity - 1);
            var _local5:MonsterModel = this.model.npcMonster;
            this.model.friend = this.parseFriendAttack(_local3.user_monster, _local5);
            this.model.attack = new AttackResponseVO(_local3, this.model.playerMonster, _local5, this.ranch.team);
            dispatch(new FightEvent(FightEvent.FRIEND_HELP));
        }
        private function handleLostTurn():void{
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_result;
            var _local3:MonsterModel = this.model.playerMonster;
            var _local4:MonsterModel = this.model.npcMonster;
            this.model.attack = new AttackResponseVO(_local2, _local3, _local4, this.ranch.team);
            dispatch(new FightEvent(FightEvent.FRIEND_HELP_LOST_TURN));
        }
        private function parseFriendAttack(_arg1:Object, _arg2:MonsterModel):Friend{
            var _local3:Friend = this.friends.getFriendByID(_arg1.friend_id);
            var _local4:MonsterModel = this.mogas.create(_arg1.friend_monster);
            _local4.text = this.text.getMonsterText(_local4.monsterID);
            _local3.attack = new AttackResultVO(true, _local4, _arg2, _arg1);
            _local3.attack.attackingMove = this.model.playerMonster.actions.getAction(_arg1.attack);
            _local3.monster = _local4;
            return (_local3);
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
