//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.homeTutorial {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.lib.assets.*;

    public class HomeTutorial extends Panel {

        private var _complete:Signal;
        private var _asset:Asset;

        public function HomeTutorial(_arg1:Asset){
            this._complete = new Signal();
            this._asset = _arg1;
            addChild(this._asset.self);
            if (this._asset.isComplete){
                this.init();
            } else {
                this._asset.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            SignallingAsset(this._asset.content).signal.add(this.onAssetSignal);
        }
        private function onAssetSignal(_arg1:Object):void{
            MovieClip(this._asset.content).gotoAndStop("end");
            this._complete.dispatch();
        }
        public function get complete():Signal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.homeTutorial 
