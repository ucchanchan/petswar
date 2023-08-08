//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gwitter {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import com.adobe.serialization.json.*;

    public class PostToGwitter extends GSIProcess {

		[Inject]
        public var world:WorldModel;
		[Inject]
        public var server:GSIDataService;
        public var moga:MonsterModel;

        private static const GWITTER_GSI_METHOD:uint = 6844;
        private static const CAPTURE_WITH_LOCATION_AND_LEVEL:uint = 3;

        public function PostToGwitter(){
            super("PostToGwitter");
        }
        override protected function onInit():void{
            var _local1:Location = this.world.currentLocation;
            var _local2:Object = {};
            _local2["monster_id"] = this.moga.monsterID;
            _local2["level"] = this.moga.level;
            _local2["location"] = _local1.name;
            _local2["monster"] = this.moga.defaultName;
            _local2["monster_name"] = this.moga.name;
            this.server.post(this, GWITTER_GSI_METHOD, CAPTURE_WITH_LOCATION_AND_LEVEL, JSON.encode(_local2));
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.isError){
                return (false);
            };
            return (true);
        }

    }
}//package gaia.moga.gwitter 
