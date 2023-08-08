//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.world {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.world.*;

    public class WorldNode {

        private var _selected:Signal;
        private var _location:Location;
        private var node:MovieClip;
        private var isNewNode:Boolean;

        public function WorldNode(_arg1:MovieClip, _arg2:Location){
            this._selected = new Signal(WorldNode);
            this._location = _arg2;
            this.node = _arg1;
            this.update();
        }
        public function update():void{
            var _local2:Boolean;
            var _local3:Boolean;
            var _local1:Boolean = this._location.isLocked();
            _local2 = _local1;
            _local3 = ((!(_local1)) && (((((this._location.hasWon) || (this._location.isHomeOrTaxiStop))) || (((this._location.hasVisited) && (this._location.isStory))))));
            var _local4:Boolean = ((!(_local2)) && (!(_local3)));
            this.isNewNode = ((this._location.isNewNode) && (_local4));
            this.node.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.node.useHandCursor = true;
            this.node.buttonMode = true;
            this.node.big.visible = _local3;
            this.node.little.visible = _local4;
            this.node.gray.visible = _local2;
            var _local5:MovieClip = this.node.lights;
            if (!_local5){
                return;
            };
            if (this.isNewNode){
                _local5.stop();
            } else {
                if (_local5.parent == this.node){
                    this.node.removeChild(_local5);
                };
            };
            this._location.isNewNode = false;
        }
        public function play():void{
            if (this.isNewNode){
                this.node.lights.gotoAndPlay(1);
            };
        }
        private function onClick(_arg1:MouseEvent):void{
            this._selected.dispatch(this);
        }
        public function get selected():Signal{
            return (this._selected);
        }
        public function get location():Location{
            return (this._location);
        }
        public function get x():int{
            return (this.node.x);
        }
        public function get y():int{
            return (this.node.y);
        }

    }
}//package com.gaiaonline.monster.view.components.world 
