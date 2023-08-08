//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import alecmce.ui.*;
    import alecmce.async.*;
    import gaia.moga.app.*;

    public class FontFactory {

		[Inject]
        public var config:AppConfig;
        private var _map:Object;

        public function FontFactory(){
            this._map = {};
        }
        public function register(_arg1:String):Async{
            _arg1 = this.config.parseURL(_arg1);
            var _local2:Asset = this._map[_arg1];
            if (_local2){
                return (_local2);
            };
            _local2 = new MovieClipAssetLoader(_arg1);
            _local2.init();
            this._map[_arg1] = _local2;
            return (_local2);
        }

    }
}//package gaia.moga.assets 
