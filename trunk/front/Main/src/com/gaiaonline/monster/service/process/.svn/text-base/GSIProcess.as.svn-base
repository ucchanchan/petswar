//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import alecmce.async.*;

    public class GSIProcess extends AsyncBase {

        public var log:String;
        private var _name:String;

        public function GSIProcess(_arg1:String){
            this._name = _arg1;
            this.log = "";
        }
        final public function response(_arg1:Object):void{
            if (this.parse(_arg1)){
                asyncComplete();
            } else {
                asyncError(((this.log == "")) ? "GSI Process Failed" : this.log);
            };
        }
        protected function parse(_arg1:Object):Boolean{
            return (false);
        }
        final override public function get name():String{
            return (this._name);
        }

    }
}//package com.gaiaonline.monster.service.process 
