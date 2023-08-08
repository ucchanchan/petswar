//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;

    public class StatusUpdateAnim implements Anim {

        private var status:BattleUIStatus;
        private var value:int;
        private var isDifferential:Boolean;
        private var _complete:AnimSignal;

        public function StatusUpdateAnim(_arg1:BattleUIStatus, _arg2:int, _arg3:Boolean=true){
            this.status = _arg1;
            this.value = _arg2;
            this.isDifferential = _arg3;
            this._complete = new AnimSignal();
        }
        public function play():void{
            this.status.complete.addOnce(this.onStatsComplete);
            if (this.isDifferential){
                this.status.adjust(this.value);
            } else {
                this.status.value = this.value;
            };
        }
        private function onStatsComplete(_arg1:BattleUIStatus):void{
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
