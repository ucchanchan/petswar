//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.app.*;
    import alecmce.ui.pool.*;

    public class HomeAssetsFactory {

		[Inject]
        public var config:AppConfig;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var assets:AssetService;
        private var singletons:AssetSingletons;

        public static const HOUSE:String = "house";
        public static const BACKGROUND:String = "background";
        public static const TREE:String = "tree";
        public static const PANEL:String = "panel";
        public static const BASKET:String = "basket";

        public function HomeAssetsFactory(){
            this.singletons = new AssetSingletons();
        }
        public function getDecoration(_arg1:DecorationVO):Asset{
            var _local2:String = _arg1.type;
            if (((_local2) && (!((_local2 == ""))))){
                return (this.getTypedAsset(_local2));
            };
            var _local3 = (("assets/decorations/" + _arg1.id) + ".swf");
            _local3 = this.config.parseURL(_local3);
            return (this.singletons.require(_local3));
        }
        public function getTypedAsset(_arg1:String):Asset{
            var _local2:Asset;
            var _local3:Boolean = ((this.model.hasSpecial(ApplicationModel.SNOW)) || (this.model.hasSpecial(ApplicationModel.SNOWING)));
            if (_local3){
                _local2 = this.getSnowTypedAsset(_arg1);
            } else {
                _local2 = this.getDefaultTypedAsset(_arg1);
            };
            return (_local2);
        }
        private function getSnowTypedAsset(_arg1:String):Asset{
            var _local2:String;
            switch (_arg1){
                case BACKGROUND:
                    _local2 = "assets/special/winterHome.swf";
                    break;
                case HOUSE:
                    _local2 = "assets/special/xmasHouse.swf";
                    break;
                case TREE:
                    _local2 = "assets/special/xmasTree.swf";
                    break;
            };
            if ((((_local2 == null)) || ((_local2 == "")))){
                return (this.getDefaultTypedAsset(_arg1));
            };
            _local2 = this.config.parseURL(_local2);
            return (this.singletons.require(_local2));
        }
        private function getDefaultTypedAsset(_arg1:String):Asset{
            var _local2:String;
            switch (_arg1){
                case BACKGROUND:
                    _local2 = "assets/home/backgrounds/1.swf";
                    break;
                case HOUSE:
                    _local2 = "assets/decorations/8.swf";
                    break;
                case TREE:
                    _local2 = "assets/decorations/whistleTree.swf";
                    break;
                case PANEL:
                    _local2 = "assets/decorations/whistleTreePanel.swf";
                    break;
                case BASKET:
                    _local2 = "assets/decorations/starseedBasket.swf";
            };
            _local2 = this.config.parseURL(_local2);
            return (this.singletons.require(_local2));
        }

    }
}//package gaia.moga.assets 
