//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.world {
    import com.gaiaonline.monster.model.vo.*;
    import __AS3__.vec.*;

    public class Location {

        public var id:uint;
        public var neighbours:Vector.<Location>;
        public var requiredVisits:Vector.<Location>;
        public var requiredVictories:Vector.<Location>;
        public var requiredQuests:Vector.<QuestVO>;
        public var name:String;
        public var background:uint;
        public var zone:Zone;
        public var hasVisited:Boolean;
        public var hasWon:Boolean;
        public var isCurrent:Boolean;
        public var isNewNode:Boolean;
        public var targetLevel:int;
        public var isMalformed:Boolean;

        private static const STORY_ID:int = 0;

        public function Location(_arg1:uint){
            this.id = _arg1;
            this.neighbours = new Vector.<Location>();
            this.requiredVisits = new Vector.<Location>();
            this.requiredVictories = new Vector.<Location>();
            this.requiredQuests = new Vector.<QuestVO>();
            this.hasVisited = (_arg1 == 0);
            this.hasWon = false;
            this.isCurrent = false;
            this.isMalformed = false;
            this.isNewNode = true;
        }
        public function isAvailable():Boolean{
            var _local3:Location;
            if (((this.isCurrent) || (this.isHomeOrTaxiStop))){
                return (true);
            };
            var _local1:uint = this.neighbours.length;
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = this.neighbours[_local2];
                if (_local3.isCurrent){
                    return (true);
                };
                _local2++;
            };
            return (false);
        }
        public function isVisible():Boolean{
            var _local1:int;
            var _local2:Location;
            if (((this.isCurrent) || (this.hasVisited))){
                return (true);
            };
            _local1 = this.neighbours.length;
            while (_local1--) {
                _local2 = this.neighbours[_local1];
                if (((_local2.hasVisited) || (_local2.isCurrent))){
                    return (true);
                };
            };
            return (false);
        }
        public function get isHomeOrTaxiStop():Boolean{
            return ((((this.id == 0)) || ((this == this.zone.taxiStop))));
        }
        public function get isHome():Boolean{
            return ((this.id == 0));
        }
        public function isLocked():Boolean{
            var _local1:int;
            _local1 = this.requiredVisits.length;
            while (_local1--) {
                if (!this.requiredVisits[_local1].hasVisited){
                    return (true);
                };
            };
            _local1 = this.requiredVictories.length;
            while (_local1--) {
                if (!this.requiredVictories[_local1].hasWon){
                    return (true);
                };
            };
            _local1 = this.requiredQuests.length;
            while (_local1--) {
                if (!((this.requiredQuests[_local1].isComplete) || (this.requiredQuests[_local1].hasBeenCompleted))){
                    return (true);
                };
            };
            return (false);
        }
        public function get isStory():Boolean{
            return ((this.targetLevel == STORY_ID));
        }

    }
}//package com.gaiaonline.monster.model.world 
