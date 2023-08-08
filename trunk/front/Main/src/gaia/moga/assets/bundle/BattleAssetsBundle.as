//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.assets.bundle {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.view.components.battle.background.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;

    public class BattleAssetsBundle extends GenericBundle {

        public var top:Asset;
        public var ui:Asset;
        public var friendTab:Asset;
        public var team:Asset;
        public var background:Background;
        public var npc:Asset;
        public var captureDialog:Asset;
        public var goButton:Asset;
        public var playerTurnButton:Asset;
        public var enemyTurnButton:Asset;
        public var captureButton:Asset;
        public var blankButton:Asset;
        public var menu:Asset;
        public var overlay:Asset;
        public var prizeTimer:Asset;
        public var choicePromptText:String;

        public function BattleAssetsBundle(_arg1:ApplicationModel, _arg2:AssetService, _arg3:TextService, _arg4:WorldModel){
            super("BattleAssetsBundle");
            var _local5:Location = _arg4.currentLocation;
            collection.add((this.top = _arg2.topUI));
            collection.add((this.ui = _arg2.battleUI));
            collection.add((this.friendTab = _arg2.friendTabAsset));
            collection.add((this.team = _arg2.smallTeamUI));
            collection.add((this.npc = _arg2.npcTeamUI));
            collection.add((this.captureDialog = _arg2.createWrapper("assets/ui/captureDialog.swf")));
            collection.add((this.goButton = _arg2.createWrapper("assets/ui/battle/circleicons/goButton.swf")));
            collection.add((this.playerTurnButton = _arg2.createWrapper("assets/ui/battle/circleicons/playerTurn.swf")));
            collection.add((this.enemyTurnButton = _arg2.createWrapper("assets/ui/battle/circleicons/enemyTurn.swf")));
            collection.add((this.captureButton = _arg2.createWrapper("assets/ui/battle/circleicons/capture.swf")));
            collection.add((this.blankButton = _arg2.createWrapper("assets/ui/battle/circleicons/blank.swf")));
            collection.add((this.menu = _arg2.menuUI));
            collection.add((this.prizeTimer = _arg2.prizeTimer));
            if (_arg1.hasSpecial(ApplicationModel.SNOWING)){
                collection.add((this.overlay = _arg2.weather(ApplicationModel.SNOWING)));
            };
            this.choicePromptText = _arg3.getText("CHOOSE_YOUR_MOGA");
            this.background = _arg2.generateBackground(_local5.background);
            collection.add(this.background.bg);
            collection.add(this.background.mg);
            collection.add(this.background.fg);
        }
    }
}//package gaia.moga.assets.bundle 
