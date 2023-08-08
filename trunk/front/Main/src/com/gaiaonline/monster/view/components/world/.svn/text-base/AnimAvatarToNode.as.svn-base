//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import com.gskinner.motion.*;
    import alecmce.async.*;

    public class AnimAvatarToNode extends AsyncBase {

        private var avatar:DisplayObject;
        private var node:WorldNode;

        private static const DURATION:Number = 2;

        public function AnimAvatarToNode(_arg1:DisplayObject, _arg2:WorldNode){
            this.avatar = _arg1;
            this.node = _arg2;
        }
        override protected function onInit():void{
            new GTween(this.avatar, DURATION, {x:this.node.x, y:this.node.y}, {onComplete:this.onComplete});
        }
        private function onComplete(_arg1:GTween):void{
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view.components.world 
