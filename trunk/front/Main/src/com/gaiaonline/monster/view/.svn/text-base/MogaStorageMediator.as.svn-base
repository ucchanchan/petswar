//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import com.gaiaonline.monster.view.components.home.ui.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;
    import org.robotlegs.mvcs.*;

    public class MogaStorageMediator extends Mediator {

		[Inject]
        public var view:MogaStorage;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var homeRanch:HomeRanchModel;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var monsterFactory:MonsterAssetsFactory;
		[Inject]
        public var timer:TimerService;
        private var _ranch:MonsterRanchModel;
        private var _isFriendRanch:Boolean;
        private var _delayCount:uint;// = 0

        override public function onRegister():void{
            this._isFriendRanch = (this.application.state == ApplicationState.FRIEND_RANCH);
            this._ranch = (this._isFriendRanch) ? this.friendRanch : this.homeRanch;
            this.updateMogaList(this._ranch.mogas);
            eventDispatcher.addEventListener(MogaStorageEvent.UPDATE, this.onUpdate, false, 0, true);
            eventDispatcher.addEventListener(MogaStorageEvent.ADD_DRAG_MONSTER, this.onAddDragMonster, false, 0, true);
            eventDispatcher.addEventListener(ApplicationEvent.SET_STATE, this.onApplicationStateChange, false, 0, true);
            this.view.closeClicked.add(this.onCloseClicked);
            this.view.becameInactive.addOnce(this.onViewInactive);
        }
        override public function onRemove():void{
            this.view.dispose();
            this.view.closeClicked.remove(this.onCloseClicked);
            eventDispatcher.removeEventListener(MogaStorageEvent.UPDATE, this.onUpdate, false);
            eventDispatcher.removeEventListener(MogaStorageEvent.ADD_DRAG_MONSTER, this.onAddDragMonster, false);
            eventDispatcher.removeEventListener(ApplicationEvent.SET_STATE, this.onApplicationStateChange, false);
            dispatch(new MogaStorageEvent(MogaStorageEvent.CLOSE_STORAGE));
        }
        private function onApplicationStateChange(_arg1:ApplicationEvent):void{
            this.view.close();
        }
        private function onCloseClicked():void{
            this.view.close();
        }
        private function onViewInactive():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onUpdate(_arg1:MogaStorageEvent):void{
            this.updateMogaList(this._ranch.mogas);
        }
        private function onAddDragMonster(_arg1:MogaStorageEvent):void{
            var _local2:HomeMonster = (_arg1.data as HomeMonster);
            this._delayCount = 0;
            _local2.addEventListener(Event.ENTER_FRAME, this.onAddDragMonsterDelay, false, 0, true);
            if (this.application.state != ApplicationState.FRIEND_RANCH){
                _local2.addEventListener(MouseEvent.MOUSE_UP, this.onMonsterDragMouseUp, false, 0, true);
            };
        }
        private function onAddDragMonsterDelay(_arg1:Event):void{
            var _local2:HomeMonster;
            if (this._delayCount > 1){
                _local2 = (_arg1.currentTarget as HomeMonster);
                this.view.addChild(_local2);
                _local2.removeEventListener(Event.ENTER_FRAME, this.onAddDragMonsterDelay, false);
                this._delayCount = 0;
            } else {
                this._delayCount++;
            };
        }
        private function onMonsterDragMouseUp(_arg1:MouseEvent):void{
            var _local2:HomeMonster = (_arg1.currentTarget as HomeMonster);
            _local2.removeEventListener(MouseEvent.MOUSE_UP, this.onMonsterDragMouseUp, false);
            if (this.view.isMonsterOnStorage(_local2)){
                dispatch(new MogaStorageEvent(MogaStorageEvent.MONSTER_STORAGE_DROP, _local2));
            };
        }
        private function updateMogaList(_arg1:Vector.<MonsterModel>):void{
            var _local5:MogaStorageDatum;
            var _local6:MonsterModel;
            var _local2:Vector.<ListDatum> = new Vector.<ListDatum>();
            var _local3:uint;
            var _local4:uint;
            for each (_local6 in _arg1) {
                _local3++;
                if (_local6.inStorage){
                    _local5 = new MogaStorageDatum(_local6, this.monsterFactory);
                    _local5.timer = this.timer;
                    _local2.push(_local5);
                    _local5.drag.addOnce(this.onCellDrag);
                } else {
                    _local4++;
                };
            };
            this.view.setStoredMogas(_local2);
            this.view.setRanchMogaCount(_local4);
            this.view.setTotalMogaCount(_local3);
        }
        private function onCellDrag(_arg1:MonsterModel):void{
            if (!this._isFriendRanch){
                dispatch(new MogaStorageEvent(MogaStorageEvent.STORAGE_CELL_DRAG, _arg1));
            };
        }

    }
}//package com.gaiaonline.monster.view 
