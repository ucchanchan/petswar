//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.moga.assets.*;
    import alecmce.services.*;
    import gaia.moga.inventory.view.ui.*;
    import gaia.moga.dex.view.*;

    public class DexUI extends Panel implements Dex {

        private var menuUI:DexUITabList;
        private var teamUI:DexUITeam;
        private var gridUI:DexUIGrid;
        private var bottomLeftUI:DexUIBottomLeft;
        private var tokensUI:DexUITokens;
        private var multiplesUI:DexUIMultiples;
        private var detailUI:DexUIDetail;
        private var inventoryUI:InventoryUI;
        private var unknownUI:DexUIUnknown;
        private var _openShop:Signal;
        private var _data:DexModel;
        private var _instance:DexMogaInstance;
        private var _closed:Signal;
        private var _sound:Signal;
        private var _isLocked:Boolean;
        private var bubbledAddToTeamButton:DexUIAddToTeamButton;

        public function DexUI(_arg1:DexAssetBundle, _arg2:Ticker, _arg3:ZodiacFactory){
            this.menuUI = new DexUITabList(_arg1.menu);
            this.menuUI.close.add(this.onMenuClose);
            this.menuUI.setData(_arg1.tabs, _arg1.tabs[0]);
            addChild(this.menuUI);
            this.teamUI = new DexUITeam(_arg1.team, 3);
            this.teamUI.selected.add(this.onTeamSelected);
            this.teamUI.changed.add(this.onTeamChanged);
            addChild(this.teamUI);
            this.gridUI = new DexUIGrid(_arg1.grid, _arg1.language);
            this.gridUI.selected.addOnce(this.onGridSelection);
            addChild(this.gridUI);
            this.tokensUI = new DexUITokens(_arg1.tokens);
            this.tokensUI.selected.add(this.onTokensSelected);
            addChild(this.tokensUI);
            this.multiplesUI = new DexUIMultiples(_arg1.multiples, _arg1.language);
            this.multiplesUI.addToTeam.add(this.onAddToTeam);
            this.multiplesUI.removeFromTeam.add(this.onRemoveFromTeam);
            addChild(this.multiplesUI);
            this.inventoryUI = new InventoryUI(_arg1.inventory);
            this.detailUI = new DexUIDetail(_arg1.detail, this.inventoryUI, _arg1.language, _arg2, _arg3);
            this.detailUI.add.add(this.onAddToTeam);
            this.detailUI.remove.add(this.onRemoveFromTeam);
            this.detailUI.shop.add(this.onOpenShop);
            addChild(this.detailUI);
            this.bottomLeftUI = new DexUIBottomLeft(_arg1.bottomLeft);
            addChild(this.bottomLeftUI);
            this.unknownUI = new DexUIUnknown(_arg1.unknown, _arg1.language, _arg3);
            addChild(this.unknownUI);
            this._openShop = new Signal();
            this._closed = new Signal();
            this._sound = new Signal();
        }
        public function get data():DexModel{
            return (this._data);
        }
        public function set data(_arg1:DexModel):void{
            this._data = _arg1;
            this.tokensUI.series = this._data.series;
            this.tokensUI.setVisibleTokens(this._data.seriesCount);
            this.gridUI.mogas = this._data.currentSeries.list;
        }
        public function get team():Vector.<DexMogaInstance>{
            return (this.teamUI.team);
        }
        public function set team(_arg1:Vector.<DexMogaInstance>):void{
            this.teamUI.team = _arg1;
        }
        public function set limit(_arg1:uint):void{
            this.teamUI.limit = _arg1;
        }
        public function get limit():uint{
            return (this.teamUI.limit);
        }
        public function get openShop():ISignal{
            return (this._openShop);
        }
        public function get sound():ISignal{
            return (this._sound);
        }
        public function get closed():ISignal{
            return (this._closed);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            this._isLocked = _arg1;
            this.teamUI.isLocked = _arg1;
            this.detailUI.isLocked = _arg1;
            this.multiplesUI.isLocked = _arg1;
            this.bottomLeftUI.isLocked = _arg1;
        }
        private function onTokensSelected(_arg1:uint):void{
            this.gridUI.mogas = this._data.setSeries(_arg1).list;
        }
        private function onMenuClose():void{
            this._closed.dispatch();
        }
        private function onTeamSelected(_arg1:DexMogaInstance):void{
            this.instance = _arg1;
        }
        private function onTeamChanged():void{
            if (this.bubbledAddToTeamButton){
                this.bubbledAddToTeamButton.showBubble = false;
                this.bubbledAddToTeamButton = null;
            };
        }
        private function onGridSelection(_arg1:DexUIItem):void{
            this.gridUI.isEnabled = false;
            var _local2:DexMoga = _arg1.moga;
            var _local3:uint = _local2.count;
            if (_local3 > 1){
                this.showMultiples(_local2, _arg1.x, _arg1.y);
            } else {
                if (_local3 == 1){
                    this.showDetail(_local2.getInstance(0));
                } else {
                    this.showUnknown(_local2, _arg1.x, _arg1.y);
                };
            };
        }
        private function showUnknown(_arg1:DexMoga, _arg2:int, _arg3:int):void{
            var _local4:Number = this.unknownUI.width;
            var _local5:Number = this.unknownUI.height;
            _arg2 = (_arg2 - (_local4 * 0.5));
            _arg3 = (_arg3 - (_local5 * 0.5));
            if (_arg2 < 10){
                _arg2 = 10;
            } else {
                if ((_arg2 + _local4) > 750){
                    _arg2 = (750 - _local4);
                };
            };
            if (_arg3 < 10){
                _arg3 = 10;
            };
            this.unknownUI.x = _arg2;
            this.unknownUI.y = _arg3;
            this.unknownUI.closed.addOnce(this.onDetailClosed);
            this.unknownUI.show(_arg1);
        }
        private function enableGrid():void{
            this.gridUI.isEnabled = true;
            this.gridUI.selected.addOnce(this.onGridSelection);
        }
        private function showMultiples(_arg1:DexMoga, _arg2:int, _arg3:int):void{
            this.multiplesUI.closed.addOnce(this.onMultiplesClosed);
            this.multiplesUI.selected.addOnce(this.onInstanceSelected);
            this.multiplesUI.show(_arg1, _arg2, _arg3);
        }
        private function onInstanceSelected(_arg1:DexMogaInstance):void{
            this.removeMultiplesListeners();
            this.showDetail(_arg1);
        }
        private function onMultiplesClosed():void{
            this.removeMultiplesListeners();
            this.enableGrid();
        }
        private function removeMultiplesListeners():void{
            this.multiplesUI.closed.remove(this.onMultiplesClosed);
            this.multiplesUI.selected.remove(this.onInstanceSelected);
        }
        private function showDetail(_arg1:DexMogaInstance):void{
            this.detailUI.closed.addOnce(this.onDetailClosed);
            this.detailUI.show(_arg1);
        }
        private function onDetailClosed():void{
            this.enableGrid();
        }
        private function onAddToTeam(_arg1:DexMogaInstance, _arg2:DexUIAddToTeamButton):void{
            if (this.team.length == this.teamUI.limit){
                this.bubbledAddToTeamButton = _arg2;
                _arg2.showBubble = true;
            } else {
                this.closeMultiplesAndCleanup();
                this.addInstanceToTeam(_arg1);
            };
        }
        private function onRemoveFromTeam(_arg1:DexMogaInstance):void{
            this.closeMultiplesAndCleanup();
            this.removeInstanceFromTeam(_arg1);
        }
        private function closeMultiplesAndCleanup():void{
            this.multiplesUI.hide();
            if (this.detailUI.isVisible){
                this.detailUI.close();
            } else {
                this.enableGrid();
            };
        }
        private function addInstanceToTeam(_arg1:DexMogaInstance):void{
            _arg1.isOnTeam = true;
            this.team = this.teamUI.team;
            this.team.push(_arg1);
            this.teamUI.team = this.team;
        }
        private function removeInstanceFromTeam(_arg1:DexMogaInstance):void{
            _arg1.isOnTeam = false;
            this.team = this.teamUI.team;
            var _local2:int = this.team.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            if (this.bubbledAddToTeamButton){
                this.bubbledAddToTeamButton.showBubble = false;
                this.bubbledAddToTeamButton = null;
            };
            this.team.splice(_local2, 1);
            this.teamUI.team = this.team;
        }
        private function onOpenShop():void{
            this._openShop.dispatch();
        }
        public function get instance():DexMogaInstance{
            return (this._instance);
        }
        public function set instance(_arg1:DexMogaInstance):void{
            var _local2 = (this._instance == _arg1);
            var _local3:Boolean = this.detailUI.isVisible;
            if (((_local2) && (_local3))){
                return;
            };
            if (_local3){
                this.detailUI.closed.addOnce(this.onInstanceDetailClosed);
                this.detailUI.close();
            };
            this._instance = _arg1;
            if (!_local3){
                this.detailUI.show(this._instance);
            };
        }
        private function onInstanceDetailClosed():void{
            this.detailUI.show(this._instance);
        }

    }
}//package gaia.moga.dex.view.ui 
