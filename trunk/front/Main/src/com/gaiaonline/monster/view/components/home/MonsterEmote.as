//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.net.*;

    public class MonsterEmote extends Sprite {

        private var _loader:Loader;
        private var _url:String;

        public function MonsterEmote(_arg1:String){
            this._url = _arg1;
            this.init();
        }
        private function init():void{
            this._loader = new Loader();
            this._loader.load(new URLRequest(this._url));
            addChild(this._loader);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
