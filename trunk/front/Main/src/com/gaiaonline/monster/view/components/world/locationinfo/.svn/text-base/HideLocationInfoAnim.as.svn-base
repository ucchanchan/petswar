//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world.locationinfo {
    import com.gskinner.motion.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class HideLocationInfoAnim extends BasicAnim {

        private var info:LocationInfo;

        private static const DURATION:Number = 0.2;

        public function HideLocationInfoAnim(_arg1:LocationInfo){
            this.info = _arg1;
        }
        override public function play():void{
            new GTween(this.info, DURATION, {alpha:0}, {onComplete:this.onComplete});
        }
        private function onComplete(_arg1:GTween):void{
            this.info.visible = false;
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.world.locationinfo 
