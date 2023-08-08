//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.world {
    import __AS3__.vec.*;

    public class WorldModel {

        public var isInited:Boolean;
        public var home:Location;
        public var name:String;
        public var description:String;
        public var requiredLevel:uint;
        private var _zones:Object;
        private var locationMap:Object;
        private var _currentLocation:Location;
        public var isBattle:Boolean;
        public var isStory:Boolean;
        public var isQuest:Boolean;
        public var isNPC:Boolean;
        public var isMovingLocation:Boolean;
        public var isSurprised:Boolean;
        public var isTravellingInATaxi:Boolean;

        public function WorldModel(){
            this.isInited = false;
            this._zones = {};
            this.locationMap = {};
            var _local1:Zone = this.getZone(0);
            _local1.isAvailable = true;
            this.home = this.getLocation(0);
            this.home.name = "Home";
            this.currentLocation = this.home;
        }
        public function getZones():Object{
            return (this._zones);
        }
        public function getZone(_arg1:uint):Zone{
            return ((this._zones[_arg1] = ((this._zones[_arg1]) || (new Zone(_arg1)))));
        }
        public function set openZones(_arg1:Array):void{
            var _local2:Zone;
            var _local3:uint;
            for each (_local2 in this._zones) {
                _local2.isAvailable = false;
            };
            for each (_local3 in _arg1) {
                this.getZone(_local3).isAvailable = true;
            };
        }
        public function getLocation(_arg1:uint):Location{
            var _local2:Location = this.locationMap[_arg1];
            if (!_local2){
                _local2 = new Location(_arg1);
                this.locationMap[_arg1] = _local2;
            };
            return (_local2);
        }
        public function getAllLocations():Vector.<Location>{
            var _local2:Location;
            var _local1:Vector.<Location> = new Vector.<Location>();
            for each (_local2 in this.locationMap) {
                _local1.push(_local2);
            };
            return (_local1);
        }
        public function get currentLocation():Location{
            return (this._currentLocation);
        }
        public function set currentLocation(_arg1:Location):void{
            if (this._currentLocation == _arg1){
                return;
            };
            if (this._currentLocation){
                this._currentLocation.isCurrent = false;
            };
            this._currentLocation = _arg1;
            if (this._currentLocation){
                this._currentLocation.isCurrent = true;
            };
        }
        public function isZoneAvailable(_arg1:uint):Boolean{
            return ((((_arg1 == 0)) || ((this._zones[_arg1] as Zone).isAvailable)));
        }
        public function get currentZone():Zone{
            return (this._currentLocation.zone);
        }

    }
}//package com.gaiaonline.monster.model.world 
