//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class CaptureActionCommand extends Command {

		[Inject]
        public var event:BattleActionEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var gateway:GSIDataService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var text:TextService;

        private static const CANNOT_TAME_MONSTER_MESSAGE:String = "CANNOT_TAME_MONSTER_MESSAGE";

        override public function execute():void{
            var _local4:String;
            var _local5:DialogVO;
            var _local1:MonsterModel = this.model.playerMonster;
            var _local2:MonsterModel = this.model.npcMonster;
            var _local3:InventoryItem = this.inventory.getItem(ItemEnum.SEED);
            if (_local3.quantity == 0){
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 131));
                return;
            };
            if (_local2.canTame){
                this.model.state = BattleState.CAPTURE_MONSTER_PENDING;
                this.gateway.capture(this.model.id, _local1.id, String(this.event.data));
                dispatch(new FightEvent(FightEvent.INITIATE_PLAYER_CAPTURE_TRY));
            } else {
                _local4 = this.text.getText(CANNOT_TAME_MONSTER_MESSAGE, {MONSTER:_local2.name});
                _local5 = new DialogVO(_local4, DialogVO.OK_ONLY);
                dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local5));
            };
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
