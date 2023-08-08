//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.service {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.collections.model.*;
    import gaia.moga.dex.service.*;

    public class CollectionDexSetupProcess extends DexSetupProcess {

		[Inject]
        public var collectionModel:MogaCollectionsModel;
        private var tradeInMoga:Vector.<uint>;

        public function CollectionDexSetupProcess(){
            super("CollectionDexSetupProcess");
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:*;
            collection = new AssetCollection("DexSetupProcess-Collection");
            this.tradeInMoga = this.collectionModel.rewardMonsterIDs;
            for (_local2 in _arg1) {
                if (this.idIsTradeInMoga(uint(_local2))){
                    parseID(_local2, _arg1);
                };
            };
            return (true);
        }
        private function idIsTradeInMoga(_arg1:uint):Boolean{
            var _local2:uint;
            for each (_local2 in this.tradeInMoga) {
                if (_arg1 == _local2){
                    return (true);
                };
            };
            return (false);
        }

    }
}//package gaia.moga.collections.service 
