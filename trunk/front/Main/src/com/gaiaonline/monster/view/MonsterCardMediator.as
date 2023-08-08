//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import com.gaiaonline.monster.view.components.home.ui.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;

    public class MonsterCardMediator extends Mediator {

		[Inject]
        public var view:MonsterCard;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var inventory:InventoryModel;

        override public function onRegister():void{
            this.view.dispose();
            this.view.initCard.add(this.onInitCard);
            this.view.rechargeMonster.add(this.onRechargeMonster);
            this.view.enterNap.add(this.onEnterNap);
            this.view.wakeUpMonster.add(this.onWakeUpMonster);
        }
        override public function onRemove():void{
            this.view.enterNap.removeAll();
            this.view.rechargeMonster.removeAll();
            this.view.initCard.removeAll();
            this.view.wakeUpMonster.removeAll();
            this.view.dispose();
        }
        private function onInitCard(_arg1:MonsterModel):void{
            var _local3:int;
            var _local2:MonsterCardInfoVO = new MonsterCardInfoVO();
            _local2.currentTime = this.timer.currentTime;
            _local2.model = _arg1;
            if (_arg1.napEndTime){
                _local3 = (_arg1.napEndTime - this.timer.currentTime);
                _local2.napTimer = new NapTimer(_local3, _arg1);
            };
            _local2.zodiac = this.assets.zodiacIcon(_arg1.zodiac);
            _local2.inventory = this.inventory;
            this.view.populateInfo(_local2);
        }
        private function onEnterNap(_arg1:MonsterModel):void{
            dispatch(new TeamEvent(TeamEvent.PUT_MONSTER_IN_NAP, _arg1));
        }
        private function onRechargeMonster(_arg1:MonsterModel):void{
            var _local2:uint = this.inventory.getItem(ItemEnum.COFFEE).quantity;
            if (_local2 == 0){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
            } else {
                if (_arg1.napEndTime){
                    dispatch(new TeamEvent(TeamEvent.RECHARGE_MONSTER_IN_NAP, _arg1));
                } else {
                    dispatch(new TeamEvent(TeamEvent.RECHARGE_MONSTER, _arg1));
                };
            };
        }
        private function onWakeUpMonster(_arg1:MonsterModel):void{
            dispatch(new TeamEvent(TeamEvent.AWAKEN_MONSTER, _arg1));
        }

    }
}//package com.gaiaonline.monster.view 
