//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.view {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import gaia.moga.inventory.view.ui.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.inventory.events.*;

    public class InventoryMediator extends Mediator {

		[Inject]
        public var view:InventoryUI;
		[Inject]
        public var model:InventoryModel;

        override public function onRegister():void{
            this.view.getMore.add(this.openShop);
            this.view.useItem.add(this.useItem);
            this.view.categories = Vector.<String>(["consume"]);
            this.view.items = this.model.actualItems;
        }
        override public function onRemove():void{
            this.view.getMore.remove(this.openShop);
            this.view.useItem.remove(this.useItem);
        }
        private function openShop(_arg1:InventoryItem):void{
            dispatch(new ApplicationEvent(ApplicationEvent.LOADING));
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
        }
        private function useItem(_arg1:InventoryItem, _arg2:MonsterModel=null):void{
            var _local3:uint = _arg1.type.id;
            switch (_local3){
                case ItemEnum.COFFEE:
                    dispatch(new UseCoffeeEvent(UseCoffeeEvent.USE_COFFEE, this.view.moga));
                    break;
            };
        }

    }
}//package gaia.moga.inventory.view 
