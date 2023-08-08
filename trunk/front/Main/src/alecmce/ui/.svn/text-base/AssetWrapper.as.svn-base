//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;

    public class AssetWrapper extends AssetBase {

        protected var _asset:Asset;

        public function AssetWrapper(_arg1:Asset){
            this._asset = _arg1;
        }
        override protected function onInit():void{
            if (this._asset.isComplete){
                this.onAssetComplete(this._asset);
            } else {
                if (this._asset.isError){
                    this.onAssetError(this._asset);
                } else {
                    this.loadAsset();
                };
            };
        }
        private function loadAsset():void{
            this._asset.complete.addOnce(this.onAssetComplete);
            this._asset.error.addOnce(this.onAssetError);
            this._asset.init();
        }
        override public function get content():DisplayObject{
            return (this._asset.content);
        }
        override public function get name():String{
            return (this._asset.name);
        }
        override public function dispose(_arg1:Boolean=true):void{
            super.dispose(_arg1);
            this._asset.dispose(_arg1);
        }
        private function onAssetComplete(_arg1:Asset):void{
            this._asset.error.remove(this.onError);
            this.onComplete(_arg1);
            assetComplete();
        }
        protected function onComplete(_arg1:Asset):void{
        }
        private function onAssetError(_arg1:Asset, _arg2:String=""):void{
            this._asset.complete.remove(this.onComplete);
            this.onError(_arg1);
            assetError(_arg2);
        }
        protected function onError(_arg1:Asset):void{
        }

    }
}//package alecmce.ui 
