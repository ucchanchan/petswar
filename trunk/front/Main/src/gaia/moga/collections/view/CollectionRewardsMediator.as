//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.assets.*;
    import gaia.moga.collections.model.reward.*;
    import com.gaiaonline.monster.view.components.questrewards.*;
    import org.robotlegs.mvcs.*;

    public class CollectionRewardsMediator extends Mediator {

		[Inject]
        public var view:CollectionRewards;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var monsters:MonsterAssetsFactory;
        private var rewardItems:Vector.<CollectionRewardDisplay>;
        private var rewardAssets:AssetCollection;

        override public function onRegister():void{
            this.rewardItems = new Vector.<CollectionRewardDisplay>(0);
            this.rewardAssets = new AssetCollection("CollectionRewards-Collection");
            this.generateRewards();
            this.rewardAssets.complete.addOnce(this.onAssetsReady);
            this.rewardAssets.error.addOnce(this.onAssetsError);
            this.rewardAssets.init();
        }
        override public function onRemove():void{
            this.view = null;
            this.rewardItems = null;
            this.rewardAssets.dispose();
            this.rewardAssets = null;
        }
        private function onAssetsReady(_arg1:Asset):void{
            this.view.display(this.rewardItems);
        }
        private function onAssetsError(_arg1:Asset, _arg2:String=""):void{
        }
        private function generateRewards():void{
            var _local2:MogaCollectionRewardItem;
            var _local3:MogaCollectionRewardMonster;
            var _local1:MogaCollectionReward = this.view.reward;
            for each (_local2 in _local1.items) {
                this.parseItem(_local2);
            };
            for each (_local3 in _local1.monsters) {
                this.parseMonster(_local3);
            };
        }
        private function parseItem(_arg1:MogaCollectionRewardItem):void{
            var _local2:Asset = this.assets.itemIcon(_arg1.id);
            var _local3:QuestRewardCount = this.generateCount(_arg1.quantity);
            this.rewardAssets.add(_local2);
            this.rewardItems.push(new CollectionRewardDisplay(_local2, _local3, false));
        }
        private function parseMonster(_arg1:MogaCollectionRewardMonster):void{
            var _local2:Asset = this.monsters.monsterPortraitByID(_arg1.id);
            var _local3:QuestRewardCount = this.generateCount(_arg1.quantity);
            this.rewardAssets.add(_local2);
            this.rewardItems.push(new CollectionRewardDisplay(_local2, _local3, true));
        }
        private function generateCount(_arg1:int):QuestRewardCount{
            var _local2:Asset = this.assets.rewardCount();
            var _local3:QuestRewardCount = new QuestRewardCount(_local2, _arg1);
            this.rewardAssets.add(_local2);
            return (_local3);
        }

    }
}//package gaia.moga.collections.view 
