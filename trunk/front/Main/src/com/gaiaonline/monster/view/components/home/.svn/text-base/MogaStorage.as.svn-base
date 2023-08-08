//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.list.*;
    import gaia.lib.assets.*;
    import gaia.lib.ui.*;

    public class MogaStorage extends Panel {

        private var _asset:AssetBase;
        private var _inOutTimeline:MovieClip;
        private var _storage:Sprite;
        private var _isOpen:Boolean;// = false
        private var _closeClicked:Signal;
        private var _scrollList:List;
        private var _scrollBar:VScrollBar;
        private var _becameActive:Signal;
        private var _becameInactive:Signal;

        private static const MAX_VISIBLE_CELLS:uint = 10;

        public function MogaStorage(_arg1:AssetBase){
            this._asset = _arg1;
            addChild(this._asset);
            if (this._asset.isComplete){
                this.onAssetLoaded(this._asset);
            } else {
                this._asset.complete.addOnce(this.onAssetLoaded);
            };
            this._storage = MovieClip(this._asset.content).storage;
            this._closeClicked = new Signal();
            this._becameActive = new Signal();
            this._becameInactive = new Signal();
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.removeCellFunctionality((this._storage["cells"] as Sprite));
            this._asset.dispose(_arg1);
            this._closeClicked.removeAll();
            this._becameActive.removeAll();
            this._becameInactive.removeAll();
        }
        public function get closeClicked():Signal{
            return (this._closeClicked);
        }
        public function get becameActive():Signal{
            return (this._becameActive);
        }
        public function get becameInactive():Signal{
            return (this._becameInactive);
        }
        private function open():void{
            if (!this._isOpen){
                this._inOutTimeline.gotoAndPlay(2);
                this._isOpen = true;
            };
        }
        public function close():void{
            if (this._isOpen){
                this._inOutTimeline.play();
                this._isOpen = false;
            };
        }
        public function isMonsterOnStorage(_arg1:HomeMonster):Boolean{
            return (_arg1.hitTestObject(this._storage));
        }
        public function setStoredMogas(_arg1:Vector.<ListDatum>):void{
            var _local2:Array = this.vectorToArray(_arg1);
            _local2.sortOn(["monsterName", "monsterLevel"], [Array.CASEINSENSITIVE, Array.NUMERIC]);
            this._scrollBar.setup(MAX_VISIBLE_CELLS, _arg1.length, true);
            this._scrollList.data = Vector.<ListDatum>(_local2);
            this._scrollBar.isVisible = (_arg1.length > MAX_VISIBLE_CELLS);
        }
        private function vectorToArray(_arg1):Array{
            var _local2:int = _arg1.length;
            var _local3:Array = new Array();
            var _local4:int;
            while (_local4 < _local2) {
                _local3[_local4] = _arg1[_local4];
                _local4++;
            };
            return (_local3);
        }
        public function setRanchMogaCount(_arg1:uint):void{
            this._storage["inRanchField"].text = _arg1.toString();
        }
        public function setTotalMogaCount(_arg1:uint):void{
            this._storage["totalMogasField"].text = _arg1.toString();
        }
        private function onAssetLoaded(_arg1:AssetBase):void{
            this._inOutTimeline = MovieClip(this._asset.content);
            this._inOutTimeline.gotoAndStop(1);
            this._storage = this._inOutTimeline.storage;
            this._storage["closeButton"].addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.addCellFunctionality((this._storage["cells"] as Sprite));
            this._scrollList = new List(this._storage["cells"]);
            this._scrollBar = new VScrollBar(this._storage["scrollThumb"], this._storage["scrollTrack"]);
            this._scrollBar.reposition.add(this.onScrollReposition);
            this._scrollBar.isVisible = false;
            var _local2:SignallingAsset = SignallingAsset(this._inOutTimeline);
            _local2.signal.add(this.onTimelineSignal);
            this.open();
        }
        private function addCellFunctionality(_arg1:Sprite):void{
            var _local3:Sprite;
            var _local2:uint;
            while ((_local3 = _arg1[("cell" + _local2++)])) {
                _local3.useHandCursor = true;
                _local3.buttonMode = true;
                _local3.mouseChildren = false;
                _local3["highlight"].visible = false;
                _local3.addEventListener(MouseEvent.MOUSE_OVER, this.onCellMouseOver, false, 0, true);
                _local3.addEventListener(MouseEvent.MOUSE_OUT, this.onCellMouseOut, false, 0, true);
            };
        }
        private function removeCellFunctionality(_arg1:Sprite):void{
            var _local3:Sprite;
            var _local2:uint;
            while ((_local3 = _arg1[("cell" + _local2++)])) {
                _local3.removeEventListener(MouseEvent.MOUSE_OVER, this.onCellMouseOver, false);
                _local3.removeEventListener(MouseEvent.MOUSE_OUT, this.onCellMouseOut, false);
            };
        }
        private function onCellMouseOver(_arg1:MouseEvent):void{
            var _local2:Sprite = (_arg1.currentTarget as Sprite);
            _local2["highlight"].visible = true;
            _local2.parent.setChildIndex(_local2, (_local2.parent.numChildren - 1));
        }
        private function onCellMouseOut(_arg1:MouseEvent):void{
            var _local2:Sprite = (_arg1.currentTarget as Sprite);
            _local2["highlight"].visible = false;
        }
        private function onScrollReposition(_arg1:Number):void{
            this._scrollList.position = _arg1;
        }
        private function onCloseClick(_arg1:MouseEvent):void{
            this._closeClicked.dispatch();
        }
        private function onTimelineSignal(_arg1:String):void{
            this._inOutTimeline.stop();
            switch (_arg1){
                case "active":
                    this._becameActive.dispatch();
                    break;
                case "inactive":
                    this._becameInactive.dispatch();
                    break;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.home 
