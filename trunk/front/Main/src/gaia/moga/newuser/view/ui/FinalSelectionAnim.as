//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import flash.utils.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gskinner.motion.easing.*;

    class FinalSelectionAnim extends BasicAnim {

        private var container:DisplayObjectContainer;
        private var carousel:SelectionCarousel;
        private var item:SelectionItem;
        private var monster:DisplayObject;
        private var timer:Timer;

        private static const DELAY:uint = 3000;

        function FinalSelectionAnim(_arg1:DisplayObjectContainer, _arg2:SelectionCarousel, _arg3:SelectionItem){
            this.container = _arg1;
            this.carousel = _arg2;
            this.item = _arg3;
        }
        override public function play():void{
            this.monster = this.item.monster.self;
            var _local1:Rectangle = this.monster.getRect(this.monster);
            var _local2:Rectangle = this.monster.getRect(this.container);
            var _local3:Number = (_local2.width / _local1.width);
            this.monster.x = (_local2.x - (_local1.left * _local3));
            this.monster.y = (_local2.y - (_local1.top * _local3));
            this.monster.scaleX = (this.monster.scaleY = _local3);
            this.container.addChild(this.monster);
            new GTween(this.carousel.ui, 0.5, {alpha:0}, {onComplete:this.onCarouselHidden});
            new GTween(this.monster, 1, {x:390, y:560, scaleX:2.5, scaleY:2.5}, {ease:Quadratic.easeInOut, onComplete:this.onComplete});
        }
        private function onCarouselHidden(_arg1:GTween):void{
            this.carousel.ui.visible = false;
        }
        private function onComplete(_arg1:GTween):void{
            this.timer = new Timer(DELAY, 1);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.timer.start();
        }
        private function onTimerComplete(_arg1:TimerEvent):void{
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.timer = null;
            _complete.dispatch(this);
        }

    }
}//package gaia.moga.newuser.view.ui 
