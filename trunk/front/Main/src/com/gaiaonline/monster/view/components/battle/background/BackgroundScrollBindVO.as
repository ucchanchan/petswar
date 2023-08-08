//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.background {
    import flash.display.*;
    import com.gaiaonline.monster.view.components.battle.background.*;

    class BackgroundScrollBindVO {

        private var target:DisplayObject;
        private var layer:BackgroundScrollLayer;
        private var position:Number;
        private var bindBlur:Boolean;

        function BackgroundScrollBindVO(_arg1:DisplayObject, _arg2:BackgroundScrollLayer, _arg3:Number, _arg4:Boolean=true){
            this.target = _arg1;
            this.layer = _arg2;
            this.position = _arg3;
            this.bindBlur = _arg4;
        }
        public function update():void{
            this.layer.updateBound(this.target, this.position, this.bindBlur);
        }
        public function finalize():void{
            this.target = null;
            this.layer = null;
        }

    }
}//package com.gaiaonline.monster.view.components.battle.background 
