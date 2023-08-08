//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.vo {
    import gaia.moga.monster.model.*;

    public class ZodiacVO {

        public var id:uint;
        public var row:uint;
        public var name:String;
        public var description:String;
        public var startDate:int;
        public var endDate:int;
        public var elementID:uint;
        public var effectiveness:MogaEffectiveness;

        public function ZodiacVO(){
            this.effectiveness = new MogaEffectiveness();
        }
    }
}//package com.gaiaonline.monster.model.vo 
