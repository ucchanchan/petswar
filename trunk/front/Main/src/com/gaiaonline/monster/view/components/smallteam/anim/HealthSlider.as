//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam.anim {
    import flash.display.*;
    import com.gskinner.motion.*;

    public class HealthSlider {

        private var slider:Sprite;
        private var tween:GTween;
        private var width:uint;
        private var isUpdated:Boolean;
        private var value:int;
        private var tint:uint;

        private static const DURATION:Number = 1;

        public function init(_arg1:uint, _arg2:Sprite):void{
            this.width = _arg1;
            this.slider = _arg2;
            this.tween = new GTween(_arg2, DURATION);
            _arg2.x = -(_arg1);
            if (this.isUpdated){
                this.update(this.value, this.tint);
            };
        }
        public function update(_arg1:Number, _arg2:uint):void{
            this.isUpdated = true;
            this.value = _arg1;
            this.tint = _arg2;
            if (this.tween){
                this.tween.setValues({x:((_arg1 - 1) * this.width), tint:_arg2});
            };
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam.anim 
