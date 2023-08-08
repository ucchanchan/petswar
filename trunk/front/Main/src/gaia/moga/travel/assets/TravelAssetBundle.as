//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.assets {
    import alecmce.ui.*;
    import gaia.moga.assets.*;
    import gaia.moga.assets.bundle.*;

    public class TravelAssetBundle extends GenericBundle {

        public var travel:Asset;

        public function TravelAssetBundle(_arg1:AssetService){
            super("TravelAssetBundle");
            collection.add((this.travel = _arg1.createWrapper("assets/world/travel.swf")));
        }
    }
}//package gaia.moga.travel.assets 
