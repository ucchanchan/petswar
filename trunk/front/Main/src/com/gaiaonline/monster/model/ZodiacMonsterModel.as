//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import com.gaiaonline.monster.service.vo.*;
    import org.robotlegs.mvcs.*;

    public class ZodiacMonsterModel extends Actor {

        public var id:uint;
        public var zodiac:uint;
        public var name:String;
        public var description:String;
        public var attackStrength:uint;
        public var defenceStrength:uint;
        public var zodiacStrength:uint;
        public var speed:uint;

        public function ZodiacMonsterModel(_arg1:Object){
            var _local3:uint;
            super();
            this.id = _arg1.id;
            this.zodiac = _arg1.zodiac_id;
            this.name = _arg1.name;
            var _local2:Object = _arg1.level_upgrade_bundle;
            _local3 = _local2.physical_attack;
            this.attackStrength = ((_local3 < 56)) ? 1 : 2;
            _local3 = _local2.physical_defense;
            this.defenceStrength = ((_local3 < 56)) ? 1 : 2;
            _local3 = _local2.zodiac_attack;
            this.zodiacStrength = ((_local3 < 56)) ? 1 : 2;
            this.speed = _arg1.speed;
        }
        public function set text(_arg1:MonsterTextVO):void{
            this.name = _arg1.name;
            this.description = _arg1.description;
        }

    }
}//package com.gaiaonline.monster.model 
