//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.service {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.collections.event.*;
    import com.gaiaonline.monster.view.components.team.*;

    public class TradeInCollectionProcess extends GSIProcess {

		[Inject]
        public var factory:MogaCollectionFactory;
		[Inject]
        public var dispatcher:IEventDispatcher;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var mogaFactory:MogaFactory;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var assetService:AssetService;
        public var collection:MogaCollectionVO;

        public function TradeInCollectionProcess(){
            super("TradeInCollectioinProcess");
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.success){
                this.updateCollection(_arg1.success.update_inventory);
                this.parseReward(_arg1.success.rewards);
                return (true);
            };
            return (false);
        }
        private function updateCollection(_arg1:Object):void{
            var _local2:String;
            var _local3:MogaCollectionEvent;
            var _local4:MogaCollectionItem;
            for (_local2 in _arg1) {
                _local4 = this.factory.getCollectable(_local2);
                _local4.quantity = parseInt(_arg1[_local2]);
            };
            _local3 = new MogaCollectionEvent(MogaCollectionEvent.COLLECTIONS_UPDATED);
            new Vector.<MogaCollectionVO>(1)[0] = this.collection;
            _local3.collections = new Vector.<MogaCollectionVO>(1);
            this.dispatcher.dispatchEvent(_local3);
        }
        private function parseReward(_arg1:Object):void{
            if (_arg1.item){
                this.parseNewItems(_arg1.item);
            };
            if (_arg1.monster){
                this.parseNewMonster(_arg1.monster);
            };
            var _local2:MogaCollectionEvent = new MogaCollectionEvent(MogaCollectionEvent.SHOW_REWARD_CONFIRMATION);
            new Vector.<MogaCollectionVO>(1)[0] = this.collection;
            _local2.collections = new Vector.<MogaCollectionVO>(1);
            this.dispatcher.dispatchEvent(_local2);
        }
        private function parseNewItems(_arg1:Object):void{
            var _local2:Object;
            var _local3:InventoryItem;
            for each (_local2 in _arg1) {
                _local3 = this.inventory.getItem(_local2.props.id);
                _local3.quantity = (_local3.quantity + parseInt(_local2.quantity));
            };
        }
        private function parseNewMonster(_arg1:Object):void{
            var _local2:String;
            var _local3:Object;
            var _local4:MonsterModel;
            var _local5:NameMonster;
            var _local6:PanelsEvent;
            for (_local2 in _arg1) {
                _local3 = _arg1[_local2];
                _local4 = this.mogaFactory.create(_local3);
                _local4.text = this.textService.getMonsterText(_local4.monsterID);
                this.ranch.addMonster(_local4);
                this.dispatcher.dispatchEvent(new TeamEvent(TeamEvent.ADD_TO_RANCH, _local4));
                _local5 = new NameMonster(this.assetService.nameMonster(), _local4);
                _local6 = new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local5);
                this.dispatcher.dispatchEvent(_local6);
            };
        }

    }
}//package gaia.moga.collections.service 
