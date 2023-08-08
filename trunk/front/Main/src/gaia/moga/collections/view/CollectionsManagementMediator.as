//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.assets.*;
    import gaia.moga.collections.model.reward.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;
    import gaia.moga.collections.event.*;
    import com.gaiaonline.monster.*;
    import org.robotlegs.mvcs.*;

    public class CollectionsManagementMediator extends Mediator {

		[Inject]
        public var view:CollectionsManagementPanel;
		[Inject]
        public var dexModel:DexModel;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var zodiacFactory:ZodiacFactory;
        private var _dataInitialized:Boolean;// = false
        private var _sortMethod:Function;
        private var _collections:Vector.<MogaCollectionVO>;

        override public function onRegister():void{
            this.view.closeClick.addOnce(this.onCloseClick);
            this.view.progressSortClick.add(this.onProgressSortClick);
            this.view.nameSortClick.add(this.onNameSortClick);
            this.view.tradeContainerRollover.add(this.onTradeContainerRollover);
            this.view.tradeContainerRollout.add(this.onTradeContainerRollout);
            this.view.tradeButtonClick.add(this.onTradeButtonClick);
            this.view.selectProgressSort();
            this._sortMethod = this.getProgressSortedCollections;
            addContextListener(MogaCollectionEvent.SHARE_COLLECTION_DATA, this.onDataShared, MogaCollectionEvent);
            addContextListener(MogaCollectionEvent.COLLECTIONS_UPDATED, this.onCollectionsUpdated, MogaCollectionEvent);
            dispatch(new MogaCollectionEvent(MogaCollectionEvent.REQUEST_COLLECTIONS_DATA));
        }
        override public function onRemove():void{
            this.view.closeClick.remove(this.onCloseClick);
            this.view.progressSortClick.remove(this.onProgressSortClick);
            this.view.nameSortClick.remove(this.onNameSortClick);
            this.view.tradeContainerRollover.remove(this.onTradeContainerRollover);
            this.view.tradeContainerRollout.remove(this.onTradeContainerRollout);
            this.view.dispose();
        }
        private function onTradeButtonClick(_arg1:MogaCollectionDatum):void{
            var _local2:MogaCollectionEvent;
            if (_arg1.progress == 1){
                _local2 = new MogaCollectionEvent(MogaCollectionEvent.TRADE_IN_COLLECTION);
                var c = new Vector.<MogaCollectionVO>(1);
				c[0] = _arg1.collection;
                _local2.collections = c;
                dispatch(_local2);
            };
        }
        private function onTradeContainerRollover(_arg1:ListItem, _arg2:MogaCollectionDatum):void{
            var _local3:MogaCollectionRewardMonster;
            var _local4:DexMoga;
            var _local5:DexLanguageBundle;
            var _local6:String;
            var _local7:Bitmap;
            if (_arg2.rewardsMonster){
                _local3 = _arg2.reward.monsters[0];
                _local4 = this.dexModel.getMoga(_local3.id);
                _local5 = this.textService.rarityBundle;
                _local6 = _local5.getRarity(_local4.rarity);
                _local7 = this.zodiacFactory.generate(_local4.zodiac, 20);
                this.view.updateTooltip(_arg1, _local4.genericName, _local3.level, _local6, Color.fromRarity(_local4.rarity), _local7, _local4.description);
                this.view.showTooltip();
            } else {
                this.view.hideTooltip();
            };
        }
        private function onTradeContainerRollout():void{
            this.view.hideTooltip();
        }
        private function onDataShared(_arg1:MogaCollectionEvent):void{
            this._collections = _arg1.collections;
            if (!this._dataInitialized){
                this.sortCollections();
            };
            this._dataInitialized = true;
        }
        private function onCollectionsUpdated(_arg1:MogaCollectionEvent):void{
            this.view.updateCollectionsData(_arg1.collections);
        }
        private function onCloseClick():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onProgressSortClick():void{
            this._sortMethod = this.getProgressSortedCollections;
            this.view.selectProgressSort();
            this.sortCollections();
        }
        private function onNameSortClick():void{
            this._sortMethod = this.getNameSortedCollections;
            this.view.selectNameSort();
            this.sortCollections();
        }
        private function getProgressSortedCollections():Vector.<MogaCollectionVO>{
            var _local1:Array = this.getVoArray();
            _local1.sortOn(["progress", "name"], [(Array.NUMERIC | Array.DESCENDING), Array.CASEINSENSITIVE]);
            return (Vector.<MogaCollectionVO>(_local1));
        }
        private function getNameSortedCollections():Vector.<MogaCollectionVO>{
            var _local1:Array = this.getVoArray();
            _local1.sortOn("name", Array.CASEINSENSITIVE);
            return (Vector.<MogaCollectionVO>(_local1));
        }
        private function getVoArray():Array{
            var _local2:MogaCollectionVO;
            var _local1:Array = new Array();
            for each (_local2 in this._collections) {
                _local1.push(_local2);
            };
            return (_local1);
        }
        private function sortCollections():void{
            var _local4:MogaCollectionVO;
            var _local1:Vector.<MogaCollectionVO> = this._sortMethod();
            var _local2:Vector.<MogaCollectionDatum> = new Vector.<MogaCollectionDatum>(0);
            var _local3:int;
            while (_local3 < _local1.length) {
                _local4 = _local1[_local3];
                _local2[_local3] = new MogaCollectionDatum(_local4);
                _local3++;
            };
            this.view.setCollectionsData(_local2);
        }

    }
}//package gaia.moga.collections.view 
