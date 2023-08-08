//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.combatlog.view {
    import com.gaiaonline.monster.service.*;
    import gaia.moga.combatlog.event.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.combatlog.view.ui.*;

    public class CombatLogMediator extends Mediator {

		[Inject]
        public var async:AsyncService;
		[Inject]
        public var view:CombatLog;

        override public function onRegister():void{
            eventDispatcher.addEventListener(CombatLogEvent.LOG, this.onLog);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(CombatLogEvent.LOG, this.onLog);
        }
        private function onLog(_arg1:CombatLogEvent):void{
            this.view.display(_arg1.message);
        }

    }
}//package gaia.moga.combatlog.view 
