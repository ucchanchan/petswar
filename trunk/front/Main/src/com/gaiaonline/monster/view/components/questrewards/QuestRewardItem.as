//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.questrewards {
    import flash.display.*;
    import alecmce.ui.*;
    import flash.geom.*;

    public class QuestRewardItem extends Sprite {

        public var item:Asset;
        public var count:QuestRewardCount;

        public function QuestRewardItem(_arg1:Asset, _arg2:QuestRewardCount){
            this.item = _arg1;
            this.count = _arg2;
        }
        public function setup():void{
            var _local1:DisplayObject;
            var _local2:Rectangle;
            _local1 = this.item.self;
            _local2 = _local1.getRect(_local1);
            _local1.x = -(_local2.right);
            _local1.y = (-((_local2.top + _local2.bottom)) * 0.5);
            addChild(_local1);
            this.count.setup();
            _local2 = this.count.getRect(this.count);
            this.count.x = -(_local2.left);
            this.count.y = (-((_local2.top + _local2.bottom)) * 0.5);
            addChild(this.count);
        }

    }
}//package com.gaiaonline.monster.view.components.questrewards 
