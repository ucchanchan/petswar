//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class PromoteContainerAnim extends BasicAnim {

        private var _fight:Fight;
        private var _container:MonsterContainer;

        public function PromoteContainerAnim(_arg1:Fight, _arg2:MonsterContainer){
            this._fight = _arg1;
            this._container = _arg2;
        }
        override public function play():void{
            this._fight.promote(this._container);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
