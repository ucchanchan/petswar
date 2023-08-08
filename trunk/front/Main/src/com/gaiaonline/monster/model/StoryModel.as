//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {

    public class StoryModel {

        public var id:String;
        public var loseId:String;
        public var winId:String;

        public function init(_arg1:Object):void{
            if (!_arg1){
                return;
            };
            if ((_arg1 is String)){
                this.id = String(_arg1);
            } else {
                this.id = (((_arg1.main) && ((_arg1.main.length > 0)))) ? _arg1.main : null;
                this.loseId = (((_arg1.lose) && ((_arg1.lose.length > 0)))) ? _arg1.lose : null;
                this.winId = (((_arg1.win) && ((_arg1.win.length > 0)))) ? _arg1.win : null;
            };
        }
        public function reset():void{
            this.id = null;
            this.loseId = null;
            this.winId = null;
        }

    }
}//package com.gaiaonline.monster.model 
