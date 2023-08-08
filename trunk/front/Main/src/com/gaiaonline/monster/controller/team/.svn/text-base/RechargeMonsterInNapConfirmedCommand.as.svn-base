//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;

    public class RechargeMonsterInNapConfirmedCommand extends Command {

        public var event:DialogEvent;
        public var server:GSIDataService;
        public var inventory:InventoryModel;
        public var sounds:SoundService;

        override public function execute():void{
            var _local1:MonsterModel = this.event.data.target;
            var _local2:InventoryItem = this.inventory.getItem(ItemEnum.COFFEE);
            _local2.quantity = (_local2.quantity - 1);
            _local1.awaken();
            _local1.recharge();
            this.server.rechargeMonsterInNap(_local1);
            dispatch(new NapEvent(NapEvent.RECHARGE_MONSTER, _local1));
            dispatch(new TeamEvent(TeamEvent.UPDATE_TEAM));
            var _local3:SoundProxy = this.sounds.getFX("sounds/recharge.mp3");
            _local3.play();
        }

    }
}//package com.gaiaonline.monster.controller.team 
