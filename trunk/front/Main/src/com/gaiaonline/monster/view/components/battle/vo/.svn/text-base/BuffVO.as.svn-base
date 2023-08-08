//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {

    public class BuffVO {

        public var chance:uint;
        public var duration:uint;
        public var id:String;
        public var fn:BuffFunction;
        public var type:BuffType;
        public var name:String;
        public var level:uint;
        public var action:BuffAction;
        public var result:BuffResult;
        public var zodiac:uint;
        public var fromMod:Boolean;
        private var icon_id:uint;
        public var alreadyOn:Boolean;

        public function BuffVO(_arg1:BuffType, _arg2:Object){
            this.type = _arg1;
            this.chance = uint(_arg2.chance);
            this.duration = uint(_arg2.duration);
            this.id = _arg2.id;
            if (_arg2.mod_function_bundle){
                this.fn = new BuffFunction(_arg2.mod_function_bundle);
            };
            this.parseName(_arg2.name);
            this.action = BuffAction.parse(_arg2.on_action);
            this.result = BuffResult.parse(_arg2.result_type);
            this.zodiac = uint(_arg2.zodiac_id);
            this.icon_id = uint(_arg2.icon_id);
            this.fromMod = _arg2.from_mod;
            this.alreadyOn = Boolean(_arg2.already_on);
        }
        private function parseName(_arg1:String):void{
            var _local2:int = _arg1.indexOf(" ");
            if (_local2 == -1){
                this.name = _arg1;
                this.level = 0;
            } else {
                this.name = _arg1.substr(0, _local2);
                this.level = uint(_arg1.substring((_local2 + 1), _arg1.length));
            };
        }
        public function get icon():uint{
            return (this.icon_id);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
