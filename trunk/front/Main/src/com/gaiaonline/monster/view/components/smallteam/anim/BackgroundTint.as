//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam.anim {
    import flash.display.*;
    import com.gskinner.motion.*;

    public class BackgroundTint {

        private var target:Sprite;
        private var tween:GTween;
        private var isUpdated:Boolean;
        private var tint:uint;

        private static const DURATION:Number = 0.1;

        public function init(_arg1:Sprite):void{
            this.target = _arg1;
            this.tween = new GTween(_arg1, DURATION, null, {onComplete:this.onComplete});
            if (this.isUpdated){
                this.update(this.tint);
            };
        }
        public function update(_arg1:uint):void{
            this.tint = _arg1;
            this.isUpdated = true;
            if (_arg1 != 0){
                this.target.visible = true;
            };
            if (this.tween){
                this.tween.setValue("tint", _arg1);
            };
        }
        private function onComplete(_arg1:GTween):void{
            if (this.tint == 0){
                this.target.visible = false;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam.anim 
