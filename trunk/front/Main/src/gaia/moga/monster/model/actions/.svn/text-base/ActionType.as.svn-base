//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model.actions {

    public class ActionType {

        private var _type:String;

        public static const PHYSICAL:ActionType = new ActionType("physical");
;
        public static const ZODIAC:ActionType = new ActionType("zodiac");
;
        public static const BUFF:ActionType = new ActionType("buff");
;
        public static const DEBUFF:ActionType = new ActionType("debuff");
;
        public static const ITEM:ActionType = new ActionType("item");
;

        public function ActionType(_arg1:String){
            this._type = _arg1;
        }
        public function toString():String{
            return (this._type);
        }

        public static function parse(_arg1:int, _arg2:int):ActionType{
            var _local3:ActionType;
            switch (_arg1){
                case 1:
                    _local3 = ((_arg2 == 1)) ? PHYSICAL : ZODIAC;
                    break;
                case 3:
                    _local3 = BUFF;
                    break;
                case 4:
                    _local3 = DEBUFF;
                    break;
                case 2:
                    _local3 = ITEM;
                    break;
            };
            return (_local3);
        }

    }
}//package gaia.moga.monster.model.actions 
