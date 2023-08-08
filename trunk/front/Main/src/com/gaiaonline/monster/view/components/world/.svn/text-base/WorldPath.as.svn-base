//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import com.gaiaonline.monster.model.world.*;

    public class WorldPath {

        private var path:MovieClip;
        private var isNew:Boolean;
        private var from:Location;
        private var unto:Location;

        public function WorldPath(_arg1:MovieClip, _arg2:Location, _arg3:Location){
            this.path = _arg1;
            this.from = _arg2;
            this.unto = _arg3;
            this.configurePath();
        }
        private function configurePath():void{
            var _local1:Boolean = ((this.unto.isLocked()) || (this.from.isLocked()));
            this.path.visible = !(_local1);
            this.isNew = ((((!(_local1)) && (this.from.isCurrent))) && (!(this.unto.hasVisited)));
        }
        public function play():void{
            if (this.isNew){
                this.path.gotoAndPlay(1);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.world 
