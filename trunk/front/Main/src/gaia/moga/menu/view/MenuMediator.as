//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.view {
    import flash.events.*;
    import org.robotlegs.core.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.menu.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.collections.event.*;
    import com.gaiaonline.monster.model.quests.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.menu.view.ui.*;

    public class MenuMediator extends Mediator {

		[Inject]
        public var view:Menu;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var sounds:SoundService;
		[Inject]
        public var questModel:QuestModel;
        private var arrowOn:String;
        private var settings:IMediator;

        override public function onRegister():void{
            this.settings = mediatorMap.createMediator(this.view.settings);
            addContextListener(MenuEvent.ENABLE, this.enableMenu, MenuEvent);
            addContextListener(MenuEvent.DISABLE, this.disableMenu, MenuEvent);
            addContextListener(MenuEvent.SHOW_ARROW, this.showArrow, MenuEvent);
            addContextListener(MenuEvent.HIDE_ARROW, this.hideArrow, MenuEvent);
            addContextListener(PanelsEvent.ADD_OVERLAY, this.disableMenu, PanelsEvent);
            addContextListener(PanelsEvent.REMOVE_OVERLAY, this.enableMenu, PanelsEvent);
            addContextListener(MenuEvent.QUEST, this.openQuests, MenuEvent);
            addContextListener(MenuEvent.DEX, this.gotoDex, MenuEvent);
            addContextListener(MenuEvent.COLLECTIONS, this.openCollections, MenuEvent);
            this.view.clicked.add(this.onMenuClicked);
            this.setTips();
            this.questModel.questListUpdated.add(this.onQuestsUpdated);
            this.view.setQuestTotal(this.questModel.questCount);
        }
        override public function onRemove():void{
            mediatorMap.removeMediator(this.settings);
            this.view.clicked.removeAll();
            this.view.dispose();
        }
        private function setTips():void{
            this.view.setTip(Menu.TRAVEL, this.text.getTip("MENU_TRAVEL_TITLE"), this.text.getTip("MENU_TRAVEL"));
            this.view.setTip(Menu.DEX, this.text.getTip("MENU_DEX_TITLE"), this.text.getTip("MENU_DEX"));
            this.view.setTip(Menu.QUEST, this.text.getTip("MENU_QUEST_TITLE"), this.text.getTip("MENU_QUEST"));
            this.view.setTip(Menu.COLLECTIONS, this.text.getTip("MENU_COLLECTIONS_TITLE"), this.text.getTip("MENU_COLLECTIONS"));
        }
        private function onQuestsUpdated():void{
            this.view.setQuestTotal(this.questModel.questCount);
        }
        private function showArrow(_arg1:MenuEvent):void{
            this.arrowOn = String(_arg1.data);
            this.view.showArrow(this.arrowOn);
        }
        private function hideArrow(_arg1:MenuEvent):void{
            this.view.hideArrow(String(_arg1.data));
        }
        private function onMenuClicked(_arg1:String):void{
            if (this.arrowOn == _arg1){
                this.view.hideArrow(this.arrowOn);
            };
            dispatch(new MenuEvent(_arg1));
        }
        private function enableMenu(_arg1:Event):void{
            this.view.enable();
        }
        private function disableMenu(_arg1:Event):void{
            this.view.disable();
        }
        private function gotoDex(_arg1:MenuEvent):void{
            dispatch(new DexEvent(DexEvent.OPEN_DEX));
        }
        private function openQuests(_arg1:MenuEvent):void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_QUEST));
        }
        private function openCollections(_arg1:MenuEvent):void{
            dispatch(new MogaCollectionEvent(MogaCollectionEvent.SHOW_COLLECTION_MANAGEMENT));
        }

    }
}//package gaia.moga.menu.view 
