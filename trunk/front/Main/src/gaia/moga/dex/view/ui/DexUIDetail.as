//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import gaia.moga.assets.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import alecmce.services.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.inventory.view.ui.*;
    import com.gaiaonline.monster.*;

    public class DexUIDetail extends Sprite {

        private var ui:Asset;
        private var inventory:InventoryUI;
        private var language:DexLanguageBundle;
        private var ticker:Ticker;
        private var zodiac:ZodiacFactory;
        private var moga:DexMogaInstance;
        private var _closed:Signal;
        private var _add:Signal;
        private var _remove:Signal;
        private var _inventory:Signal;
        private var _shop:Signal;
        private var playhead:MovieClipPlayhead;
        private var ct:ColorTransform;
        private var outline:MovieClip;
        private var closeButton:MovieClipButton;
        private var addToTeamButton:DexUIAddToTeamButton;
        private var removeFromTeamButton:MovieClipButton;
        private var itemInventoryButton:MovieClipButton;
        private var detailsButton:MovieClipButton;
        private var skyShop:MovieClipButton;
        private var stats:DexUIDetailStats;
        private var others:DexUIDetailOthers;
        private var skills:DexUIDetailSkills;
        private var effectiveness:DexUIDetailEffectiveness;
        private var _isVisible:Boolean;
        private var _isLocked:Boolean;

        public function DexUIDetail(_arg1:Asset, _arg2:InventoryUI, _arg3:DexLanguageBundle, _arg4:Ticker, _arg5:ZodiacFactory){
            this.ui = _arg1;
            this.inventory = _arg2;
            this.language = _arg3;
            this.ticker = _arg4;
            this.zodiac = _arg5;
            this._closed = new Signal();
            this._add = new Signal(DexMogaInstance, DexUIAddToTeamButton);
            this._remove = new Signal(DexMogaInstance);
            this._inventory = new Signal();
            this._shop = new Signal();
            this.setup((_arg1.content as MovieClip));
            _arg1.self.visible = false;
            addChild(_arg1.self);
        }
        private function setup(_arg1:MovieClip):void{
            this.ct = new ColorTransform();
            this.playhead = new MovieClipPlayhead(_arg1, this.ticker);
            _arg1 = _arg1.detail;
            this.outline = _arg1.outline;
            this.closeButton = new MovieClipButton(_arg1.close);
            this.addToTeamButton = new DexUIAddToTeamButton(_arg1.addToTeam);
            this.removeFromTeamButton = new MovieClipButton(_arg1.removeFromTeam);
            this.inventory.useItem.add(this.onUseItem);
            _arg1.inventory.addChild(this.inventory);
            this.itemInventoryButton = new MovieClipButton(_arg1.itemInventory);
            this.detailsButton = new MovieClipButton(_arg1.detailsBtn);
            this.detailsButton.clicked.add(this.inventoryToggle);
            this.itemInventoryButton.clicked.add(this.inventoryToggle);
            this.skyShop = new MovieClipButton(_arg1.skyShop);
            this.stats = new DexUIDetailStats(_arg1.stats, this.language, this.zodiac);
            this.others = new DexUIDetailOthers(_arg1.otherInstances);
            this.skills = new DexUIDetailSkills(_arg1.skills);
            this.effectiveness = new DexUIDetailEffectiveness(_arg1.effectiveness, this.zodiac);
        }
        private function onUseItem(_arg1:InventoryItem, _arg2:MonsterModel=null):void{
            this.inventory.isVisible = false;
        }
        private function inventoryToggle(_arg1:MovieClipButton):void{
            if (this.inventory.isVisible){
                this.inventory.isVisible = false;
            } else {
                this.inventory.context = "moga";
                this.inventory.moga = this.moga.model;
                this.inventory.isVisible = true;
            };
            this.detailsButton.isVisible = this.inventory.isVisible;
            this.itemInventoryButton.isVisible = !(this.inventory.isVisible);
        }
        public function show(_arg1:DexMogaInstance):void{
            if (this.moga){
                this.cleanup(this.moga);
            };
            this.inventory.isVisible = false;
            _arg1.changed.add(this.onMogaChanged);
            _arg1.model.recharged.add(this.onMogaRecharged);
            this.moga = _arg1;
            this.updateInstanceSpecificUI();
            this._isVisible = true;
            Color.setTransform(this.ct, Color.fromRarity(_arg1.generic.rarity));
            this.outline.transform.colorTransform = this.ct;
            this.ui.self.visible = true;
            this.closeButton.clicked.addOnce(this.onClose);
            this.addToTeamButton.clicked.add(this.onAddToTeam);
            this.removeFromTeamButton.clicked.add(this.onRemoveFromTeam);
            this.skyShop.clicked.add(this.onSkyShop);
            this.others.selected.add(this.onOtherSelected);
            this.updateData(true);
            this.playhead.at.removeAll();
            this.playhead.playTo("open");
        }
        private function cleanup(_arg1:DexMogaInstance):void{
            _arg1.changed.remove(this.onMogaChanged);
            _arg1.model.recharged.remove(this.onMogaRecharged);
        }
        private function onMogaRecharged(_arg1:MonsterModel):void{
            this.updateData(false);
        }
        private function updateInstanceSpecificUI():void{
            this.addToTeamButton.isVisible = !(this.moga.isOnTeam);
            this.removeFromTeamButton.isVisible = this.moga.isOnTeam;
            this.addToTeamButton.isEnabled = !(this._isLocked);
            this.removeFromTeamButton.isEnabled = !(this._isLocked);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            this.addToTeamButton.isEnabled = !(_arg1);
        }
        private function onMogaChanged(_arg1:DexMogaInstance):void{
            this.addToTeamButton.isVisible = !(_arg1.isOnTeam);
            this.updateInstanceSpecificUI();
        }
        public function close():void{
            if (this.moga){
                this.moga.changed.remove(this.onMogaChanged);
            };
            this.itemInventoryButton.isVisible = true;
            this.detailsButton.isVisible = false;
            this._isVisible = false;
            this.addToTeamButton.showBubble = false;
            this.onClose(null);
        }
        private function updateData(_arg1:Boolean):void{
            this.stats.show(this.moga);
            this.skills.show(this.moga);
            if (_arg1){
                this.others.show(this.moga);
                this.effectiveness.show(this.moga.generic);
            };
        }
        private function onOtherSelected(_arg1:DexMogaInstance):void{
            this.cleanup(this.moga);
            this.moga = _arg1;
            this.updateInstanceSpecificUI();
            this.updateData(false);
        }
        private function onClose(_arg1:MovieClipButton):void{
            this.cleanup(this.moga);
            this.addToTeamButton.showBubble = false;
            this.addToTeamButton.clicked.removeAll();
            this.skyShop.clicked.removeAll();
            this.others.selected.removeAll();
            this.playhead.at.addOnce(this.onClosed);
            this.playhead.playTo("closed");
        }
        private function onClosed(_arg1:MovieClipPlayhead, _arg2:String):void{
            this._isVisible = false;
            this.ui.self.visible = false;
            this.itemInventoryButton.isVisible = true;
            this.detailsButton.isVisible = false;
            this.stats.cleanUp(this.moga);
            this.others.cleanUp();
            this.skills.cleanUp();
            this.effectiveness.cleanUp();
            this._closed.dispatch();
        }
        private function onAddToTeam(_arg1:DexUIAddToTeamButton):void{
            this._add.dispatch(this.moga, _arg1);
        }
        private function onRemoveFromTeam(_arg1:MovieClipButton):void{
            this._remove.dispatch(this.moga);
        }
        private function onSkyShop(_arg1:MovieClipButton):void{
            this._shop.dispatch();
        }
        public function get closed():ISignal{
            return (this._closed);
        }
        public function get add():ISignal{
            return (this._add);
        }
        public function get remove():ISignal{
            return (this._remove);
        }
        public function get shop():ISignal{
            return (this._shop);
        }
        public function get isVisible():Boolean{
            return (this._isVisible);
        }

    }
}//package gaia.moga.dex.view.ui 
