//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {
    import org.osflash.signals.*;

    public class SettingsModel {

        private var _enablePrize:Boolean;
        public var updated:Signal;

        public function SettingsModel():void{
            this.updated = new Signal();
        }
        public function update(_arg1:Object):void{
            var _local2:Object;
            for each (_local2 in _arg1) {
                if (_arg1.email_opt_in == "y"){
                    this._enablePrize = true;
                };
            };
            this.updated.dispatch();
        }
        public function set enablePrize(_arg1:Boolean):void{
            this._enablePrize = _arg1;
            this.updated.dispatch();
        }
        public function get enablePrize():Boolean{
            return (this._enablePrize);
        }

    }
}//package com.gaiaonline.monster.model 
