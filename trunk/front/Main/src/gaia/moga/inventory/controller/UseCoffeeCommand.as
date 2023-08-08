//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.controller {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.inventory.events.*;

    public class UseCoffeeCommand extends Command {

        public var event:UseCoffeeEvent;
        public var inventory:InventoryModel;
        public var text:TextService;
        public var process:RechargeMonster;

        private static const COFFEE_NOT_NEEDED:String = "COFFEE_NOT_NEEDED";

        override public function execute():void{
            var _local1:MonsterModel = this.event.moga;
            var _local2:InventoryItem = this.inventory.getItem(ItemEnum.COFFEE);
            if (_local1.canNap){
                this.recharge(_local1, _local2);
            } else {
                this.abort(_local1, _local2);
            };
        }
        private function recharge(_arg1:MonsterModel, _arg2:InventoryItem):void{
            this.process.monster = _arg1;
            this.process.init();
            _arg1.recharge();
            _arg2.quantity--;
        }
        private function abort(_arg1:MonsterModel, _arg2:InventoryItem):void{
            var _local3:String = this.text.getText(COFFEE_NOT_NEEDED);
            var _local4:DialogVO = new DialogVO(_local3, DialogVO.OK_ONLY);
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local4));
        }

    }
}//package gaia.moga.inventory.controller 
