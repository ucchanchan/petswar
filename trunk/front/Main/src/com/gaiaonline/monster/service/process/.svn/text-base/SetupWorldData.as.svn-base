//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.model.quests.*;

    public class SetupWorldData extends GSIProcess {

		[Inject]
        public var world:WorldModel;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var inventory:InventoryModel;

        public function SetupWorldData(){
            super("SetupWorldData");
        }
        override protected function onInit():void{
            if (this.world.isInited){
                asyncComplete();
            } else {
                this.server.getWorldData(this);
            };
        }
        override protected function parse(_arg1:Object):Boolean{
            this.parseZoneData(_arg1);
            this.world.isInited = true;
            return (true);
        }
        private function parseZoneData(_arg1:Object):void{
            var _local2:Object = _arg1.world[2];
            this.world.name = _local2.name;
            this.world.description = _local2.description;
            this.world.requiredLevel = _local2.required_level;
            this.parseZones(_local2.zones);
            var _local3:Zone = this.world.getZone(2);
            if (!_local3.getLocation(0)){
                _local3.addLocation(this.world.getLocation(0));
            };
        }
        private function parseZones(_arg1:Object):void{
            var _local2:String;
            var _local3:uint;
            var _local4:Object;
            var _local5:Zone;
            var _local6:Array;
            var _local7:Location;
            for (_local2 in _arg1) {
                _local3 = uint(_local2);
                _local4 = _arg1[_local2];
                _local5 = this.world.getZone(_local3);
                _local5.name = _local4.name;
                _local5.description = _local4.description;
                _local5.requiredLevel = _local4.required_level;
                _local5.taxiStop = this.world.getLocation(_local4.home_location_id);
                this.parseLocations(_local5, _local4.locations);
                _local6 = [];
                for each (_local7 in _local5.locations) {
                    _local6.push(_local7.id);
                };
            };
        }
        public function parseLocations(_arg1:Zone, _arg2:Object):void{
            var _local3:String;
            var _local4:uint;
            var _local5:Object;
            var _local6:Location;
            for (_local3 in _arg2) {
                _local4 = uint(_local3);
                _local5 = _arg2[_local3];
                _local6 = this.world.getLocation(_local4);
                _arg1.addLocation(_local6);
                _local6.name = _local5.name;
                _local6.background = uint(_local5.background_id);
                _local6.targetLevel = int(_local5.target_level);
                if (_local4 == 0){
                    _local6.targetLevel = -1;
                };
                _local6.neighbours = this.parseNeighbours(_local5.navigation_bundle);
                if (_local5.restrictions_bundle){
                    _local6.requiredVictories = this.parseRequiredLocations(_local5.restrictions_bundle.b);
                    _local6.requiredVisits = this.parseRequiredLocations(_local5.restrictions_bundle.l);
                    _local6.requiredQuests = this.parseRequiredQuests(_local5.restrictions_bundle.q);
                };
            };
        }
        private function parseNeighbours(_arg1:Object):Vector.<Location>{
            var _local3:String;
            var _local4:uint;
            var _local2:Vector.<Location> = new Vector.<Location>();
            for (_local3 in _arg1) {
                _local4 = uint(_local3);
                _local2.push(this.world.getLocation(_local4));
            };
            return (_local2);
        }
        private function parseRequiredLocations(_arg1:Object):Vector.<Location>{
            var _local3:uint;
            var _local2:Vector.<Location> = new Vector.<Location>();
            for each (_local3 in _arg1) {
                _local2.push(this.world.getLocation(_local3));
            };
            return (_local2);
        }
        private function parseRequiredQuests(_arg1:Object):Vector.<QuestVO>{
            var _local3:uint;
            var _local4:QuestVO;
            var _local2:Vector.<QuestVO> = new Vector.<QuestVO>();
            for each (_local3 in _arg1) {
                _local4 = this.quests.getQuestById(_local3);
                if (!_local4){
                    _local4 = new QuestVO();
                    _local4.isComplete = false;
                    _local4.id = _local3;
                };
                _local2.push(_local4);
            };
            return (_local2);
        }

    }
}//package com.gaiaonline.monster.service.process 
