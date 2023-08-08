//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.combatlog.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import __AS3__.vec.*;
    import alecmce.ui.button.*;
    import flash.text.*;

    public class CombatLog {

        private var ui:CombatLogButton;
        private var messages:MovieClip;
        private var pool:Vector.<CombatLogItem>;
        private var stack:Vector.<CombatLogItem>;
        private var position:int;
        private var current:CombatLogItem;
        private var tween:GTween;

        private static const MAXIMUM:uint = 15;

        public function CombatLog(_arg1:MovieClip){
            this.ui = new CombatLogButton(_arg1);
            this.ui.clicked.add(this.toggleExpansion);
            this.init();
        }
        private function toggleExpansion(_arg1:MovieClipButton):void{
            this.ui.isShuttered = !(this.ui.isShuttered);
        }
        private function init():void{
            this.messages = this.ui.ui.message;
            var _local1:TextField = TextField(this.messages.message);
            var _local2:TextFormat = _local1.getTextFormat();
            this.messages.removeChild(_local1);
            this.pool = new Vector.<CombatLogItem>();
            var _local3:int;
            while (_local3 < MAXIMUM) {
                this.pool.push(new CombatLogItem(_local2));
                _local3++;
            };
            this.stack = new Vector.<CombatLogItem>();
            this.tween = new GTween(this.messages, 0.4, {y:0});
        }
        public function clear():void{
            var _local1:CombatLogItem;
            for each (_local1 in this.stack) {
                this.messages.removeChild(_local1);
                this.pool.push(_local1);
            };
            this.stack.length = 0;
            this.position = 0;
        }
        public function display(_arg1:String):void{
            if (this.current){
                this.current.clearHighlight();
            };
            if (this.stack.length == MAXIMUM){
                this.current = this.stack.shift();
            } else {
                this.current = this.pool.shift();
            };
            this.current.define(_arg1);
            this.current.y = this.position;
            this.position = (this.position + this.current.height);
            this.messages.addChild(this.current);
            this.stack.push(this.current);
            this.tween.setValue("y", -(this.position));
        }

    }
}//package gaia.moga.combatlog.view.ui 
