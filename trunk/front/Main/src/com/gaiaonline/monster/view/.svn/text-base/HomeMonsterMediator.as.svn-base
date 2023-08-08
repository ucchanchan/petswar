//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.home.*;
    import alecmce.ui.interaction.*;
    import org.robotlegs.mvcs.*;
    import flash.filters.*;

    public class HomeMonsterMediator extends Mediator {

		[Inject]
        public var view:HomeMonster;
        private var _clickDrag:ClickAndDrag;

        override public function onRegister():void{
            this._clickDrag = new ClickAndDrag(this.view);
            this._clickDrag.beginDrag.add(this.onStartDrag);
            this.view.monsterRollOver.add(this.onMonsterRollover);
            this.view.monsterRollOut.add(this.onMonsterRollout);
        }
        override public function onRemove():void{
            if (this.view.monsterRollOut){
                this.view.monsterRollOut.remove(this.onMonsterRollout);
            };
            if (this.view.monsterRollOver){
                this.view.monsterRollOver.remove(this.onMonsterRollover);
            };
            this.view.dispose();
        }
        private function onStartDrag(_arg1:HomeMonster):void{
            this._clickDrag.endDrag.addOnce(this.onEndDrag);
            this.view.monsterRollOut.remove(this.onMonsterRollout);
            dispatch(new HomeMonsterEvent(HomeMonsterEvent.START_DRAG, this.view));
        }
        private function onEndDrag(_arg1:HomeMonster):void{
            dispatch(new HomeMonsterEvent(HomeMonsterEvent.END_DRAG, this.view));
            this.view.monsterRollOut.add(this.onMonsterRollout);
        }
        private function onMonsterRollover(_arg1:MouseEvent):void{
            this.view.pause();
            var _local2:GlowFilter = new GlowFilter(0xFFFFFF, 0.8, 10, 10);
            this.view.filters = [_local2];
            this.view.scaleX = ((this.view.scaleX)<0) ? this.view.scaleX = -1.2 : this.view.scaleX = 1.2;
            this.view.scaleY = 1.2;
            dispatch(new HomeMonsterEvent(HomeMonsterEvent.ROLL_OVER, this.view));
        }
        private function onMonsterRollout(_arg1:MouseEvent):void{
            this.view.filters = null;
            this.view.scaleX = ((this.view.scaleX)<0) ? this.view.scaleX = -1 : this.view.scaleX = 1;
            this.view.scaleY = 1;
            this.view.resume();
            dispatch(new HomeMonsterEvent(HomeMonsterEvent.ROLL_OUT, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
