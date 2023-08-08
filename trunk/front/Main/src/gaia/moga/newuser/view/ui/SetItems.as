﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import com.gskinner.motion.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.newuser.view.ui.*;
    import alecmce.geom3D.*;
    import com.gskinner.motion.easing.*;

    class SetItems extends BasicAnim {

        private var carousel:SelectionCarousel;
        private var items:Vector.<SelectionItem>;
        private var viewpoint:Viewpoint3D;

        private static const DURATION:Number = 0.5;

        function SetItems(_arg1:SelectionCarousel, _arg2:Viewpoint3D, _arg3:Vector.<SelectionItem>){
            this.carousel = _arg1;
            this.viewpoint = _arg2;
            this.items = _arg3;
        }
        override public function play():void{
            this.carousel.setupItems(this.items);
            this.carousel.rotate(SelectionCarousel.ROTATE);
            new GTween(this.viewpoint.position, DURATION, {z:SelectionCarousel.NEAR}, {ease:Cubic.easeOut, onChange:this.onChange, onComplete:this.onComplete});
            new GTween(this.carousel.ui, DURATION, {alpha:1}, {ease:Quadratic.easeOut});
        }
        private function onChange(_arg1:GTween):void{
            this.viewpoint.position = this.viewpoint.position;
        }
        private function onComplete(_arg1:GTween):void{
            _complete.dispatch(this);
        }

    }
}//package gaia.moga.newuser.view.ui 
