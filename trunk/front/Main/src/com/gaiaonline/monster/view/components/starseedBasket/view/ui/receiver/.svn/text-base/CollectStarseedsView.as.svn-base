//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import alecmce.list.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;
    import gaia.lib.ui.*;

    public class CollectStarseedsView extends InnerPanel {

        private var _getStarseedClick:Signal;
        private var _collectClick:Signal;
        private var _history:List;
        private var _scrollBar:VScrollBar;

        private static const VIEWABLE_HISTORY_COUNT:uint = 3;

        public function CollectStarseedsView(_arg1:MovieClip){
            super(_arg1);
            this._getStarseedClick = new Signal();
            this._collectClick = new Signal();
            _asset.getStarseedsButton.addEventListener(MouseEvent.CLICK, this.onGetStarseedsClick, false, 0, true);
            _asset.collectButton.addEventListener(MouseEvent.CLICK, this.onCollectClick, false, 0, true);
            this._history = new List(_arg1.historyCells);
            this._scrollBar = new VScrollBar(_arg1.scrollThumb, _arg1.scrollTrack);
            this._scrollBar.reposition.add(this.onScrollbarReposition);
        }
        public function get getStarseedClick():ISignal{
            return (this._getStarseedClick);
        }
        public function get collectClick():ISignal{
            return (this._collectClick);
        }
        public function setHistory(_arg1:Vector.<ListDatum>):void{
            _arg1.sort(this.sortHistoryEntries);
            this._history.data = _arg1;
            this._scrollBar.setup(VIEWABLE_HISTORY_COUNT, _arg1.length);
            this._scrollBar.isVisible = (VIEWABLE_HISTORY_COUNT < _arg1.length);
        }
        public function setToCollectCount(_arg1:uint, _arg2:String, _arg3:Boolean):void{
            _asset.getStarseedsButton.visible = (((_arg1 < 1)) || (!(_arg3)));
            _asset.collectButton.visible = (((0 < _arg1)) && (_arg3));
            _asset.toBeClaimedField.text = _arg2;
        }
        override public function dispose(_arg1:Boolean=true):void{
            _asset.getStarseedsButton.removeEventListener(MouseEvent.CLICK, this.onGetStarseedsClick, false);
            this._getStarseedClick.removeAll();
            _asset.collectButton.removeEventListener(MouseEvent.CLICK, this.onCollectClick, false);
            this._collectClick.removeAll();
            this._scrollBar.reposition.remove(this.onScrollbarReposition);
        }
        private function sortHistoryEntries(_arg1:FriendGiftEntry, _arg2:FriendGiftEntry):int{
            return (_arg1.compareToOtherEntry(_arg2));
        }
        private function onScrollbarReposition(_arg1:Number):void{
            this._history.position = _arg1;
        }
        private function onGetStarseedsClick(_arg1:MouseEvent):void{
            this._getStarseedClick.dispatch();
        }
        private function onCollectClick(_arg1:MouseEvent):void{
            this._collectClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver 
