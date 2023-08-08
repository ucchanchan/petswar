//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.items.model {
    import __AS3__.vec.*;
    import gaia.moga.assets.*;
    import gaia.moga.data.parser.*;
    import com.adobe.serialization.json.*;

    public class ItemFactory {

		[Inject]
        public var assets:AssetService;
        private var map:Object;

        public function ItemFactory(){
            this.map = {};
        }
        public function create(_arg1:CategoryData):Item{
            var _local2:uint = uint(_arg1.name);
            var _local3:Item = this.map[_local2];
            if (!_local3){
                _local3 = new Item(_local2);
                _local3.itemName = _arg1.map.NAME;
                _local3.description = _arg1.map.DESCRIPTION;
                _local3.isUseable = (_arg1.map.USEABLE.toUpperCase() == "YES");
                _local3.vector = this.assets.config.parseURL(_arg1.map.ICON);
                _local3.inventory = JSON.decode(_arg1.map.INVENTORY);
                _local3.context = Vector.<String>(_arg1.map.CONTEXT.split(","));
                _local3.init();
                this.map[_local2] = _local3;
            };
            return (_local3);
        }
        public function read(_arg1:uint):Item{
            return (this.map[_arg1]);
        }
        public function update(_arg1:CategoryData):Item{
            var _local2:uint = uint(_arg1.name);
            var _local3:Item = this.map[_local2];
            if (_local3){
                _local3.itemName = _arg1.map.NAME;
                _local3.description = _arg1.map.DESCRIPTION;
                _local3.isUseable = _arg1.map.USEABLE;
            };
            return (_local3);
        }
        public function dispose(_arg1:uint):Item{
            var _local2:Item = this.map[_arg1];
            if (_local2){
                _local2.dispose();
            };
            delete this.map[_arg1];
            return (_local2);
        }

    }
}//package gaia.moga.items.model 
