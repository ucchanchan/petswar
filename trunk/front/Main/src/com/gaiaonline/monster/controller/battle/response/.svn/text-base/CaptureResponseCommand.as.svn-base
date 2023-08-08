//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class CaptureResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var monsterDex:DexModel;
		[Inject]
        public var factory:MonsterAssetsFactory;
		[Inject]
        public var mogas:MogaFactory;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var collectionModel:MogaCollectionsModel;

        override public function execute():void{
            var _local2:Boolean;
            var _local3:Boolean;
            var _local4:InventoryItem;
            var _local1:Object = this.event.data;
            _local3 = ((!((_local1.battle_result.user_monster.caught == undefined))) && (!((_local1.battle_result.user_monster.caught == null))));
            _local2 = ((_local3) && (!((_local1.battle_result.user_monster.caught == 0))));
            if (_local3){
                _local4 = this.inventory.getItem(ItemEnum.SEED);
                this.inventory.getItem(ItemEnum.SEED).quantity = (_local4.quantity - 1);
            };
            if (_local2){
                this.handleCaught();
            } else {
                this.handleFailed(_local3);
            };
        }
        private function handleCaught():void{
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_result;
            var _local3:Object = _local2.user_monster.monster_tamed;
            this.model.isCapture = true;
            var _local4:MonsterModel = this.mogas.create(_local3);
            _local4.text = this.text.getMonsterText(_local4.monsterID);
            this.ranch.addMonster(_local4);
            var _local5:MonsterModel = this.model.playerMonster;
            var _local6:MonsterModel = this.model.npcMonster;
            if (((_local2.collection_props) && (_local2.collection_inventory))){
                this.collectionModel.initDropData(_local2.collection_props, _local2.collection_inventory);
            };
            this.model.attack = new AttackResponseVO(_local2, _local5, _local6, this.ranch.team);
            dispatch(new FightEvent(FightEvent.CAPTURE_SUCCESS, _local4));
        }
        private function handleFailed(_arg1:Boolean):void{
            var _local2:Object = this.event.data;
            var _local3:Object = _local2.battle_state;
            var _local4:Object = _local2.battle_result;
            var _local5:MonsterModel = this.model.playerMonster;
            var _local6:MonsterModel = this.model.npcMonster;
            this.model.update(_local3);
            this.model.attack = new AttackResponseVO(_local4, _local5, _local6, this.ranch.team);
            if (_arg1){
                dispatch(new FightEvent(FightEvent.CAPTURE_FAIL));
            } else {
                dispatch(new FightEvent(FightEvent.CAPTURE_DIDNT_TRY));
            };
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
