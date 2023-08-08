//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import alecmce.async.*;
    import com.gaiaonline.monster.model.battle.*;

    public class SetBattleState extends AsyncBase {

        private var model:BattleModel;
        private var state:BattleState;

        public function SetBattleState(_arg1:BattleModel, _arg2:BattleState){
            this.model = _arg1;
            this.state = _arg2;
        }
        override protected function onInit():void{
            this.model.state = this.state;
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view 
