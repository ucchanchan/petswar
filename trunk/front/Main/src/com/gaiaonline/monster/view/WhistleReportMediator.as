//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.whistleReport.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class WhistleReportMediator extends Mediator {

        public var view:WhistleReport;
        public var model:WhistleReportModel;
        public var friends:FriendsModel;
        public var ranch:HomeRanchModel;
        public var monsters:MonsterAssetsFactory;
        public var assets:AssetService;
        public var text:TextService;
        private var friendMonsterLinkTable:WhistleReportFriendMonsterLinks;
        private var activeViews:Vector.<WhistleReportItem>;
        private var _thankYouItems:Array;

        public function WhistleReportMediator(){
            this._thankYouItems = [];
            super();
        }
        override public function onRegister():void{
            this.view.closeWindow.addOnce(this.onClose);
            if (this.view.isReady){
                this.updateState();
            } else {
                this.view.ready.addOnce(this.updateState);
            };
        }
        override public function onRemove():void{
            var _local1:WhistleReportItem;
            this.view.dispose();
            for each (_local1 in this.activeViews) {
                mediatorMap.removeMediatorByView(_local1);
            };
        }
        private function updateState():void{
            var _local3:String;
            var _local4:WhistleReportItem;
            var _local1:Vector.<WhistleReportItemDataVO> = this.model.whistleReportItems;
            this.friendMonsterLinkTable = new WhistleReportFriendMonsterLinks(_local1);
            this.activeViews = new Vector.<WhistleReportItem>();
            var _local2:int;
            while (_local2 < _local1.length) {
                _local3 = this.friendMonsterLinkTable.getMonstersMostUniqueFriendID(_local1[_local2].instanceId);
                _local4 = this.view.addItem(new WhistleReportItemBundle(this.assets), _local1[_local2], _local3);
                this.activeViews.push(_local4);
                _local4.thankYouButtonClick.addOnce(this.onThankYouButtonClick);
                _local4.revealButtonClick.addOnce(this.onActionButtonClick);
                _local4.removalRequested.addOnce(this.removeWhistleReportItem);
                mediatorMap.createMediator(_local4);
                _local2++;
            };
            this.model.reset();
        }
        private function onActionButtonClick():void{
            this.view.enableCloseButton();
        }
        private function onThankYouButtonClick(_arg1:WhistleReportItem):void{
            this.view.removeEventListener(Event.ENTER_FRAME, this.onThankYouClickDelay, false);
            this._thankYouItems.push(_arg1);
            this.view.addEventListener(Event.ENTER_FRAME, this.onThankYouClickDelay, false);
        }
        private function onThankYouClickDelay(_arg1:Event):void{
            var _local2:WhistleReportItem;
            this.view.removeEventListener(Event.ENTER_FRAME, this.onThankYouClickDelay, false);
            while (this._thankYouItems.length > 0) {
                _local2 = (this._thankYouItems.shift() as WhistleReportItem);
                this.removeWhistleReportItem(_local2);
            };
        }
        private function removeWhistleReportItem(_arg1:WhistleReportItem):void{
            var _local2:int = this.view.removeItemView(_arg1);
            mediatorMap.removeMediatorByView(_arg1);
            if (_local2 == 0){
                this.onClose();
            };
        }
        private function onClose():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
