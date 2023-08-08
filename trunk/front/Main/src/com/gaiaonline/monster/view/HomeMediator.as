//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.display.*;
    import flash.events.*;
    import org.robotlegs.core.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.menu.events.*;
    import gaia.moga.travel.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.home.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.home.ui.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import gaia.lib.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.controller.team.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class HomeMediator extends Mediator {

        private const NAP_OPTION:String = "sleepDisplay";
        private const NAP_EFFECT:String = "nap";

		[Inject]
        public var view:Home;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var homeAssets:HomeAssetsFactory;
		[Inject]
        public var homeRanch:HomeRanchModel;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var settings:SettingsModel;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var commandMap:ICommandMap;
        private var _numTreeWhistles:uint;// = 0
        private var _team:Vector.<MonsterModel>;
        private var _monsterModelMap:Dictionary;
        private var _modelMonsterMap:Dictionary;
        private var _napTimerMap:Dictionary;
        private var _napOptionMap:Dictionary;
        private var ranch:MonsterRanchModel;
        private var _isFriendRanch:Boolean;
        private var soundMap:Object;
        private var _storageIsOpen:Boolean;// = false
        private var _storageIsLocked:Boolean;// = true
        private var _storedMoga:Vector.<MonsterModel>;

        private static const RECHARGE_ANIM:String = "recharge";
        private static const MONSTER_ROLLOVER:String = "MONSTER_ROLLOVER";
        private static const STORAGE_UNLOCK_COUNT:uint = 20;

        override public function onRegister():void{
            this.view.onHomeTreeReady.addOnce(this.onHomeTreeReady);
            this.view.onMogaHouseDrop.add(this.onMogaHouseDrop);
            this._monsterModelMap = new Dictionary(true);
            this._napTimerMap = new Dictionary(true);
            this._modelMonsterMap = new Dictionary(true);
            this._napOptionMap = new Dictionary(true);
            this._storedMoga = new Vector.<MonsterModel>(0);
            this._isFriendRanch = (this.application.state == ApplicationState.FRIEND_RANCH);
            this.ranch = (this._isFriendRanch) ? this.friendRanch : this.homeRanch;
            if (this._isFriendRanch){
                this.view.hideSmallTeam();
            };
            this._numTreeWhistles = this.ranch.numWhistles;
            this.loadMonsters(this.ranch.mogas);
            this.loadDecorations(this.ranch.getAllDecorations());
            this.view.setWhistleTree(this.ranch.treePosition);
            this.view.setStarseedBasket(this.ranch.basketPosition);
            addContextListener(NapEvent.AWAKEN_MONSTER, this.forceMonsterNapEnd, NapEvent);
            addContextListener(NapEvent.RECHARGE_MONSTER, this.rechargeMonster, NapEvent);
            addContextListener(NapEvent.START_NAP, this.setMonsterInNap, NapEvent);
            addContextListener(TeamEvent.RECHARGE_MONSTER, this.removeMonsterCard, TeamEvent);
            addContextListener(TeamEvent.AWAKEN_MONSTER, this.removeMonsterCard, TeamEvent);
            addContextListener(TeamEvent.ADD_TO_RANCH, this.addMonsterToRanch, TeamEvent);
            addContextListener(TeamEvent.SET_TEAM, this.onTeamSet, TeamEvent);
            addContextListener(MenuEvent.TRAVEL, this.gotoTravel, MenuEvent);
            addContextListener(MogaStorageEvent.MONSTER_STORAGE_DROP, this.onMonsterStorageDrop, MogaStorageEvent);
            addContextListener(MogaStorageEvent.STORAGE_CELL_DRAG, this.onStorageCellDrag, MogaStorageEvent);
            addContextListener(MogaStorageEvent.STORE_TEAM_MONSTER, this.onStoreTeamMonster, MogaStorageEvent);
            addContextListener(HomeMonsterEvent.START_DRAG, this.onMonsterDragStarted, HomeMonsterEvent);
            addContextListener(HomeMonsterEvent.END_DRAG, this.onMonsterDragEnded, HomeMonsterEvent);
            addContextListener(HomeMonsterEvent.ROLL_OVER, this.onMonsterRollover, HomeMonsterEvent);
            addContextListener(HomeMonsterEvent.ROLL_OUT, this.onMonsterRollout, HomeMonsterEvent);
            addContextListener(SettingsEvent.QUALITY_CHANGED, this.onSettingsQualityChanged, SettingsEvent);
            this.view.setQuality(this.cookie.getValue("APP_QUALITY"));
            addContextListener(ApplicationEvent.INVOKE_STORE, this.onOpenStore, ApplicationEvent);
            if (!this._isFriendRanch){
                this.setSounds();
            };
            if (!this.settings.enablePrize){
                dispatch(new DailyPrizeEvent(DailyPrizeEvent.SHOW_DAILY_PRIZE));
            };
        }
        override public function onRemove():void{
            var _local1:Object;
            for (_local1 in this._napTimerMap) {
                this._napTimerMap[_local1].dispose();
                delete this._napTimerMap[_local1];
            };
            this._napTimerMap = null;
            this.clearSounds();
            this.view.dispose();
        }
        private function onMonsterDragStarted(_arg1:HomeMonsterEvent):void{
            if (this._storageIsOpen){
                dispatch(new MogaStorageEvent(MogaStorageEvent.ADD_DRAG_MONSTER, _arg1.monster));
            };
            this.view.removeMonsterCard();
        }
        private function onMonsterDragEnded(_arg1:HomeMonsterEvent):void{
            this.view.removeMonsterCard();
            this.view.dropMonster(_arg1.monster);
        }
        private function onMonsterRollover(_arg1:HomeMonsterEvent):void{
            this.playSound(MONSTER_ROLLOVER);
            this.view.elevateMonsterStatus(_arg1.monster);
        }
        private function onMonsterRollout(_arg1:HomeMonsterEvent):void{
            this.view.lowerMonsterStatus(_arg1.monster);
        }
        private function onStorageCellDrag(_arg1:MogaStorageEvent):void{
            var _local2:MonsterModel = (_arg1.data as MonsterModel);
            _local2.inStorage = false;
            this.updateMogaStorageData(_local2);
            dispatch(new MogaStorageEvent(MogaStorageEvent.UPDATE));
            dispatch(new MogaStorageEvent(MogaStorageEvent.SET_MONSTER_STORE_STATE, _local2));
            var _local3:HomeMonster = this.loadMonsterModel(_local2);
            var _local4:DisplayObject = _local3.getNonShadowMonster();
            var _local5:Rectangle = _local4.getBounds(_local3.parent);
            _local3.x = (((_local3.x - _local5.left) + _local3.parent.mouseX) - (_local5.width / 2));
            _local3.y = (((_local3.y - _local5.top) + _local3.parent.mouseY) - (_local5.height / 2));
            _local3.requestDragForce();
        }
        private function onStoreTeamMonster(_arg1:MogaStorageEvent):void{
            var _local2:MonsterModel = (_arg1.data as MonsterModel);
            _local2.onTeam = 0;
            this.placeMogaInStorage(_local2);
        }
        private function onMonsterStorageDrop(_arg1:MogaStorageEvent):void{
            var _local2:HomeMonster = (_arg1.data as HomeMonster);
            _local2.addEventListener(Event.ENTER_FRAME, this.onMonsterStorageDropDelay, false, 0, true);
        }
        private function onMonsterStorageDropDelay(_arg1:Event):void{
            var _local2:MonsterModel = (this._monsterModelMap[_arg1.currentTarget] as MonsterModel);
            this.placeMogaInStorage(_local2);
            _arg1.currentTarget.removeEventListener(Event.ENTER_FRAME, this.onMonsterStorageDropDelay, false);
        }
        private function placeMogaInStorage(_arg1:MonsterModel):void{
            if (_arg1.onTeam > 0){
                this.displayTeamMonsterDialog(_arg1);
                return;
            };
            if (!_arg1.inStorage){
                _arg1.inStorage = true;
                this.updateMogaStorageData(_arg1);
                this.view.removeMonsterFromRanch(_arg1);
                this.removeMogaFromTeam(_arg1, true);
                dispatch(new MogaStorageEvent(MogaStorageEvent.UPDATE));
                dispatch(new MogaStorageEvent(MogaStorageEvent.SET_MONSTER_STORE_STATE, _arg1));
            };
            this.openStorage();
        }
        private function onTeamSet(_arg1:TeamEvent):void{
            var _local3:MonsterModel;
            var _local4:MonsterModel;
            var _local5:FightMonster;
            var _local2:Vector.<MonsterModel> = (_arg1.data as Vector.<MonsterModel>);
            for each (_local3 in _local2) {
                this.loadMonsterModel(_local3);
            };
            for each (_local4 in this._storedMoga) {
                _local5 = this.monsters.monsterFight(_local4);
                this.view.addMonster(_local5, _local4);
                this.view.removeMonsterFromRanch(_local4);
            };
        }
        private function removeMogaFromTeam(_arg1:MonsterModel, _arg2:Boolean=false):void{
            var _local5:Vector.<MonsterModel>;
            var _local6:MonsterModel;
            var _local3:Vector.<MonsterModel> = this.homeRanch.team.mogas;
            var _local4:int = _local3.indexOf(_arg1);
            if (_local4 > -1){
                _local5 = new Vector.<MonsterModel>();
                _local3.splice(_local4, 1, null);
                for each (_local6 in _local3) {
                    if (_local6){
                        _local6.onTeam = _local5.push(_local6);
                    };
                };
                if (_arg2){
                    this.commandMap.unmapEvent(TeamEvent.SET_TEAM, SetTeamCommand);
                };
                dispatch(new TeamEvent(TeamEvent.SET_TEAM, _local5));
                if (_arg2){
                    this.commandMap.mapEvent(TeamEvent.SET_TEAM, SetTeamCommand);
                };
            };
        }
        private function displayTeamMonsterDialog(_arg1:MonsterModel):void{
            var _local2:String = this.textService.getStoreTeamMonsterDialog(_arg1);
            var _local3:DialogVO = new DialogVO(_local2, DialogVO.OK_CANCEL);
            _local3.data = _arg1;
            _local3.ok = StoreTeamMonsterCommand;
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local3));
        }
        private function displayLockedStorageDialog():void{
            var _local1:String = this.textService.getLockedStorageDialog();
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.OK_ONLY);
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
        }
        private function onMogaHouseDrop(_arg1:MonsterModel):void{
            if (!this._storageIsLocked){
                this.placeMogaInStorage(_arg1);
            } else {
                this.view.showMonsterCard();
                this.displayLockedStorageDialog();
            };
        }
        private function openStorage():void{
            if (!this._storageIsOpen){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_MOGA_STORAGE, this.application.state));
                addContextListener(MogaStorageEvent.CLOSE_STORAGE, this.onStorageClosed, MogaStorageEvent);
                this.view.limitWalkArea = true;
                this._storageIsOpen = true;
            };
        }
        private function onStorageClosed(_arg1:MogaStorageEvent):void{
            this._storageIsOpen = false;
            this.view.limitWalkArea = false;
            this.view.addAllMonstersToMain();
            eventMap.unmapListener(eventDispatcher, MogaStorageEvent.CLOSE_STORAGE, this.onStorageClosed, MogaStorageEvent);
        }
        private function onHomeTreeReady(_arg1:Asset):void{
            this.view.onHomeTreeClick.add(this.onHomeTreeClick);
            this.view.onHomeTreeRollout.add(this.onHomeTreeRollout);
            this.view.onHomeTreeRollover.add(this.onHomeTreeRollover);
            var _local2:String = this.textService.getMogaStorageTooltip(this._isFriendRanch, this._storageIsLocked);
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _arg1.content["door"], _local2, true));
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _arg1.content["lock"], _local2, true));
        }
        private function onHomeTreeClick(_arg1:MouseEvent):void{
            if (!this._storageIsLocked){
                this.openStorage();
            } else {
                this.displayLockedStorageDialog();
            };
        }
        private function onHomeTreeRollover(_arg1:MouseEvent):void{
            if (!this._storageIsLocked){
                this.view.highlightHouse(true);
            };
        }
        private function onHomeTreeRollout(_arg1:MouseEvent):void{
            if (!this._storageIsLocked){
                this.view.highlightHouse(false);
            };
        }
        private function onSettingsQualityChanged(_arg1:SettingsEvent):void{
            this.view.setQuality(_arg1.value);
        }
        private function setSounds():void{
            this.music.loadAndPlay("sounds/bgmusic_home.mp3");
            this.soundMap = {};
            this.soundMap[MONSTER_ROLLOVER] = this.sounds.getFX("sounds/home_monster_rollover.mp3");
        }
        private function playSound(_arg1:String):void{
            if (!this.soundMap){
                return;
            };
            var _local2:SoundProxy = this.soundMap[_arg1];
            if (_local2){
                _local2.play();
            };
        }
        private function clearSounds():void{
            var _local1:SoundProxy;
            for each (_local1 in this.soundMap) {
                _local1.dispose();
            };
            this.soundMap = null;
        }
        private function loadDecorations(_arg1:Vector.<DecorationVO>):void{
            var _local3:int;
            var _local4:DecorationVO;
            var _local5:Asset;
            var _local2:uint = _arg1.length;
            while (_local3 < _local2) {
                _local4 = _arg1[_local3];
                _local5 = this.homeAssets.getDecoration(_local4);
                this.view.addDecoration(_local5, _local4);
                _local3++;
            };
        }
        private function loadMonsters(_arg1:Vector.<MonsterModel>):void{
            var _local3:int;
            var _local4:MonsterModel;
            this._storageIsLocked = (_arg1.length < STORAGE_UNLOCK_COUNT);
            this.view.showStorageLock = this._storageIsLocked;
            this._team = _arg1;
            var _local2:uint = this._team.length;
            this._storedMoga = new Vector.<MonsterModel>(0);
            while (_local3 < _local2) {
                _local4 = this._team[_local3];
                this.loadMonsterModel(_local4);
                _local3++;
            };
        }
        private function loadMonsterModel(_arg1:MonsterModel):HomeMonster{
            var _local2:FightMonster = this.monsters.monsterFight(_arg1);
            var _local3:HomeMonster = this.view.addMonster(_local2, _arg1);
            if (_arg1.napEndTime){
                this.setupNapEffect(_arg1);
            };
            this.addToMonsterTables(_arg1, _local2, _local3);
            if (_arg1.wantsNap){
                this.setupNapOption(_arg1, _local3);
            };
            this.updateMogaStorageData(_arg1);
            return (_local3);
        }
        private function updateMogaStorageData(_arg1:MonsterModel):void{
            var _local2:int = this._storedMoga.indexOf(_arg1);
            if (_arg1.inStorage){
                this.view.removeMonsterFromRanch(_arg1);
                if (_local2 == -1){
                    this._storedMoga.push(_arg1);
                };
            } else {
                if (_local2 > -1){
                    this._storedMoga.splice(_local2, 1);
                };
            };
            this.view.mogaStorageCount = this._storedMoga.length;
        }
        private function addToMonsterTables(_arg1:MonsterModel, _arg2:FightMonster, _arg3:HomeMonster):void{
            if (_arg2 != null){
                this._modelMonsterMap[_arg1] = _arg2;
                this._monsterModelMap[_arg2] = _arg1;
            };
            if (_arg3 != null){
                this._monsterModelMap[_arg3] = _arg1;
            };
        }
        private function setupNapEffect(_arg1:MonsterModel):void{
            var _local2:Asset = this.assets.effectAsset(this.NAP_EFFECT);
            var _local3:int = (_arg1.napEndTime - this.timer.currentTime);
            var _local4:NapTimer = new NapTimer(_local3, _arg1);
            _local4.napOver.add(this.onNapOver);
            this._napTimerMap[_arg1] = _local4;
            this.view.setInNap(_arg1, _local2, this.timer.currentTime);
        }
        private function setupNapOption(_arg1:MonsterModel, _arg2:HomeMonster):void{
            var _local3:NapOption = new NapOption(this.assets.uiPath(this.NAP_OPTION));
            if (((!(this._isFriendRanch)) && (!((_arg2 == null))))){
                _arg2.showNapOption(_local3);
            };
            this._napOptionMap[_local3] = _arg1;
        }
        private function addMonsterToRanch(_arg1:TeamEvent):void{
            var _local2:MonsterModel = _arg1.data;
            this.loadMonsterModel(_local2);
        }
        private function setMonsterInNap(_arg1:NapEvent):void{
            var _local2:Asset = this.assets.effectAsset(this.NAP_EFFECT);
            var _local3:NapTimer = new NapTimer(_arg1.targetModel.napTime, _arg1.targetModel);
            _local3.napOver.add(this.onNapOver);
            this._napTimerMap[_arg1.targetModel] = _local3;
            this.view.setInNap(_arg1.targetModel, _local2, this.timer.currentTime);
            this.removeMonsterCard();
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.START_NAP));
        }
        private function onNapOver(_arg1:MonsterModel, _arg2:NapTimer):void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.END_NAP));
            if (((_arg2) && ((_arg2.timeLeft == 0)))){
                _arg1.recharge();
                dispatch(new TeamEvent(TeamEvent.UPDATE_TEAM));
            };
            _arg1.awaken();
            if (!_arg1.inStorage){
                this.view.awakenMonster(_arg1);
            };
            if (this._napTimerMap[_arg1]){
                this._napTimerMap[_arg1].dispose();
            };
            delete this._napTimerMap[_arg1];
        }
        public function forceMonsterNapEnd(_arg1:NapEvent):void{
            if (this._napTimerMap[_arg1.targetModel]){
                this._napTimerMap[_arg1.targetModel].dispose();
            };
            delete this._napTimerMap[_arg1.targetModel];
            this.onNapOver(_arg1.targetModel, this._napTimerMap[_arg1.targetModel]);
        }
        private function rechargeMonster(_arg1:NapEvent):void{
            var _local2:Boolean;
            if (((this._napTimerMap) && (this._napTimerMap[_arg1.targetModel]))){
                this._napTimerMap[_arg1.targetModel].dispose();
                delete this._napTimerMap[_arg1.targetModel];
                _local2 = true;
            };
            var _local3:Asset = this.assets.effectAsset(RECHARGE_ANIM);
            var _local4:Asset = this.monsters.monsterFight(_arg1.targetModel);
            this.view.playRechargeAnim(_local3, _arg1.targetModel.id, _local2, _local4);
        }
        private function removeMonsterCard(_arg1:TeamEvent=null):void{
            this.view.removeMonsterCard();
        }
        private function onOpenStore(_arg1:ApplicationEvent):void{
            this.removeMonsterCard();
        }
        private function gotoTravel(_arg1:MenuEvent):void{
            dispatch(new ApplicationEvent(TravelEvent.TRIGGER));
        }

    }
}//package com.gaiaonline.monster.view 
