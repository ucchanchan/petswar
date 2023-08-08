//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import com.gaiaonline.monster.view.components.battle.background.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class CriticalHitAnim extends BasicAnim {

        private var _shock:BackgroundShock;

        public function CriticalHitAnim(_arg1:Background){
            this._shock = new BackgroundShock();
            this._shock.addLayer(_arg1.bg.self, 11);
            this._shock.addLayer(_arg1.mg.self, 22);
            this._shock.addLayer(_arg1.fg.self, 44);
        }
        override public function play():void{
            this._shock.complete.addOnce(this.onShockComplete);
            this._shock.shock();
        }
        private function onShockComplete(_arg1:BackgroundShock):void{
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
