//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class SurpriseAttackAnim extends SignallingAssetAnim {

        public function SurpriseAttackAnim(_arg1:DisplayObjectContainer, _arg2:Asset){
            super(_arg1, _arg2);
        }
        override protected function actuallyPlay():void{
            signaller.signal.addOnce(this.onComplete);
            content.gotoAndPlay(1);
        }
        private function onComplete(_arg1:Object):void{
            content.stop();
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
