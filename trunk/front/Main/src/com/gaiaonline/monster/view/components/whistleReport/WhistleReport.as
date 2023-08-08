//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleReport {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.moga.assets.bundle.*;
    import alecmce.list.*;
    import gaia.lib.ui.*;

    public class WhistleReport extends Panel {

        private var content:MovieClip;
        private var yPos:int;// = 0
        private var _closeWindow:Signal;
        private var _scrollList:List;
        private var _scrollBar:VScrollBar;
        private var _ready:Signal;
        private var _isReady:Boolean;// = false

        private static const MAX_ITEMS_VISIBLE:uint = 3;

        public function WhistleReport(_arg1:Asset){
            this._closeWindow = new Signal();
            this._ready = new Signal();
            this.content = MovieClip(_arg1.content);
            if (_arg1.isComplete){
                this.setupAsset(_arg1);
            } else {
                _arg1.complete.addOnce(this.setupAsset);
            };
            addChild(this.content);
        }
        private function onClose(_arg1:MouseEvent):void{
            this._closeWindow.dispatch();
        }
        public function addItem(_arg1:WhistleReportItemBundle, _arg2:WhistleReportItemDataVO, _arg3:String):WhistleReportItem{
            var _local5:Vector.<ListDatum>;
            var _local4:WhistleReportItem = new WhistleReportItem(_arg1, _arg2, _arg3);
            if (this._scrollList.data == null){
                this._scrollList.data = new Vector.<ListDatum>();
            };
            _local5 = this._scrollList.data.concat();
            _local5.push(_local4);
            this._scrollList.data = _local5;
            this.updateItemCount(_local5.length);
            return (_local4);
        }
        public function removeItemView(_arg1:WhistleReportItem):int{
            var _local2:Vector.<ListDatum> = this._scrollList.data.concat();
            var _local3:int = _local2.indexOf(_arg1);
            if (_local3 > -1){
                _local2.splice(_local3, 1);
                this._scrollList.data = _local2;
            };
            var _local4:uint = this._scrollList.data.length;
            this.updateItemCount(_local4);
            return (_local4);
        }
        public function enableCloseButton():void{
            if (!this.content.main.closeBtn.visible){
                this.content.main.closeBtn.visible = true;
            };
        }
        private function setupAsset(_arg1:Asset):void{
            this.setupScrollBar();
            this.content.main.closeBtn.visible = false;
            this.content.main.closeBtn.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this._isReady = true;
            this._ready.dispatch();
        }
        private function setupScrollBar():void{
            this._scrollList = new List(this.content.main.itemContainer);
            this._scrollBar = new VScrollBar(this.content.main.scrollThumb, this.content.main.scrollTrack);
            this._scrollBar.reposition.add(this.onScrollReposition);
        }
        private function onScrollReposition(_arg1:Number):void{
            this._scrollList.position = _arg1;
        }
        private function updateItemCount(_arg1:uint):void{
            this._scrollBar.setup(MAX_ITEMS_VISIBLE, _arg1);
            this._scrollBar.isVisible = (_arg1 > MAX_ITEMS_VISIBLE);
        }
        public function get closeWindow():Signal{
            return (this._closeWindow);
        }
        public function get ready():Signal{
            return (this._ready);
        }
        public function get isReady():Boolean{
            return (this._isReady);
        }

    }
}//package com.gaiaonline.monster.view.components.whistleReport 
