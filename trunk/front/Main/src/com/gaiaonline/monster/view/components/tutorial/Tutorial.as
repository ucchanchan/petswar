//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.tutorial {
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.lib.assets.*;

    public class Tutorial extends Panel {

        private var asset:Asset;
        private var _complete:Signal;
        private var _signaller:SignallingAsset;

        public function Tutorial(_arg1:Asset){
            this._complete = new Signal();
            addChild(_arg1.self);
            if (_arg1.isComplete){
                this.onAssetComplete(_arg1);
            } else {
                _arg1.complete.addOnce(this.onAssetComplete);
            };
        }
        public function get complete():Signal{
            return (this._complete);
        }
        private function onAssetComplete(_arg1:Asset):void{
            this._signaller = (_arg1.content as SignallingAsset);
            if (this._signaller){
                this._signaller.signal.add(this.onSignal);
            };
        }
        private function onSignal(_arg1:String):void{
            if (_arg1 == "complete"){
                this._complete.dispatch();
            };
        }

    }
}//package com.gaiaonline.monster.view.components.tutorial 
