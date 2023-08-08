//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.event {
    import flash.events.*;
    import __AS3__.vec.*;
    import gaia.moga.collections.model.*;

    public class MogaCollectionEvent extends Event {

        public var collections:Vector.<MogaCollectionVO>;

        public static const SHOW_COLLECTION_MANAGEMENT:String = "MogaCollectionEvent.SHOW_COLLECTION_MANAGEMENT";
        public static const REQUEST_COLLECTIONS_DATA:String = "MogaCollectionEvent.REQUEST_COLLECTION_VOS";
        public static const SHARE_COLLECTION_DATA:String = "MogaCollectionEvent.SHARE_COLLECTION_VOS";
        public static const COLLECTIONS_UPDATED:String = "MogaCollectionEvent.COLLECTIONS_UPDATED";
        public static const TRADE_IN_COLLECTION:String = "MogaCollectionEvent.TRADE_IN_COLLECTION";
        public static const SHOW_REWARD_CONFIRMATION:String = "MogaCollectionEvent.SHOW_REWARD_CONFIRMATION";

        public function MogaCollectionEvent(_arg1:String){
            super(_arg1);
        }
        override public function clone():Event{
            var _local1:MogaCollectionEvent = new MogaCollectionEvent(type);
            _local1.collections = this.collections;
            return (_local1);
        }

    }
}//package gaia.moga.collections.event 
