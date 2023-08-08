//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import flash.text.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;

    public class PreGiveInterstitial extends InnerPanel {

        private var WARNING_TEMPLATE:String;// = "You can only give %dailyCount% free Starseeds per day. Are you sure you want to give %userName% a Starseed?"
        private var _yesClick:Signal;
        private var _noClick:Signal;
        private var _warningField:TextField;
        private var _noButton:SimpleButton;
        private var _yesButton:SimpleButton;
        private var _friendName:String;// = ""
        private var _grantLimit:uint;// = 0

        public function PreGiveInterstitial(_arg1:MovieClip){
            super(_arg1);
            this._yesClick = new Signal();
            this._noClick = new Signal();
            this._warningField = _arg1.warningField;
            this._warningField.text = "";
            this._noButton = _arg1.noButton;
            this._noButton.addEventListener(MouseEvent.CLICK, this.onNoClick, false, 0, true);
            this._yesButton = _arg1.yesButton;
            this._yesButton.addEventListener(MouseEvent.CLICK, this.onYesClick, false, 0, true);
        }
        public function setFriendName(_arg1:String):void{
            this._friendName = _arg1;
            this.resetWarning();
        }
        public function setGrantLimit(_arg1:uint):void{
            this._grantLimit = _arg1;
            this.resetWarning();
        }
        private function resetWarning():void{
            var _local1:String = this.WARNING_TEMPLATE.replace("%userName%", this._friendName);
            _local1 = _local1.replace("%dailyCount%", this._grantLimit.toString(10));
            this._warningField.text = _local1;
        }
        public function get yesClick():Signal{
            return (this._yesClick);
        }
        public function get noClick():Signal{
            return (this._noClick);
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._yesButton.removeEventListener(MouseEvent.CLICK, this.onYesClick, false);
            this._yesButton = null;
            this._yesClick.removeAll();
            this._yesClick = null;
            this._noButton.removeEventListener(MouseEvent.CLICK, this.onNoClick, false);
            this._noButton = null;
            this._noClick.removeAll();
            this._noClick = null;
        }
        private function onYesClick(_arg1:MouseEvent):void{
            this._yesClick.dispatch();
        }
        private function onNoClick(_arg1:MouseEvent):void{
            this._noClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver 
