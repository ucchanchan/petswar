//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.whistleReport.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class WhistleReportItemMediator extends Mediator {

        public var view:WhistleReportItem;
        public var text:TextService;
        public var monsters:MonsterAssetsFactory;
        public var mogas:MogaFactory;
        public var friends:FriendsModel;
        public var gsiService:GSIDataService;
        public var timer:TimerService;
        public var fbService:FBService;

        override public function onRegister():void{
            var _local1:Friend = this.friends.getFriendByID(this.view.picturedFriendID);
            var _local2:MonsterModel = this.mogas.read(this.view.item.instanceId);
            var _local3:FightMonster = this.monsters.monsterFight(_local2);
            if (_local1 == null){
                this.view.removalRequested.dispatch(this.view);
                return;
            };
            var _local4:String = this.getReportMessage(this.view.item, _local1);
            this.view.setContent(_local2, _local3, _local1, _local4);
            this.view.revealButtonClick.add(this.onRevealButtonClick);
            this.view.friendCountRollout.add(this.onFriendCountRollout);
            this.view.friendCountRollover.add(this.onFriendCountRollover);
            this.view.thankYouButtonClick.add(this.onThankYouButtonClick);
        }
        override public function onRemove():void{
            this.view.dispose();
        }
        private function onRevealButtonClick():void{
            this.view.showThankYouButton();
            this.view.animateXPIncrease();
            if (this.view.item.levelUp){
                this.view.animateLevelUp();
            };
        }
        private function onThankYouButtonClick(_arg1:WhistleReportItem):void{
            var _local2:String = String(this.timer.currentTime);
            this.gsiService.createEvent(4, _local2, this.view.item.friends.join(",").split(","));
            var _local3:Object = new Object();
            _local3.friendIds = this.view.item.friends;
            _local3.selectedFriend = this.view.picturedFriendID;
            _local3.eventTime = _local2;
            this.fbService.showWhistleReportThankYouPopup(_local3);
        }
        private function onFriendCountRollout():void{
            this.view.hideOtherFriends();
        }
        private function onFriendCountRollover(_arg1:Vector.<String>):void{
            var _local2:Vector.<Friend> = new Vector.<Friend>();
            var _local3:int;
            while (_local3 < _arg1.length) {
                if (_arg1[_local3] == this.view.picturedFriendID){
                } else {
                    _local2.push(this.friends.getFriendByID(_arg1[_local3]));
                };
                _local3++;
            };
            this.view.showOtherFriends(_local2);
        }
        private function getReportMessage(_arg1:WhistleReportItemDataVO, _arg2:Friend):String{
            var _local3:MonsterModel = this.mogas.read(_arg1.instanceId);
            var _local4:String = this.text.getWhistleReportText(_local3, _arg2, _arg1);
            return (_local4);
        }

    }
}//package com.gaiaonline.monster.view 
