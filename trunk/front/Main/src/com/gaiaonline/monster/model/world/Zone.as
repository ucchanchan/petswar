//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.world {
    import __AS3__.vec.*;

    public class Zone {

        public var id:uint;
        public var name:String;
        public var description:String;
        public var requiredLevel:uint;
        public var locations:Vector.<Location>;
        public var map:Object;
        public var taxiStop:Location;
        private var isHome:Boolean;
        private var _isAvailable:Boolean;

        public function Zone(_arg1:uint){
            this.id = _arg1;
            this.isHome = (_arg1 == 0);
            this.locations = new Vector.<Location>();
            this.map = {};
        }
        public function addLocation(_arg1:Location):void{
            var _local2:uint = _arg1.id;
            if (this.map[_local2]){
                return;
            };
            _arg1.zone = this;
            this.locations.push(_arg1);
            this.map[_local2] = _arg1;
        }
        public function getLocation(_arg1:uint):Location{
            return (this.map[_arg1]);
        }
        public function get isAvailable():Boolean{
            return (((this._isAvailable) || (this.isHome)));
        }
        public function set isAvailable(_arg1:Boolean):void{
            this._isAvailable = _arg1;
        }

    }
}//package com.gaiaonline.monster.model.world 
