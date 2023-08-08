//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import flash.net.*;

    public class NapOption extends Sprite {

        private var _loader:Loader;
        private var _confirmed:Signal;
        private var _cancelled:Signal;

        public function NapOption(_arg1:String){
            this._confirmed = new Signal();
            this._cancelled = new Signal();
            this._loader = new Loader();
            this._loader.load(new URLRequest(_arg1));
            addChild(this._loader);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaded, false, 0, true);
        }
        private function onLoaded(_arg1:Event):void{
            var _local2:MovieClip = MovieClip(_arg1.currentTarget.content);
        }

    }
}//package com.gaiaonline.monster.view.components.home.ui 
