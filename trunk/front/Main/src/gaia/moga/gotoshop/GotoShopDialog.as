//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gotoshop {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import gaia.lib.assets.*;

    public class GotoShopDialog extends Panel {

        private var _response:Signal;
        private var _asset:Asset;
        private var content:MovieClip;
        private var signaller:SignallingAsset;
        private var button:SimpleButton;
        public var complete:Signal;

        public function GotoShopDialog(_arg1:Asset, _arg2:String, _arg3:String){
            this._response = new Signal();
            this.complete = new Signal();
            this._asset = _arg1;
            addChild(this._asset.self);
            this.content = MovieClip(this._asset.content);
            this.signaller = SignallingAsset(this.content);
            this.signaller.signal.add(this.onSignal);
            var _local4:MovieClip = this.content.dialog;
            _local4.title.text = _arg2;
            _local4.body.text = _arg3;
            this.button = _local4.cta;
            this._asset.self.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }
        private function onAddedToStage(_arg1:Event):void{
            this.content.gotoAndPlay(1);
        }
        private function onSignal(_arg1:Object):void{
            switch (_arg1){
                case "ready":
                    this.content.stop();
                    this.button.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                    break;
                default:
                    this.signaller.signal.removeAll();
                    this.signaller = null;
                    this.complete.dispatch();
            };
        }
        private function onButtonClick(_arg1:MouseEvent):void{
            this.button.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this._response.dispatch();
            this.content.play();
            this.content = null;
            this.button = null;
        }
        public function get response():ISignal{
            return (this._response);
        }

    }
}//package gaia.moga.gotoshop 
