//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.ads {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.lib.assets.*;

    public class SimpleAd extends Panel {

        private var signaller:SignallingAsset;
        private var numFriends:int;
        public var complete:Signal;
        private var test:String;

        private static const MIN_FRIENDS:int = 20;

        public function SimpleAd(_arg1:Asset, _arg2:String, _arg3:int=0){
            this.numFriends = _arg3;
            this.test = _arg2;
            this.complete = new Signal();
            addChild(_arg1.self);
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.add(this.init);
            };
        }
        private function init(_arg1:Asset):void{
            var _local3:Number;
            var _local2:MovieClip = MovieClip(_arg1.content);
            this.signaller = SignallingAsset(_local2);
            this.signaller.signal.add(this.onSignal);
            if (this.numFriends){
                _local3 = (this.numFriends / MIN_FRIENDS);
                _local2.friendBar.scaleX = _local3;
                _local2.numFriends.text = (this.numFriends + " friends");
                _local2.minFriends.text = (MIN_FRIENDS + " friends");
            };
        }
        private function onSignal(_arg1:Object):void{
            this.complete.dispatch(_arg1, this.test);
        }

    }
}//package com.gaiaonline.monster.view.components.ads 
