//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import com.gskinner.motion.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;

    public class StatusHideAnim implements Anim {

        private var status:BattleUIStatus;
        private var _complete:AnimSignal;

        private static const FADE_TIME:Number = 0.1;

        public function StatusHideAnim(_arg1:BattleUIStatus){
            this.status = _arg1;
            this._complete = new AnimSignal();
        }
        public function play():void{
            new GTween(this.status.ui, FADE_TIME, {alpha:0}, {onComplete:this.dispatchComplete});
        }
        private function dispatchComplete(_arg1:GTween):void{
            this.status.ui.visible = false;
            this.status.clear();
            this._complete.dispatch(this);
        }
        public function get complete():AnimSignal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
