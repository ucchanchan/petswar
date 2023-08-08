//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {

    public class CreateUGCEventVO {

        public var eventId:int;
        public var timestamp:String;
        public var xid:String;
        public var invitees:Array;

        public function CreateUGCEventVO(){
            this.invitees = [];
        }
    }
}//package com.gaiaonline.monster.model.vo 
