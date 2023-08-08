//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.events.*;
    import gaia.moga.*;

    public class ChoiceResponseCommand extends SwapResponseCommand {

        override public function execute():void{
            getData();
            if (!updateData()){
                return;
            };
            model.playerMonster = mogas.read(result.user_monster.tap_in);
            processAttack();
            dispatch(new FightEvent(FightEvent.SWAP_PLAYER_MONSTER));
        }
        override protected function dataError():void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.SERVER_REPORTED_ERROR_AFTER_CHOOSING_STARTING_MOGA));
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
