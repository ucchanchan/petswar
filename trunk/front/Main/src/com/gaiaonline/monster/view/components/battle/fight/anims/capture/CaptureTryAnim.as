//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.capture {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.simple.*;

    public class CaptureTryAnim extends ParallelWrapAnim {

        public var asset:Asset;

        private static const DELAY:uint = 750;

        public function CaptureTryAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:SoundProxy){
            this.asset = _arg2;
            parallel.add(new CaptureTryAssetAnim(_arg1, _arg2));
            parallel.add(new AnimSoundEffect(_arg3));
            parallel.add(new DelayAnim(DELAY));
        }
    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.capture 
