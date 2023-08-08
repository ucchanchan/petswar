//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.questrewards {
    import flash.display.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import com.gaiaonline.monster.model.quests.rewards.*;

    public class QuestRewards extends Sprite {

        public var data:Vector.<QuestRewardVO>;
        private var spinny:MovieClip;
        private var list:Vector.<QuestRewardItem>;
        private var count:uint;

        private static const PADDING:uint = 5;

        public function QuestRewards(_arg1:Vector.<QuestRewardVO>, _arg2:MovieClip=null){
            this.data = _arg1;
            this.spinny = _arg2;
            this.showSpinny();
        }
        public function display(_arg1:Vector.<QuestRewardItem>):void{
            this.list = _arg1;
            this.count = _arg1.length;
            this.hideSpinny();
            this.setup();
        }
        private function showSpinny():void{
            if (!this.spinny){
                return;
            };
            this.spinny.visible = true;
            this.spinny.play();
        }
        private function hideSpinny():void{
            if (!this.spinny){
                return;
            };
            this.spinny.stop();
            this.spinny.visible = false;
        }
        private function setup():void{
            var _local1:int;
            var _local2:QuestRewardItem;
            var _local4:Vector.<Rectangle>;
            var _local6:Rectangle;
            var _local3:uint;
            _local4 = new Vector.<Rectangle>(this.count, true);
            _local1 = 0;
            while (_local1 < this.count) {
                _local2 = this.list[_local1];
                _local2.setup();
                _local6 = _local2.getRect(_local2);
                _local4[_local1] = _local6;
                _local3 = (_local3 + (_local6.width + PADDING));
                _local1++;
            };
            _local3 = (_local3 - PADDING);
            var _local5:Number = (-(_local3) * 0.5);
            _local1 = 0;
            while (_local1 < this.count) {
                _local2 = this.list[_local1];
                _local2.x = (_local5 - _local4[_local1].left);
                _local5 = (_local5 + (_local4[_local1].width + PADDING));
                addChild(_local2);
                _local1++;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.questrewards 
