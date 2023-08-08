//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view {
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import alecmce.services.*;
    import gaia.moga.newuser.view.ui.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.newuser.model.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class NewUserScreenMediator extends Mediator {

		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var view:NewUserScreen;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var ticker:Ticker;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var newuser:NewUserModel;
		[Inject]
        public var tracking:OmnitureService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var music:MusicService;
		[Inject]
        public var async:AsyncService;
        private var _selectionItemsInit:Signal;

        public static const BG_MUSIC:String = "BG_MUSIC";

        override public function onRegister():void{
            this._selectionItemsInit = new Signal();
            this.view.zodiac.add(this.onZodiacChosen);
            this.view.chosen.addOnce(this.onChosen);
            this.setSounds();
            this.selectDefaultZodiac();
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.ZODIAC_PICKER));
        }
        override public function onRemove():void{
            this.view.chosen.removeAll();
        }
        private function selectDefaultZodiac():void{
            if (!((this.app.defaultZodiacId) && (this.app.defaultMonsterId))){
                return;
            };
            this._selectionItemsInit.add(this.selectDefaultMonster);
            this.onZodiacChosen(this.app.defaultZodiacId);
        }
        private function selectDefaultMonster():void{
            this._selectionItemsInit.remove(this.selectDefaultMonster);
            this.view.selectZodiac(this.app.defaultZodiacId);
            this.view.selectItem(this.app.defaultMonsterId);
        }
        private function setSounds():void{
            this.music.loadAndPlay("sounds/choose_zodiac.mp3");
        }
        private function onZodiacChosen(_arg1:uint):void{
            var _local6:ZodiacMonsterModel;
            var _local7:Asset;
            var _local8:FightMonster;
            var _local9:SelectionItem;
            var _local2:Vector.<ZodiacMonsterModel> = this.newuser.getMonsters(_arg1);
            var _local3:int = _local2.length;
            var _local4:Vector.<SelectionItem> = new Vector.<SelectionItem>(_local3, true);
            var _local5:int = _local3;
            while (_local5--) {
                _local6 = _local2[_local5];
                _local7 = this.assets.createWrapper("assets/newUser/newZodiacMonsterWrapper.swf");
                _local8 = this.monsters.monsterFightByID(_local6.id);
                _local9 = new SelectionItem(this.ticker, _local7, _local8, _local6);
                _local4[_local5] = _local9;
            };
            this.initSelectionItems(_local4);
            this.view.setItems(_local4);
        }
        private function initSelectionItems(_arg1:Vector.<SelectionItem>):void{
            var _local3:SelectionItem;
            var _local4:InitSelectionItemAsync;
            var _local2:ParallelAsyncs = new ParallelAsyncs("InitSelectionItemsParallel");
            _local2.complete.add(this.initSelectionItemsComplete);
            for each (_local3 in _arg1) {
                _local4 = new InitSelectionItemAsync(_local3);
                _local2.add(_local4);
            };
            this.async.push(_local2);
        }
        private function initSelectionItemsComplete(_arg1):void{
            this._selectionItemsInit.dispatch();
        }
        private function onChosen(_arg1:ZodiacMonsterModel):void{
            this.newuser.chosen = _arg1;
            dispatch(new ApplicationEvent(ApplicationEvent.SET_STATE, ApplicationState.NEW_USER_INTRO));
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.MONSTER_SELECTED));
        }

    }
}//package gaia.moga.newuser.view 
