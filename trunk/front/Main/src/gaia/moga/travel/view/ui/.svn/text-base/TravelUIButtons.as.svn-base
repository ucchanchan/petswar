//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.world.*;

    public class TravelUIButtons extends Sprite {

        private var buttons:Object;
        private var content:MovieClip;
        private var _clicked:Signal;
        private var _cancel:Signal;
        private var cancelBtn:SimpleButton;

        public function TravelUIButtons(_arg1:Asset){
            this._clicked = new Signal(Zone);
            this._cancel = new Signal();
            this.content = (_arg1.content as MovieClip);
            this.init(this.content);
            addChild(_arg1.self);
        }
        public function setAvailability(_arg1:Zone):void{
            var _local2:TravelUIButton = this.buttons[_arg1.id];
            if (_local2){
                _local2.zone = _arg1;
                this.updateButton(_local2);
            };
        }
        public function enable():void{
            var _local1:TravelUIButton;
            for each (_local1 in this.buttons) {
                _local1.isEnabled = true;
                this.updateButton(_local1);
            };
        }
        public function dispose(_arg1:Boolean=true):void{
            var _local3:TravelUIButton;
            var _local2:int = this.buttons.length;
            while (_local2--) {
                _local3 = this.buttons[_local2];
                _local3.isEnabled = false;
                this.updateButton(_local3);
            };
            this.content = null;
            this.cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancel);
            removeChildAt(0);
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }
        public function get cancel():ISignal{
            return (this._cancel);
        }
        private function init(_arg1:MovieClip):void{
            this.buttons = {};
            var _local2:TravelUIButton = this.createButton(_arg1.panel.home, 0);
            _local2.isEnabled = true;
            this.createButton(_arg1.panel.zone1, 2);
            this.createButton(_arg1.panel.zone2, 4);
            this.cancelBtn = (_arg1.panel.close as SimpleButton);
            this.cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancel);
        }
        private function onCancel(_arg1:MouseEvent):void{
            this._cancel.dispatch();
        }
        private function createButton(_arg1:MovieClip, _arg2:int, _arg3:Boolean=false):TravelUIButton{
            var _local4:TravelUIButton = new TravelUIButton(_arg1, _arg2);
            this.buttons[_arg2] = _local4;
            _local4.isEnabled = false;
            return (_local4);
        }
        private function onButtonClicked(_arg1:TravelUIButton):void{
            var _local2:Zone = _arg1.zone;
            for each (_arg1 in this.buttons) {
                _arg1.isEnabled = false;
                this.updateButton(_arg1);
            };
            this._clicked.dispatch(_local2);
        }
        private function updateButton(_arg1:TravelUIButton):void{
            if (((_arg1.isEnabled) && (_arg1.isAvailable))){
                _arg1.clicked.addOnce(this.onButtonClicked);
            } else {
                _arg1.clicked.remove(this.onButtonClicked);
            };
        }

    }
}//package gaia.moga.travel.view.ui 
