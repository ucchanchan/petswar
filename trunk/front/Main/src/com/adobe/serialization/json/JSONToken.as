//Created by Action Script Viewer - http://www.buraks.com/asv
package com.adobe.serialization.json {

    public class JSONToken {

        private var _value:Object;
        private var _type:int;

        public function JSONToken(_arg1:int=-1, _arg2:Object=null){
            _type = _arg1;
            _value = _arg2;
        }
        public function get value():Object{
            return (_value);
        }
        public function get type():int{
            return (_type);
        }
        public function set type(_arg1:int):void{
            _type = _arg1;
        }
        public function set value(_arg1:Object):void{
            _value = _arg1;
        }

    }
}//package com.adobe.serialization.json 
