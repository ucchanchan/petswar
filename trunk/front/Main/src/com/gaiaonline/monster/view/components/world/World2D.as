//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.smallteam.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import flash.geom.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.recurringPrize.*;
    import com.gaiaonline.monster.view.components.world.taxi.*;
    import gaia.moga.menu.view.ui.*;
    import com.gaiaonline.monster.view.components.top.*;

    public class World2D extends Panel {

        private var bundle:WorldAssetsBundle;
        private var _locations:Vector.<Location>;
        private var nodes:Vector.<WorldNode>;
        private var locationToNodeMap:Dictionary;
        private var paths:Vector.<WorldPath>;
        private var pathMap:Object;
        private var _selected:Signal;
        public var infoContainer:Sprite;
        private var overlayContainer:Sprite;
        private var avatar:Asset;
        private var map:MovieClip;
        private var current:Location;
        private var taxi:ITaxi;
        private var isTaxiOnMap:Boolean;
        private var isSetup:Boolean;
        private var quality:int;
        private var home:WorldNode;

        private static const WIDTH:uint = 760;
        private static const SMALL_TEAM_Y:Number = 660;

        public function World2D(_arg1:WorldAssetsBundle){
            this.nodes = new Vector.<WorldNode>();
            this.locationToNodeMap = new Dictionary();
            this.paths = new Vector.<WorldPath>();
            this.pathMap = {};
            this._selected = new Signal(Location, int, int);
            this.bundle = _arg1;
        }
        override public function setup():void{
            var _local1:SmallTeam;
            var _local2:RecurringPrize;
            var _local4:Menu;
            var _local6:Sprite;
            var _local7:int;
            _local1 = new SmallTeam(this.bundle.team);
            _local2 = new RecurringPrize(this.bundle.prizeTimer);
            _local1.x = (WIDTH * 0.5);
            _local1.y = SMALL_TEAM_Y;
            var _local3:Top = new Top(this.bundle.top);
            _local4 = new Menu(this.bundle.menu);
            _local4.setup(Vector.<String>([Menu.TRAVEL, Menu.DEX, Menu.QUEST, Menu.COLLECTIONS]));
            this.map = MovieClip(this.bundle.map.content);
            this.taxi = ITaxi(this.bundle.taxi.content);
            this.taxi.setPosition(360, -20);
            this.avatar = this.bundle.avatar;
            var _local5:MovieClip = MovieClip(this.avatar.content);
            _local5.monster.addChild(this.bundle.monster);
            _local6 = Sprite(this.avatar.self);
            _local6.mouseChildren = false;
            _local6.mouseEnabled = false;
            addChild(this.bundle.map.self);
            addChild(this.bundle.avatar.self);
            addChild(this.bundle.taxi.self);
            addChild((this.overlayContainer = new Sprite()));
            this.overlayContainer.mouseEnabled = false;
            this.overlayContainer.mouseChildren = false;
            addChild(this.bundle.info);
            addChild(_local1);
            addChild(_local3);
            addChild(_local4);
            addChild(_local2);
            if (this._locations){
                this.updateMarkers(this._locations);
            };
            _local7 = this.nodes.length;
            while (_local7--) {
                this.nodes[_local7].play();
            };
            _local7 = this.paths.length;
            while (_local7--) {
                this.paths[_local7].play();
            };
            this.isSetup = true;
        }
        public function set locations(_arg1:Vector.<Location>):void{
            this._locations = _arg1;
            if (this.isSetup){
                this.updateMarkers(this._locations);
            };
        }
        private function updateMarkers(_arg1:Vector.<Location>):void{
            var _local3:Location;
            var _local4:WorldNode;
            var _local2:int = _arg1.length;
            while (_local2--) {
                _local3 = _arg1[_local2];
                _local4 = this.locationToNodeMap[_local3];
                if (_local4){
                    _local4.update();
                } else {
                    this.defineNode(_local3);
                };
            };
        }
        private function defineNode(_arg1:Location):void{
            var _local2:int = _arg1.id;
            var _local3:String = ("node_" + _local2);
            var _local4:MovieClip = this.map[_local3];
            if (!_local4){
                _arg1.isMalformed = true;
                return;
            };
            var _local5:WorldNode = new WorldNode(_local4, _arg1);
            _local5.selected.add(this.onNodeSelected);
            this.nodes.push(_local5);
            this.locationToNodeMap[_arg1] = _local5;
            if (_arg1.isHomeOrTaxiStop){
                this.home = _local5;
            };
            if (_arg1.isCurrent){
                this.current = _arg1;
                this.avatar.self.x = _local5.x;
                this.avatar.self.y = _local5.y;
            };
            this.definePaths(_arg1);
        }
        private function definePaths(_arg1:Location):void{
            var _local5:Location;
            var _local6:int;
            var _local7:String;
            var _local8:MovieClip;
            var _local2:int = _arg1.id;
            var _local3:Vector.<Location> = _arg1.neighbours;
            var _local4:int = _local3.length;
            while (_local4--) {
                _local5 = _local3[_local4];
                _local6 = _local5.id;
                _local7 = "path_";
                if (_local6 < _local2){
                    _local7 = (_local7 + ((_local6 + "_") + _local2));
                } else {
                    _local7 = (_local7 + ((_local2 + "_") + _local6));
                };
                _local8 = this.map[_local7];
                if (_local8){
                    this.definePath(_local8, _arg1, _local5);
                };
            };
        }
        private function definePath(_arg1:MovieClip, _arg2:Location, _arg3:Location):void{
            var _local4:String = _arg1.name;
            if (this.pathMap[_local4]){
                return;
            };
            var _local5:WorldPath = new WorldPath(_arg1, _arg2, _arg3);
            this.paths.push(_local5);
            this.pathMap[_local4] = _local5;
        }
        private function onClick(_arg1:MouseEvent):void{
            var _local2:Number = this.avatar.self.x;
            var _local3:Number = this.avatar.self.y;
            this._selected.dispatch(this.current, _local2, _local3);
        }
        private function onNodeSelected(_arg1:WorldNode):void{
            this._selected.dispatch(_arg1.location, _arg1.x, _arg1.y);
        }
        public function get selected():Signal{
            return (this._selected);
        }
        public function locationPosition(_arg1:Location):Point{
            var _local2:WorldNode = this.locationToNodeMap[_arg1];
            return (new Point(_local2.x, _local2.y));
        }
        public function moveAvatarToLocation(_arg1:Location):Async{
            var _local2:WorldNode = this.locationToNodeMap[_arg1];
            return (new AnimAvatarToNode(this.avatar.self, _local2));
        }
        public function animateTaxiPickup(_arg1:SoundProxy):Async{
            this.isTaxiOnMap = true;
            return (new TaxiPickupAnim(this.taxi, this.avatar, _arg1));
        }
        public function animateTaxiDropOff(_arg1:Location, _arg2:SoundProxy):Async{
            this.isTaxiOnMap = false;
            var _local3:WorldNode = this.locationToNodeMap[_arg1];
            return (new TaxiDropOffAnim(this.taxi, this.avatar, _local3, _arg2));
        }
        public function animateTaxiCancelled(_arg1:SoundProxy):Async{
            this.isTaxiOnMap = false;
            return (new TaxiCancelledAnim(this.taxi, this.avatar, _arg1));
        }
        public function callTaxi(_arg1:SoundProxy):Async{
            var _local3:AsyncBase;
            var _local2:WorldNode = this.locationToNodeMap[this.current.zone.taxiStop];
            if (this.isTaxiOnMap){
                _local3 = new TaxiToHomeAnim(this.taxi, this.avatar, _local2, _arg1);
            } else {
                _local3 = new TaxiRoundtripAnim(this.taxi, this.avatar, _local2, _arg1);
            };
            return (_local3);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (this.bundle){
                this.bundle.dispose(_arg1);
            };
            this.bundle = null;
        }
        public function setQuality(_arg1:int):void{
            this.quality = _arg1;
            if (((!(this.bundle.overlay)) || (!(this.overlayContainer)))){
                return;
            };
            var _local2:DisplayObject = this.bundle.overlay.self;
            if (_arg1 == 4){
                this.overlayContainer.addChild(_local2);
            } else {
                if (_local2.parent == this.overlayContainer){
                    this.overlayContainer.removeChild(_local2);
                };
            };
        }

    }
}//package com.gaiaonline.monster.view.components.world 
