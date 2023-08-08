//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.app {
    import flash.display.*;
    import alecmce.ui.*;

    public class Loading extends Sprite {

        private var content:MovieClip;

        public function Loading(_arg1:Asset){
            addChild(_arg1.self);
            if (_arg1.isComplete){
                this.setup(_arg1);
            } else {
                _arg1.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
            this.content = MovieClip(_arg1.content);
            this.visible = false;
        }
        override public function set visible(_arg1:Boolean):void{
            super.visible = _arg1;
            if (!this.content){
                return;
            };
            if (_arg1){
                this.content.play();
            } else {
                this.content.stop();
            };
        }

    }
}//package com.gaiaonline.monster.view.components.app 
