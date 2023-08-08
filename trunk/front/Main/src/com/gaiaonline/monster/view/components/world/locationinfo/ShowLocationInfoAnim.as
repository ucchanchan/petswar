//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world.locationinfo {
    import com.gskinner.motion.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class ShowLocationInfoAnim extends BasicAnim {

        private var info:LocationInfo;
        private var x:int;
        private var y:int;
        private var name:String;
        private var background:Asset;
        private var isLocked:Boolean;
        private var targetLevel:int;
        private var currentLevel:int;
        private var tween:GTween;
        private var isCancelled:Boolean;
        private var lockedReason:String;

        private static const DURATION:Number = 0.2;

        public function ShowLocationInfoAnim(_arg1:LocationInfo, _arg2:int, _arg3:int, _arg4:String, _arg5:Asset, _arg6:Boolean, _arg7:int, _arg8:int, _arg9:String){
            this.info = _arg1;
            this.x = _arg2;
            this.y = _arg3;
            this.name = _arg4;
            this.background = _arg5;
            this.isLocked = _arg6;
            this.targetLevel = _arg7;
            this.currentLevel = _arg8;
            this.isCancelled = false;
            this.lockedReason = _arg9;
        }
        override public function play():void{
            if (this.isCancelled){
                return;
            };
            this.info.x = this.x;
            this.info.y = this.y;
            this.info.name = this.name;
            this.info.background = this.background;
            this.info.isLocked = this.isLocked;
            this.info.setLocationDifficulty(this.targetLevel, this.currentLevel);
            if (this.lockedReason){
                this.info.lockedReason = this.lockedReason;
            };
            this.info.alpha = 0;
            this.info.visible = true;
            this.tween = new GTween(this.info, DURATION, {alpha:1}, {onComplete:this.onComplete});
        }
        public function cancel():void{
            if (this.tween){
                this.tween.paused = true;
            } else {
                this.isCancelled = true;
            };
        }
        private function onComplete(_arg1:GTween):void{
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.world.locationinfo 
