//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.questrewards {
    import flash.display.*;
    import alecmce.ui.*;

    public class QuestRewardCount extends Sprite {

        private var asset:Asset;
        private var _count:uint;

        public function QuestRewardCount(_arg1:Asset, _arg2:uint){
            this.asset = _arg1;
            this._count = _arg2;
        }
        public function setup():void{
            var _local1:MovieClip = MovieClip(this.asset.content);
            _local1.label.text = ("x" + this._count.toString());
            addChild(_local1);
        }
        public function get count():uint{
            return (this._count);
        }

    }
}//package com.gaiaonline.monster.view.components.questrewards 
