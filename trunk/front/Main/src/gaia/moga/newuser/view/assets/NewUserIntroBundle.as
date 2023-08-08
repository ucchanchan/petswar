//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.assets {
    import alecmce.ui.*;
    import gaia.moga.assets.*;
    import gaia.moga.assets.bundle.*;
    import gaia.moga.newuser.model.*;

    public class NewUserIntroBundle extends GenericBundle {

        public var starFalls:Asset;
        public var enterBattle:Asset;
        public var monster:Asset;

        public function NewUserIntroBundle(_arg1:AssetService, _arg2:MonsterAssetsFactory, _arg3:NewUserModel){
            super("NewUserIntroBundle");
            this.starFalls = _arg1.createWrapper("assets/newUser/starFalls.swf");
            this.enterBattle = _arg1.createWrapper("assets/newUser/enterBattle.swf");
            this.monster = _arg2.monsterLargeByID(_arg3.chosen.id);
            collection.add(this.starFalls);
            collection.add(this.enterBattle);
            collection.add(this.monster);
        }
    }
}//package gaia.moga.newuser.view.assets 
