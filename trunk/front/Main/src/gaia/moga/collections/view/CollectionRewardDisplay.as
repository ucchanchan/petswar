//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import alecmce.ui.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.questrewards.*;
    import flash.filters.*;

    public class CollectionRewardDisplay extends Sprite {

        public var _item:Asset;
        public var _count:QuestRewardCount;
        public var _isMonster:Boolean;

        public function CollectionRewardDisplay(_arg1:Asset, _arg2:QuestRewardCount, _arg3:Boolean){
            this._item = _arg1;
            this._count = _arg2;
            this._isMonster = _arg3;
        }
        public function setup():void{
            var _local1:DisplayObject;
            var _local3:Number;
            var _local4:Number;
            var _local5:Rectangle;
            _local1 = this._item.self;
            if (this._isMonster){
                _local1.scaleX = (_local1.scaleY = 1);
                _local3 = (63 / _local1.width);
                _local4 = (63 / _local1.height);
                _local1.scaleX = (_local1.scaleY = Math.min(_local3, _local4));
                _local1.y = 20;
            } else {
                _local1.scaleX = (_local1.scaleY = 0.75);
                _local5 = _local1.getRect(_local1);
                _local1.x = (-(_local5.right) / 2);
                _local1.y = (-((_local5.top + _local5.bottom)) * 0.5);
            };
            addChild(_local1);
            this._count.setup();
            this._count.filters = [new GlowFilter(0, 1, 2, 2, 10, 10)];
            this._count.scaleX = (this._count.scaleY = 0.5);
            var _local2:Rectangle = this._count.getRect(this._count);
            if (this._isMonster){
                this._count.x = (65 - _local2.right);
                this._count.y = (31 - _local2.bottom);
            } else {
                this._count.x = (-(_local2.left) / 2);
                this._count.y = (-((_local2.top + _local2.bottom)) * 0.75);
            };
            addChild(this._count);
        }

    }
}//package gaia.moga.collections.view 
