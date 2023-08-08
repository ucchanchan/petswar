//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.smallteam.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import gaia.moga.monster.model.actions.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.gotoshop.*;

    public class SmallTeamMediator extends Mediator {

		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var view:SmallTeam;
		[Inject]
        public var battle:BattleModel;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var fb:FBService;
        private var team:Vector.<MonsterModel>;
        private var zodiacs:Vector.<SmallTeamZodiacVO>;

        override public function onRegister():void{
            this.view.coffee.add(this.onCoffee);
            this.view.info.add(this.onInfo);
            this.view.bannerAdClicked.add(this.onBannerClicked);
            eventDispatcher.addEventListener(TeamEvent.SET_TEAM, this.onSetTeam);
            eventDispatcher.addEventListener(TeamEvent.UPDATE_TEAM, this.onUpdateTeam);
            eventDispatcher.addEventListener(TeamEvent.UPDATE_MONSTER, this.onUpdateMonster);
            eventDispatcher.addEventListener(TeamEvent.ENABLE_SMALLTEAM, this.onEnableSmallTeam);
            eventDispatcher.addEventListener(TeamEvent.DISABLE_SMALLTEAM, this.onDisableSmallTeam);
            eventDispatcher.addEventListener(TeamEvent.DESELECT_MONSTER, this.onDeselectMonster);
            this.team = this.ranch.team.mogas;
            this.zodiacs = this.generateZodiacs(this.team);
            this.setTeam(this.team);
            this.battle.estimatesUpdated.add(this.onBattleEstimatesUpdated);
            if (((this.battle.isBattleInited) && (this.battle.attackEstimates))){
                this.onBattleEstimatesUpdated();
            };
            if (this.application.state == ApplicationState.WORLD){
                this.view.enableBannerAd();
            };
            if (!this.application.hasSpecial(ApplicationModel.BUTT_FIGHT)){
                this.view.disableBannerAd();
            };
        }
        override public function onRemove():void{
            this.view.coffee.remove(this.onCoffee);
            this.view.selected.remove(this.onInfo);
            this.battle.estimatesUpdated.remove(this.onBattleEstimatesUpdated);
            eventDispatcher.removeEventListener(TeamEvent.SET_TEAM, this.onSetTeam);
            eventDispatcher.removeEventListener(TeamEvent.UPDATE_TEAM, this.onUpdateTeam);
            eventDispatcher.removeEventListener(TeamEvent.UPDATE_MONSTER, this.onUpdateMonster);
            eventDispatcher.removeEventListener(TeamEvent.ENABLE_SMALLTEAM, this.onEnableSmallTeam);
            eventDispatcher.removeEventListener(TeamEvent.DISABLE_SMALLTEAM, this.onDisableSmallTeam);
            eventDispatcher.removeEventListener(TeamEvent.DESELECT_MONSTER, this.onDeselectMonster);
            this.view.selected.removeAll();
        }
        private function generateZodiacs(_arg1:Vector.<MonsterModel>):Vector.<SmallTeamZodiacVO>{
            var _local5:MonsterModel;
            var _local6:SmallTeamZodiacVO;
            var _local2:uint = _arg1.length;
            var _local3:Vector.<SmallTeamZodiacVO> = new Vector.<SmallTeamZodiacVO>(_local2, true);
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = _arg1[_local4];
                if (!_local5){
                } else {
                    _local6 = new SmallTeamZodiacVO();
                    _local6.playerZodiacIcon = this.assets.zodiacIcon(_local5.zodiac);
                    _local3[_local4] = _local6;
                };
                _local4++;
            };
            return (_local3);
        }
        private function onBattleEstimatesUpdated():void{
            var _local3:MonsterModel;
            var _local4:SmallTeamZodiacVO;
            var _local5:AttackEstimatesVO;
            var _local1:uint = this.battle.npcMonster.zodiac;
            var _local2:int = this.zodiacs.length;
            while (_local2--) {
                _local3 = this.team[_local2];
                if (!_local3){
                } else {
                    _local4 = this.zodiacs[_local2];
                    _local5 = this.battle.getEstimates(_local3.id);
                    if (_local4.npcZodiac != _local1){
                        _local4.npcZodiacIcon = this.assets.zodiacIcon(_local1);
                        _local4.npcZodiac = _local1;
                    };
                    _local4.zodiacMod = (_local5.zodiac) ? this.text.getZodiacEffectText(_local5.zodiac.zodiacMod, true, true) : "";
                    this.view.setRPS(_local3, _local4);
                };
            };
        }
        private function setTeam(_arg1:Vector.<MonsterModel>):void{
            var _local5:SmallTeamVO;
            var _local6:MonsterModel;
            var _local7:Action;
            var _local2:uint = _arg1.length;
            var _local3:Vector.<SmallTeamVO> = new Vector.<SmallTeamVO>(_local2, true);
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = new SmallTeamVO();
                _local6 = _arg1[_local4];
                if (!_local6){
                } else {
                    _local5.monster = _local6;
                    _local5.icon = this.monsters.monsterIconByID(_local6.monsterID);
                    _local5.miniZodiac = this.assets.zodiacIcon(_local6.zodiac);
                    _local7 = _local6.actions.buffAttack;
                    if (_local7){
                        _local5.miniBuff = this.assets.buffIcon(_local6.actions.buffAttack.details.mod_props.icon_id);
                    };
                    _local3[_local4] = _local5;
                };
                _local4++;
            };
            this.view.setTeam(_local3);
        }
        private function onSetTeam(_arg1:TeamEvent):void{
            this.setTeam((_arg1.data as Vector.<MonsterModel>));
        }
        private function onUpdateTeam(_arg1:TeamEvent):void{
            this.view.update();
        }
        private function onUpdateMonster(_arg1:TeamEvent):void{
            var _local2:MonsterModel = _arg1.data;
            this.view.updateMonster(_local2);
        }
        private function onEnableSmallTeam(_arg1:TeamEvent):void{
            this.view.isEnabled = true;
            this.view.selected.addOnce(this.onMonsterSelected);
        }
        private function onDisableSmallTeam(_arg1:TeamEvent):void{
            this.view.isEnabled = false;
        }
        private function onDeselectMonster(_arg1:TeamEvent):void{
            this.view.fighting = null;
        }
        private function onMonsterSelected(_arg1:MonsterModel):void{
            this.view.isEnabled = false;
            dispatch(new TeamEvent(TeamEvent.MONSTER_SELECTED, _arg1));
        }
        private function onInfo(_arg1:MonsterModel):void{
            dispatch(new DexEvent(DexEvent.OPEN_DEX, _arg1));
        }
        private function onCoffee(_arg1:MonsterModel):void{
            if (this.inventory.getItem(ItemEnum.COFFEE).quantity > 0){
                dispatch(new TeamEvent(TeamEvent.RECHARGE_MONSTER, _arg1));
            } else {
                dispatch(new GotoShopEvent(GotoShopEvent.OUT_OF_COFFEE));
            };
        }
        private function onBannerClicked():void{
            var _local1 = "Experimental Battle System";
            var _local2 = "Try the world's first butt-based battle system! Developed by NASA for fighting off space monsters. Play now!";
            this.fb.publishSpecialEvent(_local1, _local2);
        }

    }
}//package com.gaiaonline.monster.view 
