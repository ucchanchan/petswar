//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.combatlog.event {
    import flash.events.*;

    public class CombatLogEvent extends Event {

        public var message:String;

        public static const LOG:String = "CombatLogEvent.LOG";

        public function CombatLogEvent(_arg1:String, _arg2:String){
            super(_arg1);
            this.message = _arg2;
        }
        override public function clone():Event{
            return (new CombatLogEvent(type, this.message));
        }

    }
}//package gaia.moga.combatlog.event 
