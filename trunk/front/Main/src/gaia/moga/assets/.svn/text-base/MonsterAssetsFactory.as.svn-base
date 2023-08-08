//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.model.battle.*;
    import gaia.moga.app.*;
    import alecmce.ui.pool.*;

    public class MonsterAssetsFactory {

		[Inject]
        public var config:AppConfig;
		[Inject]
        public var model:ApplicationModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var battle:BattleModel;
        private var isPooled:Object;
        private var pool:AssetPool;
        private var teamIcons:Object;

        private static const ICON_POOL_MAX:int = 1;
        private static const MOGA_POOL_MAX:int = 5;

        public function MonsterAssetsFactory(){
            this.pool = new AssetPool();
            this.isPooled = {};
            this.teamIcons = {};
        }
        public function monsterFight(_arg1:MonsterModel):FightMonster{
            return (this.monsterFightByID(_arg1.monsterID));
        }
        public function monsterLarge(_arg1:MonsterModel):Asset{
            return (this.monsterLargeByID(_arg1.monsterID));
        }
        public function monsterIcon(_arg1:MonsterModel):Asset{
            return (this.monsterIconByID(_arg1.monsterID));
        }
        public function monsterTeamIcon(_arg1:MonsterModel):Asset{
            return (this.monsterTeamIconByID(_arg1.monsterID));
        }
        public function monsterPortrait(_arg1:MonsterModel):Asset{
            return (this.monsterPortraitByID(_arg1.monsterID));
        }
        public function monsterBundle(_arg1:MonsterModel):MonsterBundle{
            var _local2:MonsterBundle = new MonsterBundle();
            var _local3:uint = _arg1.monsterID;
            _local2.fight = this.monsterFightByID(_local3);
            _local2.fight.useButt = this.battle.isButtBattle;
            _local2.portrait = this.monsterPortraitByID(_local3);
            _local2.large = this.monsterLargeByID(_local3);
            _local2.zodiacBackground = this.assets.zodiacBackground(_arg1);
            _local2.zodiac = this.assets.zodiacIcon(_arg1.zodiac);
            return (_local2);
        }
        public function monsterFightByID(_arg1, _arg2:Boolean=true):FightMonster{
            var _local3:String;
            var _local4:Boolean = this.model.hasSpecial(ApplicationModel.STICKMAN);
            if (_local4){
                _local3 = this.config.parseURL("assets/special/stickman.swf");
            } else {
                _local3 = this.config.parseURL((("assets/monsters/fight/" + _arg1) + ".swf"));
            };
            if (!this.isPooled[_local3]){
                this.pool.register(_local3, MOGA_POOL_MAX);
                this.isPooled[_local3] = true;
            };
            var _local5:Asset = this.pool.require(_local3, _arg2);
            if (!_local5){
                return (null);
            };
            var _local6:FightMonster = new FightMonster(_local5);
            _local6.name = _arg1.toString();
            if (_arg2){
                _local6.init();
            };
            return (_local6);
        }
        public function monsterIconByID(_arg1:uint):Asset{
            var _local2:String = this.config.parseURL((("assets/monsters/icon/" + _arg1) + ".swf"));
            if (!this.isPooled[_local2]){
                this.pool.register(_local2, MOGA_POOL_MAX);
                this.isPooled[_local2] = true;
            };
            var _local3:Asset = this.pool.require(_local2);
            _local3.init();
            return (_local3);
        }
        public function monsterTeamIconByID(_arg1:uint):Asset{
            return ((this.teamIcons[_arg1] = ((this.teamIcons[_arg1]) || (this.assets.createWrapper((("images/monster_thumb/thumb_L_" + _arg1) + ".png"))))));
        }
        public function monsterLargeByID(_arg1:uint):Asset{
            var _local2:String = this.config.parseURL((("assets/monsters/large/" + _arg1) + ".swf"));
            if (!this.isPooled[_local2]){
                this.pool.register(_local2, MOGA_POOL_MAX);
                this.isPooled[_local2] = true;
            };
            var _local3:Asset = this.pool.require(_local2);
            _local3.init();
            return (_local3);
        }
        public function monsterPortraitByID(_arg1:uint):Asset{
            var _local2:String = this.config.parseURL((("assets/monsters/portrait/" + _arg1) + ".swf"));
            if (!this.isPooled[_local2]){
                this.pool.register(_local2, MOGA_POOL_MAX);
                this.isPooled[_local2] = true;
            };
            var _local3:Asset = this.pool.require(_local2);
            _local3.init();
            return (_local3);
        }
        public function getInactiveMonster(_arg1:uint):FightMonster{
            return (this.monsterFightByID(_arg1));
        }
        public function getInactiveIcon(_arg1:uint):Asset{
            var _local2:String = this.config.parseURL((("assets/monsters/icon/" + _arg1) + ".swf"));
            var _local3:Asset = this.pool.require(_local2);
            _local3.init();
            return (_local3);
        }

    }
}//package gaia.moga.assets 
