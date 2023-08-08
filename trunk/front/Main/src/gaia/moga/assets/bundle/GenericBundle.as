//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets.bundle {
    import alecmce.ui.*;
    import alecmce.async.*;

    public class GenericBundle extends AssetBase {

        protected var collection:AssetCollection;
        private var _name:String;

        public function GenericBundle(_arg1:String){
            this._name = _arg1;
            this.collection = new AssetCollection((this._name + "-Collection"));
        }
        override protected function onInit():void{
            this.collection.complete.addOnce(this.onComplete);
            this.collection.error.addOnce(this.onError);
            this.collection.init();
        }
        private function onComplete(_arg1:Async):void{
            this.collection.error.removeAll();
            assetComplete();
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            this.collection.complete.removeAll();
            assetError(_arg2);
        }
        final override public function dispose(_arg1:Boolean=true):void{
            if (this.collection){
                this.collection.dispose(_arg1);
            };
            this.collection = null;
        }
        final override public function get name():String{
            return (this._name);
        }

    }
}//package gaia.moga.assets.bundle 
