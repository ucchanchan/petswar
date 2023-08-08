//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;

    public class MonsterAttackAnim extends MonsterAnim implements IMonsterAttackAnim {

        protected var _hit:AnimSignal;
        private var _sound:SoundProxy;

        public function MonsterAttackAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:FightMonster, _arg4:SoundProxy){
            super(_arg1, _arg2, _arg3);
            this._hit = new AnimSignal();
            this._sound = _arg4;
        }
        override public function play():void{
            super.play();
            this._sound.play();
        }
        override protected function onSignal(_arg1:Object):void{
            switch (_arg1){
                case "hit":
                    this._hit.dispatch(this);
                    break;
                default:
                    super.onSignal(_arg1);
                    break;
            };
        }
        public function get hit():AnimSignal{
            return (this._hit);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
