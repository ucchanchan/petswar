//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.assets {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import gaia.moga.story.model.*;

    public class StoryAssetBundle extends AsyncBase {

        private var _assets:StoryAssetFactory;
        private var _loader:StoryLoader;
        private var _model:StoryModel;
        private var _collection:AssetCollection;
        private var isInited:Boolean;
        private var isURLSet:Boolean;

        public static const NPC_BUBBLE:String = "NPC_BUBBLE";
        public static const PLAYER_BUBBLE:String = "PLAYER_BUBBLE";
        public static const SKIP:String = "SKIP";

        public function StoryAssetBundle(_arg1:StoryAssetFactory){
            this._assets = _arg1;
        }
        public function set url(_arg1:String):void{
            if (this.isURLSet){
                return;
            };
            this.isURLSet = !((_arg1 == ""));
            if (!this.isURLSet){
                return;
            };
            this._loader = this._assets.createLoader(_arg1);
            this._collection = new AssetCollection((_arg1 + "-Collection"));
            this._collection.add(this._assets.getNPCBubble(), NPC_BUBBLE);
            this._collection.add(this._assets.getPlayerBubble(), PLAYER_BUBBLE);
            this._collection.add(this._assets.getPlayerBubble(), PLAYER_BUBBLE);
            this._collection.add(this._assets.getSkip(), SKIP);
            if (this.isInited){
                this.onInit();
            };
        }
        public function get model():StoryModel{
            return (this._model);
        }
        public function getAsset(_arg1:String):Asset{
            return (this._collection.getAsset(_arg1));
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (this._loader){
                this._loader.dispose();
            };
            if (this._collection){
                this._collection.dispose();
            };
            this._loader = null;
        }
        override protected function onInit():void{
            this.isInited = true;
            if (!this._loader){
                return;
            };
            this._loader.complete.addOnce(this.onLoaderComplete);
            this._loader.error.addOnce(this.onLoaderError);
            this._loader.init();
        }
        private function onLoaderComplete(_arg1:Async):void{
            this._loader.error.removeAll();
            this.parseData();
            this._loader.dispose();
            this._loader = null;
        }
        private function onLoaderError(_arg1:Async, _arg2:String):void{
            this._loader.complete.removeAll();
            asyncError(_arg2);
        }
        private function parseData():void{
            this._model = new StoryModel(this._loader.data);
            this.generateCollection();
            this._collection.complete.addOnce(this.onCollectionComplete);
            this._collection.error.addOnce(this.onCollectionError);
            this._collection.init();
        }
        private function generateCollection():void{
            var _local2:StoryAsset;
            var _local3:Asset;
            var _local1:Vector.<StoryAsset> = this._model.assets;
            for each (_local2 in _local1) {
                _local3 = this._assets.createWrapper(_local2.asset);
                this._collection.add(_local3, _local2.id);
            };
        }
        private function onCollectionComplete(_arg1:Async):void{
            this._collection.error.removeAll();
            asyncComplete();
        }
        private function onCollectionError(_arg1:Async, _arg2:String):void{
            this._collection.complete.removeAll();
            asyncError(_arg2);
        }

    }
}//package gaia.moga.story.view.assets 
