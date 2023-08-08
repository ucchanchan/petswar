//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.assets {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.assets.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.service.*;

    public class DexAssetBundle extends GenericBundle {

        public var tabs:Vector.<Tab>;
        public var language:DexLanguageBundle;
        public var menu:Asset;
        public var team:Asset;
        public var grid:Asset;
        public var bottomLeft:Asset;
        public var tokens:Asset;
        public var multiples:Asset;
        public var detail:Asset;
        public var inventory:Asset;
        public var unknown:Asset;

        public function DexAssetBundle(_arg1:AssetService, _arg2:TextService){
            super("DexAssetBundle");
            this.tabs = Vector.<Tab>([new Tab("Team")]);
            this.language = _arg2.rarityBundle;
            collection.add((this.menu = _arg1.createWrapper("assets/dex/menu.swf")));
            collection.add((this.team = _arg1.createWrapper("assets/dex/team.swf")));
            collection.add((this.grid = _arg1.createWrapper("assets/dex/grid.swf")));
            collection.add((this.bottomLeft = _arg1.createWrapper("assets/dex/bottomLeft.swf")));
            collection.add((this.tokens = _arg1.createWrapper("assets/dex/tokens.swf")));
            collection.add((this.multiples = _arg1.createWrapper("assets/dex/multiple.swf")));
            collection.add((this.detail = _arg1.createWrapper("assets/dex/detail.swf")));
            collection.add((this.inventory = _arg1.createWrapper("assets/dex/inventory.swf")));
            collection.add((this.unknown = _arg1.createWrapper("assets/dex/unknown.swf")));
        }
    }
}//package gaia.moga.dex.assets 
