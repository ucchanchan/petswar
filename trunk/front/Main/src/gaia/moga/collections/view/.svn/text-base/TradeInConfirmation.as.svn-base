//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.ui.button.*;
    import gaia.moga.collections.model.reward.*;
    import gaia.lib.assets.*;

    public class TradeInConfirmation extends Panel {

        private var _signaller:SignallingAsset;
        private var _content:MovieClip;
        private var _ready:Signal;
        private var _complete:Signal;
        private var _okClick:Signal;
        private var _reward:MogaCollectionReward;
        private var _okButton:MovieClipButton;

        public function TradeInConfirmation(_arg1:Asset, _arg2:MogaCollectionReward){
            this._reward = _arg2;
            this.setupSignals();
            this.prepAsset(_arg1);
        }
        public function get ready():Signal{
            return (this._ready);
        }
        public function get complete():Signal{
            return (this._complete);
        }
        public function get okClick():Signal{
            return (this._okClick);
        }
        public function transitionOut():void{
            this._content.gotoAndPlay(16);
        }
        private function prepAsset(_arg1:Asset):void{
            if (_arg1.isComplete){
                this.setupAsset(_arg1);
            } else {
                _arg1.complete.add(this.setupAsset);
            };
        }
        private function setupAsset(_arg1:Asset):void{
            addChild(_arg1.self);
            this._signaller = SignallingAsset(_arg1.content);
            this._signaller.signal.add(this.onSignal);
            this._content = (_arg1.content as MovieClip);
            this.addReward();
            this.setupButton();
        }
        private function addReward():void{
            var _local1:CollectionRewards = new CollectionRewards(this._reward, this._content.dialog.spinny);
            _local1.extraPadding = 10;
            this._content.dialog.rewards.addChild(_local1);
        }
        private function setupButton():void{
            this._okButton = new MovieClipButton(this._content.dialog.okButton);
            this._okButton.clicked.add(this.onOKClick);
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._ready.removeAll();
            this._ready = null;
            this._complete.removeAll();
            this._complete = null;
            this._okClick.removeAll();
            this._okClick = null;
            this._okButton.clicked.removeAll();
            this._okButton = null;
            this._content.dialog.rewards.removeChildAt(0);
        }
        private function onOKClick(_arg1:MovieClipButton):void{
            this._okClick.dispatch();
        }
        private function setupSignals():void{
            this._ready = new Signal();
            this._complete = new Signal();
            this._okClick = new Signal();
        }
        private function onSignal(_arg1:String):void{
            if (_arg1 == "ready"){
                this._ready.dispatch();
            } else {
                if (_arg1 == "complete"){
                    this._complete.dispatch();
                };
            };
        }

    }
}//package gaia.moga.collections.view 
