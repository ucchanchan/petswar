//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {
    import com.gaiaonline.monster.model.*;

    public class BuffResultVO extends BuffVO {

        public var agent:MonsterModel;
        public var target:MonsterModel;
        public var isTargetPlayer:Boolean;
        public var isAppliedToSelf:Boolean;
        public var modApplied:BuffVO;
        public var value:int;

        public function BuffResultVO(_arg1:MonsterModel, _arg2:MonsterModel, _arg3:Boolean, _arg4:Boolean, _arg5:Object){
            super(BuffType.parse(_arg5.mod_type), _arg5);
            this.agent = _arg1;
            this.target = _arg2;
            this.isTargetPlayer = _arg3;
            this.isAppliedToSelf = _arg4;
            this.value = _arg5.value;
            if (_arg5.mod_applied){
                this.modApplied = new BuffVO(BuffType.parse(_arg5.mod_applied.mod_type), _arg5.mod_applied);
            };
        }
    }
}//package com.gaiaonline.monster.view.components.battle.vo 
