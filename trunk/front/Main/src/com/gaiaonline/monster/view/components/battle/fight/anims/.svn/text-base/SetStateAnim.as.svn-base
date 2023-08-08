//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.model.battle.*;

    public class SetStateAnim implements Anim {

        private var _complete:AnimSignal;
        private var _model:BattleModel;
        private var _state:BattleState;

        public function SetStateAnim(_arg1:BattleModel, _arg2:BattleState){
            this._complete = new AnimSignal();
            this._model = _arg1;
            this._state = _arg2;
        }
        public function play():void{
            this._model.state = this._state;
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
