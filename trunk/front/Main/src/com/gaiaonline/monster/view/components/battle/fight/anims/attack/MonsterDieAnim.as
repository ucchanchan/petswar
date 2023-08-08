//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.attack {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.monster.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.simple.*;

    public class MonsterDieAnim extends ParallelWrapAnim {

        public function MonsterDieAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:FightMonster, _arg4:BattleUIStatus, _arg5:SoundProxy=null){
            parallel.add(new MonsterOutAnim(_arg1, _arg2, _arg3));
            if (_arg5){
                parallel.add(new AnimSoundEffect(_arg5));
            };
            parallel.add(new StatusHideAnim(_arg4));
        }
        override public function play():void{
            super.play();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.attack 
