//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster {

    public class Timing {

        public static const SCT_BLOCKS:Boolean = false;
        public static const DELAY_AFTER_USER_ATTACK:uint = 500;
        public static const MIN_DELAY_BEFORE_DAMAGE_ANIM:uint = 500;
        public static const TIME_BETWEEN_COMBAT_MESSAGES:uint = 500;
        public static const MONSTER_RUN_AWAY_PAUSE:uint = 100;
        public static const MONSTER_RUN_ANIM:Number = 1.3;

        public static function get NPC_CHARGE_TIME():int{
            return (int(((Math.random() * 400) + 200)));
        }

    }
}//package com.gaiaonline.monster 
