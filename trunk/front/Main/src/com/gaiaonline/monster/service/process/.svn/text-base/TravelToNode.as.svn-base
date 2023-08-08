//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.model.quests.*;

    public class TravelToNode extends GSIProcess {

		[Inject]
        public var world:WorldModel;
		[Inject]
        public var battle:BattleModel;
		[Inject]
        public var story:StoryModel;
		[Inject]
        public var quests:QuestModel;
		[Inject]
        public var service:GSIDataService;
        public var location:Location;
        public var route:Vector.<Location>;

        public function TravelToNode(){
            super("TravelToNode");
        }
        override protected function onInit():void{
            this.service.travelToLocation(this, this.location.id);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local3:int;
            var _local4:Location;
            var _local2 = !((_arg1.success == null));
            if (_local2){
                _local3 = _arg1.success.location.id;
                _local4 = this.world.getLocation(_local3);
                this.world.currentLocation = _local4;
                this.route = this.parseRoute(_arg1.success.route);
                this.parseNode(_arg1.success);
            };
            return (_local2);
        }
        private function parseRoute(_arg1:Array):Vector.<Location>{
            var _local5:Location;
            var _local2:Vector.<Location> = new Vector.<Location>();
            if (!_arg1){
                return (_local2);
            };
            var _local3:int = _arg1.length;
            var _local4:int;
            while (_local4 < _local3) {
                _local5 = this.world.getLocation(_arg1[_local4]);
                _local2.push(_local5);
                _local4++;
            };
            return (_local2);
        }
        private function parseNode(_arg1:Object):void{
            this.story.reset();
            var _local2:Boolean = _arg1.battle;
            var _local3:Boolean = _arg1.story_id;
            var _local4:Boolean = _arg1.quests;
            if (_local2){
                this.battle.init(_arg1.battle, _arg1.battle.npc, _arg1.estimates);
            };
            if (_local3){
                this.story.init(_arg1.story_id);
            };
            if (_local4){
                this.quests.init(_arg1.quests);
            };
            var _local5:Boolean = _local2;
            var _local6:Boolean = _local4;
            var _local7:Boolean = _arg1.npc;
            var _local8:Boolean;
            if (this.story.id){
                _local8 = true;
            };
            this.world.isBattle = _local5;
            this.world.isStory = _local8;
            this.world.isQuest = _local6;
            this.world.isNPC = _local7;
        }

    }
}//package com.gaiaonline.monster.service.process 
