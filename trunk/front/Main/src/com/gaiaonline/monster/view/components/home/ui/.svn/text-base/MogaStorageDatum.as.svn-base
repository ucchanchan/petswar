//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home.ui {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;

    public class MogaStorageDatum implements ListDatum {

        public var timer:TimerService;
        private var _model:MonsterModel;
        private var _cell:MovieClip;
        private var _factory:MonsterAssetsFactory;
        private var _monsterIcon:Asset;
        private var _drag:Signal;
        private var _napTimerMap:Dictionary;

        public function MogaStorageDatum(_arg1:MonsterModel, _arg2:MonsterAssetsFactory){
            this._napTimerMap = new Dictionary(true);
            this._model = _arg1;
            this._factory = _arg2;
            this._drag = new Signal();
        }
        public function apply(_arg1:MovieClip):void{
            this.applyMonsterIcon(_arg1);
            _arg1.nameField.text = this._model.name;
            _arg1.levelField.text = ("Lv " + this._model.level);
        }
        public function clear(_arg1:MovieClip):void{
        }
        public function get drag():Signal{
            return (this._drag);
        }
        public function get monsterLevel():uint{
            return (this._model.level);
        }
        public function get monsterName():String{
            return (this._model.name);
        }
        public function toString():String{
            return (this._model.name);
        }
        private function applyMonsterIcon(_arg1:MovieClip):void{
            var _local2:NapTimer;
            if (_arg1.__monsterIcon != null){
                _arg1.iconContainer.removeChild(_arg1.__monsterIcon);
            };
            if (this._monsterIcon == null){
                this._monsterIcon = this._factory.monsterIcon(this._model);
            };
            if (this._napTimerMap[this._cell]){
                _local2 = (this._napTimerMap[this._cell] as NapTimer);
                _local2.napOver.remove(this.onNapOver);
                delete this._napTimerMap[this._cell];
            };
            this._cell = _arg1;
            this.setDragListener(_arg1);
            _arg1.__monsterIcon = this._monsterIcon;
            this._monsterIcon.self.x = 2.5;
            this._monsterIcon.self.y = 1.5;
            _arg1.iconContainer.addChild(this._monsterIcon.self);
            this._monsterIcon.init();
            _arg1.zzz.visible = this._model.isNapping;
            _arg1.overlay.visible = this._model.isNapping;
            if (this._model.isNapping){
                this.setupNapTimer();
            };
        }
        private function setupNapTimer():void{
            var _local1:int = (this._model.napEndTime - this.timer.currentTime);
            var _local2:NapTimer = new NapTimer(_local1, this._model);
            _local2.napOver.addOnce(this.onNapOver);
            this._napTimerMap[this._cell] = _local2;
        }
        private function onNapOver(_arg1:MonsterModel, _arg2:NapTimer):void{
            _arg1.isNapping = false;
            this._cell.zzz.visible = false;
            this._cell.overlay.visible = false;
            delete this._napTimerMap[this._cell];
        }
        private function setDragListener(_arg1:MovieClip):void{
            if (_arg1.__dragController != null){
                this.removeDragListeners(_arg1, (_arg1.__dragController as MogaStorageDatum));
            };
            _arg1.__dragController = this;
            _arg1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown, false, 0, true);
        }
        private function removeDragListeners(_arg1:MovieClip, _arg2:MogaStorageDatum, _arg3:Boolean=false):void{
            _arg1.removeEventListener(MouseEvent.MOUSE_MOVE, _arg2.onMouseMove, false);
            _arg1.removeEventListener(MouseEvent.MOUSE_UP, _arg2.onMouseUp, false);
            if (!_arg3){
                _arg1.removeEventListener(MouseEvent.MOUSE_DOWN, _arg2.onMouseDown, false);
            };
        }
        private function onMouseDown(_arg1:MouseEvent):void{
            var _local2:MovieClip = (_arg1.currentTarget as MovieClip);
            _local2.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove, false, 0, true);
            _local2.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp, false, 0, true);
        }
        private function onMouseMove(_arg1:MouseEvent):void{
            var _local2:MovieClip = (_arg1.currentTarget as MovieClip);
            this._drag.dispatch(this._model);
            this.removeDragListeners(_local2, this, true);
        }
        private function onMouseUp(_arg1:MouseEvent):void{
            var _local2:MovieClip = (_arg1.currentTarget as MovieClip);
            this.removeDragListeners(_local2, this, true);
        }

    }
}//package com.gaiaonline.monster.view.components.home.ui 
