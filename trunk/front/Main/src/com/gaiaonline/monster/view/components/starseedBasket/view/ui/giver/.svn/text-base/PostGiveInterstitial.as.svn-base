//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import flash.text.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;

    public class PostGiveInterstitial extends InnerPanel {

        private var _messageField:TextField;
        private var _tellButton:SimpleButton;
        private var _closeButton:SimpleButton;
        private var _closeClick:Signal;
        private var _tellClick:Signal;

        public function PostGiveInterstitial(_arg1:MovieClip){
            super(_arg1);
            this._closeClick = new Signal();
            this._tellClick = new Signal();
            this._messageField = _arg1.messageField;
            this._messageField.text = "";
            this._tellButton = _arg1.tellButton;
            this.setTellLabel("");
            this._tellButton.addEventListener(MouseEvent.CLICK, this.onTellClick, false, 0, true);
            this._closeButton = _arg1.closeButton;
            this._closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
        }
        public function setFriendName(_arg1:String):void{
            var _local2 = (("You gave " + _arg1) + " a free Starseed!");
            this._messageField.text = _local2;
            var _local3:String = ("Tell " + _arg1);
            this.setTellLabel(_local3);
        }
        public function get closeClick():Signal{
            return (this._closeClick);
        }
        public function get tellClick():Signal{
            return (this._tellClick);
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClick, false);
            this._closeButton = null;
            this._closeClick.removeAll();
            this._closeClick = null;
            this._tellButton.removeEventListener(MouseEvent.CLICK, this.onTellClick, false);
            this._tellButton = null;
            this._tellClick.removeAll();
            this._tellClick = null;
        }
        private function setTellLabel(_arg1:String):void{
            var _local3:String;
            var _local4:Sprite;
            var _local5:int;
            var _local6:int;
            var _local7:DisplayObject;
            var _local2:Array = ["up", "over", "down", "hitTest"];
            for each (_local3 in _local2) {
                _local4 = (this._tellButton[(_local3 + "State")] as Sprite);
                _local5 = _local4.numChildren;
                _local6 = 0;
                while (_local6 < _local5) {
                    _local7 = _local4.getChildAt(_local6);
                    if ((_local7 is TextField)){
                        _local7["text"] = _arg1;
                    };
                    _local6++;
                };
            };
        }
        private function onCloseClick(_arg1:MouseEvent):void{
            this._closeClick.dispatch();
        }
        private function onTellClick(_arg1:MouseEvent):void{
            this._tellClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver 
