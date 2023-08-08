//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;

    public class SmallTeam extends Sprite {

        private var _positions:Vector.<int>;
        private var _slots:Vector.<SmallTeamSlot>;
        private var _count:uint;
        private var mapToSlot:Object;
        public var bannerAdClicked:Signal;
        protected var _ui:Asset;
        private var _selected:Signal;
        private var _info:Signal;
        private var _coffee:Signal;
        private var _fighting:MonsterModel;
        private var _isEnabled:Boolean;
        private var bannerAd:MovieClip;

        private static const SLOTS:uint = 6;
        private static const SLOT:String = "slot";

        public function SmallTeam(_arg1:Asset){
            this._ui = _arg1;
            this._selected = new Signal(MonsterModel);
            this._info = new Signal(MonsterModel);
            this._coffee = new Signal(MonsterModel);
            this.bannerAdClicked = new Signal();
            this._isEnabled = true;
            this.mapToSlot = {};
            this._positions = new Vector.<int>(SLOTS, true);
            this._slots = new Vector.<SmallTeamSlot>(SLOTS, true);
            this._count = 0;
            var _local2:int;
            while (_local2 < SLOTS) {
                this._slots[_local2] = new SmallTeamSlot();
                _local2++;
            };
            this._ui.self.visible = false;
            addChild(this._ui.self);
            if (this._ui.isComplete){
                this.completeInit(this._ui);
            } else {
                this._ui.complete.addOnce(this.completeInit);
            };
        }
        private function completeInit(_arg1:Asset):void{
            var _local4:SmallTeamSlot;
            var _local5:MovieClip;
            var _local2:MovieClip = MovieClip(_arg1.content);
            this.bannerAd = _local2.bannerAd;
            if (this.bannerAd){
                this.bannerAd.visible = false;
            };
            var _local3:int;
            while (_local3 < SLOTS) {
                _local4 = this._slots[_local3];
                _local5 = _local2[(SLOT + _local3)];
                _local4.init(_local5);
                _local4.clicked.add(this.onClicked);
                _local4.info.add(this.onInfo);
                _local4.coffee.add(this.onCoffee);
                this._positions[_local3] = _local5.x;
                _local3++;
            };
        }
        public function enableBannerAd():void{
            if (!this.bannerAd){
                return;
            };
            this.bannerAd.visible = true;
            this.bannerAd.buttonMode = true;
            this.bannerAd.addEventListener(MouseEvent.CLICK, this.onBannerAdClick);
        }
        public function disableBannerAd():void{
            this.bannerAd.visible = false;
        }
        private function onBannerAdClick(_arg1:MouseEvent):void{
            this.bannerAdClicked.dispatch();
        }
        public function setTeam(_arg1:Vector.<SmallTeamVO>=null):void{
            var _local3:SmallTeamSlot;
            var _local4:SmallTeamVO;
            var _local5:String;
            this.mapToSlot = {};
            this._count = (_arg1) ? _arg1.length : 0;
            var _local2:int;
            while (_local2 < SLOTS) {
                _local3 = this._slots[_local2];
                _local4 = ((_local2 < this._count)) ? _arg1[_local2] : null;
                if (_local4){
                    _local3.assign(_local4);
                    _local5 = _local4.monster.id;
                    this.mapToSlot[_local5] = _local3;
                    if (((this._fighting) && ((_local5 == this._fighting.id)))){
                        _local3.select();
                    };
                } else {
                    _local3.clear();
                };
                _local2++;
            };
            this._ui.self.visible = true;
        }
        public function get fighting():MonsterModel{
            return (this._fighting);
        }
        public function set fighting(_arg1:MonsterModel):void{
            var _local2:SmallTeamSlot;
            if (this._fighting == _arg1){
                return;
            };
            if (this._fighting){
                _local2 = this.mapToSlot[this._fighting.id];
                _local2.deselect();
            };
            this._fighting = _arg1;
            if (!_arg1){
                return;
            };
            _local2 = this.mapToSlot[_arg1.id];
            if (_local2){
                _local2.select();
            };
        }
        public function update():void{
            var _local2:SmallTeamSlot;
            var _local1:int;
            while (_local1 < SLOTS) {
                _local2 = this._slots[_local1];
                if (_local2.monster){
                    _local2.update();
                    if ((((_local2.monster == this._fighting)) && (!(_local2.isHealthy)))){
                        this.fighting = null;
                    };
                };
                _local1++;
            };
        }
        public function updateMonster(_arg1:MonsterModel):void{
            var _local2:SmallTeamSlot = this.mapToSlot[_arg1.id];
            if (_local2){
                _local2.update(_arg1);
            };
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            var _local2:int;
            while (_local2 < SLOTS) {
                this._slots[_local2].isEnabled = _arg1;
                _local2++;
            };
        }
        private function onClicked(_arg1:SmallTeamSlot):void{
            if (((!(this._isEnabled)) || (!(_arg1.isHealthy)))){
                return;
            };
            this._selected.dispatch(_arg1.monster);
        }
        private function onCoffee(_arg1:SmallTeamSlot):void{
            if (!this._isEnabled){
                return;
            };
            this._coffee.dispatch(_arg1.monster);
        }
        private function onInfo(_arg1:SmallTeamSlot):void{
            if (!this._isEnabled){
                return;
            };
            this._info.dispatch(_arg1.monster);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get info():ISignal{
            return (this._info);
        }
        public function get coffee():ISignal{
            return (this._coffee);
        }
        public function setRPS(_arg1:MonsterModel, _arg2:SmallTeamZodiacVO):void{
            var _local3:SmallTeamSlot = this.mapToSlot[_arg1.id];
            if (_local3){
                _local3.rps(_arg2);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam 
