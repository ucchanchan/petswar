//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import flash.utils.*;
    import alecmce.ui.*;
    import gaia.moga.collections.model.*;
    import alecmce.ui.button.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import flash.text.*;
    import com.gaiaonline.monster.service.*;
    import gaia.lib.assets.*;
    import flash.filters.*;

    public class MiniCollectionAnim extends BasicAnim {

        private var _isPlaying:Boolean;// = false
        private var _container:DisplayObjectContainer;
        private var _asset:Asset;
        private var _collection:MogaCollectionVO;
        private var _content:MovieClip;
        private var _signaller:SignallingAsset;
        private var _goButton:MovieClipButton;
        private var assetSlotMap:Dictionary;
        private var assetItemMap:Dictionary;

        private static const FINISHED_COLLECTION_FRAME:uint = 18;
        private static const UNFINISHED_COLLECTION_FRAME:uint = 12;

        public function MiniCollectionAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:MogaCollectionVO){
            this._container = _arg1;
            this._asset = _arg2;
            this._collection = _arg3;
            if (this._asset.isComplete){
                this.setup(this._asset);
            } else {
                this._asset.complete.addOnce(this.setup);
            };
        }
        private function setup(_arg1:Asset):void{
            this._content = MovieClip(_arg1.content).anim;
            this._content.stop();
            this._signaller = SignallingAsset(this._content);
            this._signaller.signal.add(this.onSignal);
            if (this._isPlaying){
                this.play();
            };
        }
        override public function play():void{
            this._isPlaying = true;
            if (!this._asset.isComplete){
                return;
            };
            this._container.addChild(this._asset.self);
            this._content.play();
        }
        private function onSignal(_arg1:String):void{
            if (_arg1 == "mainReady"){
                this.onMainReady();
            } else {
                if (_arg1 == "preMessage"){
                    this.onPreMessage();
                } else {
                    if (_arg1 == "unfinishedMessageReady"){
                        this.onUnfinishedMessageReady();
                    } else {
                        if (_arg1 == "finishedMessageReady"){
                            this.onFinishedMessageReady();
                        };
                    };
                };
            };
        }
        private function onMainReady():void{
            this._content.main.nameField.text = this._collection.name;
            var _local1:int;
            while (_local1 < this._collection.items.length) {
                this.updateCell(this._content.main[("cell" + _local1)], this._collection.items[_local1]);
                _local1++;
            };
        }
        private function updateCell(_arg1:MovieClip, _arg2:MogaCollectionItem):void{
            var _local3:Bitmap;
            var _local4:StyleSheet;
            var _local5:Object;
            if (_arg2.asset.isComplete){
                _local3 = Utils.createBitmapFromDisplayObject(_arg2.asset.self, 38, 38);
                if (_arg2.quantity == 0){
                    this.desaturate(_local3);
                };
                _arg1.cardHolder.addChild(_local3);
                _local4 = new StyleSheet();
                _local5 = new Object();
                _local5.color = "#172A52";
                if (0 < _arg2.quantity){
                    _local4.setStyle("qty", _local5);
                };
                TextField(_arg1.countField).styleSheet = _local4;
                _arg1.countField.htmlText = (("<qty>x" + _arg2.quantity) + "<qty>");
            } else {
                this.delayCellUpdate(_arg1, _arg2);
            };
        }
        private function delayCellUpdate(_arg1:MovieClip, _arg2:MogaCollectionItem):void{
            this.assetSlotMap = ((this.assetSlotMap) || (new Dictionary()));
            this.assetItemMap = ((this.assetItemMap) || (new Dictionary()));
            this.assetSlotMap[_arg2.asset] = _arg1;
            this.assetItemMap[_arg2.asset] = _arg2;
            _arg2.asset.complete.addOnce(this.onAssetComplete);
        }
        private function onAssetComplete(_arg1:Asset):void{
            var _local2:MovieClip = this.assetSlotMap[_arg1];
            delete this.assetSlotMap[_arg1];
            var _local3:MogaCollectionItem = this.assetItemMap[_arg1];
            delete this.assetItemMap[_arg1];
            this.updateCell(_local2, _local3);
        }
        private function desaturate(_arg1:DisplayObject):void{
            var _local2:Array = new Array();
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0.25, 0.25, 0.25, 0, 0]);
            _local2 = _local2.concat([0, 0, 0, 0.25, 0]);
            var _local3:ColorMatrixFilter = new ColorMatrixFilter(_local2);
            _arg1.filters = [_local3];
        }
        private function onPreMessage():void{
            if (this._collection.progress == 1){
                this._content.gotoAndPlay(FINISHED_COLLECTION_FRAME);
            } else {
                this._content.gotoAndPlay(UNFINISHED_COLLECTION_FRAME);
            };
        }
        private function onUnfinishedMessageReady():void{
            this._goButton = new MovieClipButton(this._content.receivedMessage.goButton);
            this._goButton.clicked.addOnce(this.onGoClick);
        }
        private function onFinishedMessageReady():void{
            var _local1 = "You've completed the %COLLECTION_NAME% collection. Go to your collections page to cash it in for a reward!";
            this._content.completeMessage.messageField.text = _local1.replace("%COLLECTION_NAME%", this._collection.name);
            this._goButton = new MovieClipButton(this._content.completeMessage.goButton);
            this._goButton.clicked.addOnce(this.onGoClick);
        }
        private function onGoClick(_arg1:MovieClipButton):void{
            this._content.stop();
            this._container.removeChild(this._asset.self);
            this._asset.dispose();
            this._signaller.signal.removeAll();
            this._signaller = null;
            this._asset = null;
            this._collection = null;
            this._container = null;
            this._content = null;
            this._goButton = null;
            this.assetItemMap = null;
            this.assetSlotMap = null;
            _complete.dispatch(this);
        }

    }
}//package gaia.moga.collections.view 
