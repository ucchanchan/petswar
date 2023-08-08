//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;

    public class RechargeMonster extends GSIProcess {

		[Inject]
        public var service:GSIDataService;
		[Inject]
        public var battle:BattleModel;
        
        private var battleID:String;
		public var monster:MonsterModel;

        public function RechargeMonster(){
            super("RechargeMonster");
        }
        override protected function onInit():void{
            this.battleID = (this.battle.isBattleInited) ? this.battle.id : null;
            this.service.rechargeMonster(this, this.monster, this.battleID, this.battle.playerMonster);
        }
        override protected function parse(_arg1:Object):Boolean{
            if (this.battleID == null){
                return ((_arg1.success[1] == "Recharged all slots and hp"));
            };
            return (this.parseBattleData(_arg1));
        }
        private function parseBattleData(_arg1:Object):Boolean{
            var _local2:Object = _arg1[0].battle_result;
            if (_local2["error"] != null){
                return (false);
            };
            return ((_local2.user_monster.applied_to == this.monster.id));
        }

    }
}//package com.gaiaonline.monster.service.process 
