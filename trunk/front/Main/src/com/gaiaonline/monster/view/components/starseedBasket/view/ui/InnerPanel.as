//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui {
    import flash.display.*;

    public class InnerPanel {

        protected var _asset:MovieClip;

        public function InnerPanel(_arg1:MovieClip){
            this._asset = _arg1;
        }
        public function set visible(_arg1:Boolean):void{
            this._asset.visible = _arg1;
        }
        public function get visible():Boolean{
            return (this._asset.visible);
        }
        public function dispose(_arg1:Boolean=true):void{
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui 
