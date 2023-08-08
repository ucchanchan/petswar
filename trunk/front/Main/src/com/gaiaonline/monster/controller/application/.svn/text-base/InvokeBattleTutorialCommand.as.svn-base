//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.tutorial.*;
    import gaia.moga.*;

    public class InvokeBattleTutorialCommand extends AsyncCommand {

		[Inject]
        public var assets:AssetService;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var ranchModel:HomeRanchModel;
		[Inject]
        public var updateUserData:UpdateUserData;
        private var _tutorialAsset:Asset;

        private static const TUTORIAL_ASSET:String = "assets/tutorial/tutorial.swf";

        override public function execute():void{
            this._tutorialAsset = this.assets.createWrapper(TUTORIAL_ASSET);
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeBattleTutorial-Parallel");
            _local1.add(this.updateUserData);
            _local1.add(this._tutorialAsset);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local6:int;
            var _local7:int;
            var _local8:int;
            var _local2:MonsterModel = this.ranchModel.mogas[0];
            var _local3:Friend;
            if (this.ranchModel.friends.fbFriends.length > 0){
                _local6 = 0;
                _local7 = this.ranchModel.friends.fbFriends.length;
                _local8 = Math.floor((_local6 + (Math.random() * ((_local7 - _local6) + 1))));
                _local3 = this.ranchModel.friends.fbFriends[_local8];
            } else {
                _local3 = this.ranchModel.friends.getFriendByID(FriendsModel.NOVA_ID);
            };
            var _local4:BattleTutorialVO = new BattleTutorialVO();
            _local4.numSeeds = this.inventory.getItem(ItemEnum.SEED).quantity;
            _local4.numRecharges = this.inventory.getItem(ItemEnum.COFFEE).quantity;
            _local4.numWhistles = this.inventory.getItem(ItemEnum.WHISTLE).quantity;
            _local4.monsterModel = this.ranchModel.mogas[0];
            _local4.bundle = this.monsters.monsterBundle(_local2);
            if (_local3){
                _local4.friendPic = _local3.picture;
                _local4.friendName = _local3.name;
            };
            _local4.tutorialAsset = this._tutorialAsset;
            var _local5:BattleTutorial = new BattleTutorial(_local4);
            dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local5));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_INVOKE_BATTLE_TUTORIAL));
        }

    }
}//package com.gaiaonline.monster.controller.application 
