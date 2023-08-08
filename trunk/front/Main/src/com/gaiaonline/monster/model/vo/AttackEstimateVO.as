//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {

    public class AttackEstimateVO {

        public var chance:int;
        public var maxDamage:int;
        public var minDamage:int;
        public var zodiacMod:Number;
        public var attackId:int;

        public function AttackEstimateVO(_arg1:Object){
            this.chance = _arg1.chance;
            this.maxDamage = _arg1.max_damage;
            this.minDamage = _arg1.min_damage;
            this.zodiacMod = Number(_arg1.zodiac_mod);
        }
    }
}//package com.gaiaonline.monster.model.vo 
