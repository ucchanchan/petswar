//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets.bundle {
    import alecmce.ui.*;
    import gaia.moga.assets.*;

    public class WhistleReportItemBundle extends GenericBundle {

        public var itemClip:Asset;
        public var levelUp:Asset;
        public var bonusAnimsAsset:Asset;
        private var assets:AssetService;

        public function WhistleReportItemBundle(_arg1:AssetService){
            super("WhistleReportItemBundle");
            this.assets = _arg1;
            collection.add((this.itemClip = this.assets.createWrapper("assets/ui/whistleReportItem.swf")));
            collection.add((this.levelUp = this.assets.getWhistleReportLevelUpAsset()));
            collection.add((this.bonusAnimsAsset = this.assets.getWhistleReportItemBonusAsset()));
        }
    }
}//package gaia.moga.assets.bundle 
