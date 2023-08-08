//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.autoHarvester.view {
    import alecmce.ui.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;

    public class AutoHarvesterMediator extends Mediator {

        public var view:AutoHarvester;
        public var assets:AssetService;
        public var friends:FriendsModel;
        public var inventory:InventoryModel;

        override public function onRegister():void{
            this.view.clicked.addOnce(this.onClick);
            this.view.animComplete.addOnce(this.onAnimComplete);
            eventDispatcher.addEventListener(HomeEvent.ACTIVATE_AUTO_HARVESTER, this.onAcitvate);
            eventDispatcher.addEventListener(HomeEvent.CLOSE_AUTO_HARVESTER_PROMPT, this.onClosePrompt);
        }
        override public function onRemove():void{
            eventDispatcher.addEventListener(HomeEvent.ACTIVATE_AUTO_HARVESTER, this.onAcitvate);
            this.view.clicked.removeAll();
            this.view.dispose();
        }
        private function onAnimComplete():void{
            var _local1:int = (this.friends.whistleCount + this.inventory.getItem(ItemEnum.WHISTLE).quantity);
            this.inventory.setItem(ItemEnum.WHISTLE, _local1);
            this.view.fadeOut();
            this.friends.whistleCount = 0;
        }
        private function onAcitvate(_arg1:HomeEvent):void{
            this.view.playAnim("ready");
        }
        private function onClosePrompt(_arg1:HomeEvent):void{
            this.view.clicked.addOnce(this.onClick);
        }
        private function onClick():void{
            var _local1:Asset = this.assets.autoHarvesterPrompt();
            var _local2:AutoHarvesterPrompt = new AutoHarvesterPrompt(_local1, this.friends.whistleCount);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local2));
        }

    }
}//package gaia.moga.autoHarvester.view 
