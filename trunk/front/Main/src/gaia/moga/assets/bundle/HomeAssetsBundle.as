//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets.bundle {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.friendlist.view.ui.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import gaia.moga.app.*;

    public class HomeAssetsBundle extends GenericBundle {

        private var _app:ApplicationModel;
        private var _assets:AssetService;
        private var _homeAssets:HomeAssetsFactory;
        private var _model:FriendsModel;
        private var _config:AppConfig;
        public var card:Asset;
        public var background:Asset;
        public var top:Asset;
        public var menu:Asset;
        public var team:Asset;
        public var whistleTree:Asset;
        public var whistleTreePanel:Asset;
        public var starseedBasket:Asset;
        public var friends:FriendList;
        public var overlay:Asset;
        public var prizeTimer:Asset;

        public function HomeAssetsBundle(_arg1:ApplicationModel, _arg2:HomeAssetsFactory, _arg3:AssetService, _arg4:FriendsModel, _arg5:AppConfig){
            super("HomeAssetsBundle");
            this._app = _arg1;
            this._assets = _arg3;
            this._homeAssets = _arg2;
            this._model = _arg4;
            this._config = _arg5;
            this.generateCollection();
        }
        private function generateCollection():void{
            this.friends = this._assets.generateFriendList(this._model.friends);
            this.background = this._homeAssets.getTypedAsset(HomeAssetsFactory.BACKGROUND);
            this.card = this._assets.monsterCard;
            this.top = this._assets.topUI;
            this.menu = this._assets.menuUI;
            this.team = this._assets.smallTeamUI;
            this.whistleTree = this._homeAssets.getTypedAsset(HomeAssetsFactory.TREE);
            this.whistleTreePanel = this._homeAssets.getTypedAsset(HomeAssetsFactory.PANEL);
            this.starseedBasket = this._homeAssets.getTypedAsset(HomeAssetsFactory.BASKET);
            collection.add(this.background);
            collection.add(this.friends);
            collection.add(this.card);
            collection.add(this.top);
            collection.add(this.menu);
            collection.add(this.team);
            collection.add(this.whistleTree);
            collection.add(this.whistleTreePanel);
            collection.add((this.prizeTimer = this._assets.prizeTimer));
            if (this._app.hasSpecial(ApplicationModel.SNOWING)){
                collection.add((this.overlay = this._assets.weather(ApplicationModel.SNOWING)));
            };
        }

    }
}//package gaia.moga.assets.bundle 
