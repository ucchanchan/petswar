//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.questrewards.*;
    import com.gaiaonline.monster.model.quests.rewards.*;
    import org.robotlegs.mvcs.*;

    public class QuestRewardsMediator extends Mediator {

		[Inject]
        public var view:QuestRewards;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var monsters:MonsterAssetsFactory;
        private var rewards:Vector.<QuestRewardItem>;
        private var collection:AssetCollection;

        override public function onRegister():void{
            this.rewards = new Vector.<QuestRewardItem>();
            this.collection = new AssetCollection("QuestRewards-Collection");
            this.generateRewards(this.view.data);
            this.collection.complete.addOnce(this.onAssetsReady);
            this.collection.error.addOnce(this.onAssetsError);
            this.collection.init();
        }
        override public function onRemove():void{
            this.view = null;
            this.rewards = null;
            this.collection.dispose();
            this.collection = null;
        }
        private function onAssetsReady(_arg1:Asset):void{
            this.view.display(this.rewards);
        }
        private function onAssetsError(_arg1:Asset, _arg2:String=""):void{
        }
        private function generateRewards(_arg1:Vector.<QuestRewardVO>):void{
            var _local4:QuestRewardVO;
            var _local2:int = _arg1.length;
            var _local3:int;
            while (_local3 < _local2) {
                _local4 = _arg1[_local3];
                switch (_local4.type){
                    case QuestRewardItemVO.TYPE:
                        this.parseItem(QuestRewardItemVO(_local4));
                        break;
                    case QuestRewardMonsterVO.TYPE:
                        this.parseMonster(QuestRewardMonsterVO(_local4));
                        break;
                    case QuestRewardCurrencyVO.TYPE:
                        this.parseCurrency(QuestRewardCurrencyVO(_local4));
                        break;
                    case QuestRewardXPVO.TYPE:
                        this.parseXP(QuestRewardXPVO(_local4));
                        break;
                };
                _local3++;
            };
        }
        private function parseItem(_arg1:QuestRewardItemVO):void{
            var _local2:Asset = this.assets.itemIcon(_arg1.id);
            var _local3:QuestRewardCount = this.generateCount(_arg1.quantity);
            this.collection.add(_local2);
            this.rewards.push(new QuestRewardItem(_local2, _local3));
        }
        private function parseMonster(_arg1:QuestRewardMonsterVO):void{
            var _local2:Asset = this.monsters.monsterIconByID(_arg1.id);
            var _local3:QuestRewardCount = this.generateCount(1);
            this.collection.add(_local2);
            this.rewards.push(new QuestRewardItem(_local2, _local3));
        }
        private function parseCurrency(_arg1:QuestRewardCurrencyVO):void{
            var _local2:Asset = this.assets.currencyIcon();
            var _local3:QuestRewardCount = this.generateCount(_arg1.quantity);
            this.collection.add(_local2);
            this.rewards.push(new QuestRewardItem(_local2, _local3));
        }
        private function parseXP(_arg1:QuestRewardXPVO):void{
            var _local2:Asset = this.assets.xpIcon();
            var _local3:QuestRewardCount = this.generateCount(_arg1.quantity);
            this.collection.add(_local2);
            this.rewards.push(new QuestRewardItem(_local2, _local3));
        }
        private function generateCount(_arg1:int):QuestRewardCount{
            var _local2:Asset = this.assets.rewardCount();
            var _local3:QuestRewardCount = new QuestRewardCount(_local2, _arg1);
            this.collection.add(_local2);
            return (_local3);
        }

    }
}//package com.gaiaonline.monster.view 
