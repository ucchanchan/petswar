//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.team.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.gwitter.*;

    public class NameMonsterMediator extends Mediator {

		[Inject]
        public var view:NameMonster;

        override public function onRegister():void{
            this.view.nameSubmitted.addOnce(this.onNameSubmitted);
            this.view.setFocus();
        }
        override public function onRemove():void{
            this.view.nameSubmitted.removeAll();
            this.view.dispose();
        }
        private function onNameSubmitted(_arg1:MonsterModel):void{
            dispatch(new TeamEvent(TeamEvent.NAME_MONSTER, {id:_arg1.id, monsterName:_arg1.name}));
            dispatch(new GwitterEvent(GwitterEvent.POST_TO_GWITTER, _arg1));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
