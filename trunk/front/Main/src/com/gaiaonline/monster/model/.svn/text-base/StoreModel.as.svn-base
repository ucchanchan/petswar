//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import com.gaiaonline.monster.model.vo.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;

    public class StoreModel extends Actor {

		[Inject]
        public var text:TextService;
		[Inject]
        public var factory:ItemFactory;
        public var open:Boolean;
        public var premiumStoreOpen:Boolean;
        private var _items:Vector.<StoreItemVO>;

        public function StoreModel(){
            this._items = new Vector.<StoreItemVO>();
        }
        public function addItem(_arg1:StoreItemVO):void{
            var _local2:Item = this.factory.read(_arg1.id);
            if (_local2){
                _arg1.name = _local2.name;
                _arg1.description = _local2.description;
            };
            this._items.push(_arg1);
        }
        public function get items():Vector.<StoreItemVO>{
            return (this._items);
        }
        public function reset():void{
            this._items = new Vector.<StoreItemVO>();
        }

    }
}//package com.gaiaonline.monster.model 
