//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.controller.*;

    public class RechargeMonsterConfirmedCommand extends AsyncCommand {

		[Inject]
        public var event:DialogEvent;
		[Inject]
        public var process:RechargeMonster;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var battle:BattleModel;
        protected var target:MonsterModel;

        private static const UNABLE_TO_RECHARGE_MONSTER:String = "UNABLE_TO_RECHARGE_MONSTER";

        override public function execute():void{
            this.target = this.event.data.target;
            this.process.monster = this.target;
            hook(this.process, this.onComplete, this.onError);
        }
        protected function onComplete(_arg1:Async):void{
            var _local2:InventoryItem = this.inventory.getItem(ItemEnum.COFFEE);
            _local2.quantity = (_local2.quantity - 1);
            this.target.awaken();
            this.target.recharge();
            dispatch(new NapEvent(NapEvent.RECHARGE_MONSTER, this.target));
            dispatch(new TeamEvent(TeamEvent.UPDATE_TEAM));
            var _local3:SoundProxy = this.sounds.getFX("sounds/recharge.mp3");
            _local3.play();
        }
        protected function onError(_arg1:Async, _arg2:String=""):void{
            _arg1.complete.removeAll();
            _arg2 = this.text.getText(UNABLE_TO_RECHARGE_MONSTER);
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 114));
            commandMap.release(this);
        }

    }
}//package com.gaiaonline.monster.controller.team 
