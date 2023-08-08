//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets.bundle {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.battle.fight.*;
    import com.gaiaonline.monster.view.components.world.locationinfo.*;

    public class WorldAssetsBundle extends GenericBundle {

        public var top:Asset;
        public var menu:Asset;
        public var team:Asset;
        public var avatar:Asset;
        public var taxi:Asset;
        public var monster:FightMonster;
        public var map:Asset;
        public var surprise:Asset;
        public var overlay:Asset;
        public var info:LocationInfo;
        public var prizeTimer:Asset;

        public function WorldAssetsBundle(_arg1:ApplicationModel, _arg2:WorldModel, _arg3:AssetService, _arg4:WorldAssetsFactory, _arg5:MonsterAssetsFactory, _arg6:HomeRanchModel){
            super("WorldAssetsBundle");
            var _local7:uint = (_arg2.currentZone.id >> 1);
            var _local8:MonsterModel = _arg6.team.getMonsterByIndex(0);
            collection.add((this.top = _arg3.topUI));
            collection.add((this.menu = _arg3.menuUI));
            collection.add((this.team = _arg3.smallTeamUI));
            collection.add((this.avatar = _arg3.currentLocationMarkerUI));
            collection.add((this.map = _arg4.zoneMap(_local7)));
            collection.add((this.surprise = _arg3.createWrapper("assets/world/surprise.swf")));
            collection.add((this.monster = _arg5.monsterFight(_local8)));
            collection.add((this.taxi = _arg3.createWrapper("assets/world/taxi.swf")));
            collection.add((this.prizeTimer = _arg3.prizeTimer));
            if (_arg1.hasSpecial(ApplicationModel.SNOWING)){
                collection.add((this.overlay = _arg3.weather(ApplicationModel.SNOWING)));
            };
            this.info = new LocationInfo(_arg3.locationInfoUI);
            collection.add(this.info.asset);
            this.monster.playAnim("stop");
        }
    }
}//package gaia.moga.assets.bundle 
