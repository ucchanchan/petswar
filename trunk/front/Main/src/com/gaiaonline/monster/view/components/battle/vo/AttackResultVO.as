//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {
    import com.gaiaonline.monster.model.*;
    import gaia.moga.monster.model.actions.*;

    public class AttackResultVO {

        public var isPlayer:Boolean;
        public var attacker:MonsterModel;
        public var target:MonsterModel;
        public var attackingMove:Action;
        public var hpAtStartOfRound:uint;
        public var opponentHpAtStartOfRound:int;
        public var damage:int;
        public var critical:Boolean;
        public var hp:uint;
        public var maxHP:uint;
        public var isRun:Boolean;
        public var ranAway:Boolean;
        public var miss:Boolean;
        public var wonRound:Boolean;
        public var wonBattle:Boolean;

        public function AttackResultVO(_arg1:Boolean, _arg2:MonsterModel, _arg3:MonsterModel, _arg4:Object){
            this.isPlayer = _arg1;
            this.attacker = _arg2;
            this.target = _arg3;
            this.damage = _arg4.damage;
            this.critical = (_arg4.critical == 1);
            this.hp = _arg3.hp;
            this.maxHP = _arg3.maxHP;
            this.hpAtStartOfRound = _arg4.round_start_hp;
            this.opponentHpAtStartOfRound = _arg4.round_start_opponent_hp;
            this.isRun = !((_arg4.ran_away == null));
            if (this.isRun){
                this.ranAway = _arg4.ran_away;
            };
            this.miss = ((!(this.isRun)) && ((_arg4.attack_miss == 1)));
            this.wonRound = (_arg4.won_round == 1);
            this.wonBattle = (_arg4.won_battle == 1);
        }
    }
}//package com.gaiaonline.monster.view.components.battle.vo 
