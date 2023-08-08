//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win {
    import alecmce.ui.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class WinItemAnim extends StackWrapAnim {

        public function WinItemAnim(_arg1:Fight, _arg2:Asset, _arg3:uint, _arg4:Asset, _arg5:Asset, _arg6:String, _arg7:String, _arg8:SoundProxy){
            stack.push(new WinItemDisplayAnim(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8));
        }
        override public function play():void{
            super.play();
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win 
