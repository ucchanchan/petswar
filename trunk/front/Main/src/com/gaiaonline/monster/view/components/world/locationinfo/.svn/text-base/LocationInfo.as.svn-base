//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world.locationinfo {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import alecmce.async.*;
    import flash.text.*;

    public class LocationInfo extends Sprite {

        private const HOME_ID:int = -1;
        private const EASY_MAX:int = 0;
        private const MED_MIN:int = 0;
        private const HARD_MIN:int = 4;

        private var _asset:Asset;
        private var _clicked:Signal;
        private var pending:ParallelAsyncs;
        private var isInited:Boolean;
        private var content:MovieClip;
        private var _background:Asset;
        private var _name:String;

        public function LocationInfo(_arg1:Asset){
            this.setup(_arg1);
            this._clicked = new Signal();
            this.pending = new ParallelAsyncs("LocationInfo-Pending");
        }
        public function set isLocked(_arg1:Boolean):void{
            if (!this.isInited){
                return;
            };
            this.setGoButtonLocked(_arg1);
            this.setRequiresVisible(_arg1);
        }
        public function set background(_arg1:Asset):void{
            this.pending.add(_arg1);
            if (this._background){
                if (((this.isInited) && ((this._background.self.parent == this.content.background)))){
                    this.content.background.removeChild(this._background.self);
                };
                this.pending.remove(this._background);
            };
            this._background = _arg1;
            if (this.isInited){
                if (this._background.isComplete){
                    this.resizeBackground(this._background);
                } else {
                    this._background.complete.addOnce(this.resizeBackground);
                };
                this.content.background.addChild(this._background.self);
            };
        }
        private function resizeBackground(_arg1:Asset):void{
            var _local2:Number = (140 / _arg1.self.height);
            var _local3:Number = (220 / _arg1.self.width);
            _arg1.self.scaleX = (_arg1.self.scaleY = ((_local3 > _local2)) ? _local3 : _local2);
        }
        override public function set name(_arg1:String):void{
            this._name = _arg1;
            if (this.isInited){
                this.content.text.text = _arg1;
            };
        }
        public function get clicked():Signal{
            return (this._clicked);
        }
        private function setup(_arg1:Asset):void{
            this._asset = _arg1;
            addChild(_arg1.self);
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        public function setLocationDifficulty(_arg1:int, _arg2:int):void{
            var _local3:int = (_arg1 - _arg2);
            if (_arg1 == this.HOME_ID){
                this.content.difficulty.gotoAndStop("home");
            } else {
                if (_local3 <= this.EASY_MAX){
                    this.content.difficulty.gotoAndStop("easy");
                } else {
                    if ((((_local3 >= this.MED_MIN)) && ((_local3 < this.HARD_MIN)))){
                        this.content.difficulty.gotoAndStop("medium");
                    } else {
                        if (_local3 >= this.HARD_MIN){
                            this.content.difficulty.gotoAndStop("hard");
                        };
                    };
                };
            };
        }
        private function init(_arg1:Asset):void{
            this.isInited = true;
            this.content = MovieClip(_arg1.content);
            if (this._name){
                this.content.text.text = name;
            };
            if (this._background){
                this.content.background.addChild(this._background.self);
            };
            if (this.content.requires){
                this.content.requires.icon.visible = false;
            };
            this.isLocked = true;
        }
        private function onClick(_arg1:MouseEvent):void{
            this.setGoButtonLocked(true);
            this._clicked.dispatch();
        }
        public function get asset():Asset{
            return (this._asset);
        }
        private function setRequiresVisible(_arg1:Boolean):void{
            if (_arg1){
                this.content.requires.visible = true;
                this.content.plate.height = 265;
            } else {
                this.content.requires.visible = false;
                this.content.plate.height = 210;
            };
        }
        private function setGoButtonLocked(_arg1:Boolean):void{
            var _local2:SimpleButton = this.content.fightButton;
            _local2.enabled = !(_arg1);
            _local2.alpha = (_arg1) ? 0.5 : 1;
            if (_arg1){
                _local2.removeEventListener(MouseEvent.CLICK, this.onClick);
            } else {
                _local2.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            };
        }
        public function set lockedReason(_arg1:String):void{
            var _local2:TextField = TextField(this.content.requires.description);
            _local2.text = _arg1;
        }

    }
}//package com.gaiaonline.monster.view.components.world.locationinfo 
