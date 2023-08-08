//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.app.*;
    import alecmce.ui.pool.*;

    public class WorldAssetsFactory {

		[Inject]
        public var config:AppConfig;
		[Inject]
        public var model:ApplicationModel;
        private var pool:AssetSingletons;

        public function WorldAssetsFactory(){
            this.pool = new AssetSingletons();
        }
        public function zoneMap(_arg1:uint):Asset{
            var _local4:String;
            var _local2:String = _arg1.toString();
			if(_local2=="1")
				_local2="01";
			else if(_local2=="2")
				_local2="02";
            var _local3:Boolean = ((this.model.hasSpecial(ApplicationModel.SNOW)) || (this.model.hasSpecial(ApplicationModel.SNOWING)));
            if (_local3){
                _local4 = (("assets/world/maps/snowy_" + _local2) + ".swf");
            } else {
                _local4 = (("assets/world/maps/map_" + _local2) + ".swf");
            };
            _local4 = this.config.parseURL(_local4);
            var _local5:Asset = this.pool.require(_local4);
            return (_local5);
        }

    }
}//package gaia.moga.assets 
