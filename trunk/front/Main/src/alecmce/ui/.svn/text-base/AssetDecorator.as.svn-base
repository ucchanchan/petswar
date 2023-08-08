//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;

    public class AssetDecorator {

        private var _asset:Asset;
        private var _content:MovieClip;

        public function AssetDecorator(_arg1:Asset){
            this._asset = _arg1;
            if (_arg1.isComplete){
                this.inner_setup(_arg1);
            } else {
                _arg1.complete.addOnce(this.inner_setup);
                _arg1.init();
            };
        }
        public function get self():DisplayObject{
            return (this._asset.self);
        }
        private function inner_setup(_arg1:Asset):void{
            this._content = MovieClip(_arg1.content);
            this.setup(this._content);
        }
        protected function setup(_arg1:MovieClip):void{
        }
        public function get content():MovieClip{
            return (this._content);
        }

    }
}//package alecmce.ui 
