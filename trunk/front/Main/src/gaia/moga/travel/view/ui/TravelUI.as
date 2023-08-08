//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.services.*;
    import gaia.moga.travel.assets.*;

    public class TravelUI extends Panel {

        private var _travel:Signal;
        private var _close:Signal;
        private var _enabled:Signal;
        private var _disabled:Signal;
        private var bundle:TravelAssetBundle;
        private var buttons:TravelUIButtons;
        private var playhead:MovieClipPlayhead;

        public function TravelUI(_arg1:TravelAssetBundle, _arg2:Ticker){
            this._travel = new Signal(Zone);
            this._close = new Signal();
            this._enabled = new Signal();
            this._disabled = new Signal();
            this.bundle = _arg1;
            this.buttons = new TravelUIButtons(_arg1.travel);
            this.buttons.clicked.addOnce(this.onButtonClicked);
            this.buttons.cancel.addOnce(this.onCancelTravel);
            addChild(this.buttons);
            this.playhead = new MovieClipPlayhead((_arg1.travel.content as MovieClip), _arg2);
        }
        public function enable():void{
            this.playhead.at.addOnce(this.playheadAtIn);
            this.playhead.playTo("in");
        }
        private function playheadAtIn(_arg1:MovieClipPlayhead, _arg2:String):void{
            this._enabled.dispatch();
        }
        public function disable():void{
            this.playhead.at.addOnce(this.playheadAtOut);
            this.playhead.playTo("out");
        }
        private function playheadAtOut(_arg1:MovieClipPlayhead, _arg2:String):void{
            this._disabled.dispatch();
        }
        public function setZones(_arg1:Object):void{
            var _local2:Zone;
            for each (_local2 in _arg1) {
                this.buttons.setAvailability(_local2);
            };
        }
        override public function setup():void{
            this.buttons.enable();
        }
        private function onButtonClicked(_arg1:Zone):void{
            this._travel.dispatch(_arg1);
        }
        private function onCancelTravel():void{
            this._close.dispatch();
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.buttons){
                return;
            };
            removeChild(this.buttons);
            this.buttons.dispose(_arg1);
            this.buttons = null;
        }
        public function get travel():ISignal{
            return (this._travel);
        }
        public function get close():ISignal{
            return (this._close);
        }
        public function get enabled():ISignal{
            return (this._enabled);
        }
        public function get disabled():ISignal{
            return (this._disabled);
        }

    }
}//package gaia.moga.travel.view.ui 
