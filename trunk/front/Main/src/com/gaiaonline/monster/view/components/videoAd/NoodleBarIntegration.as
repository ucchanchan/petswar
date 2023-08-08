//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.videoAd {
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.external.*;

    public class NoodleBarIntegration {

        private var __thirdPartyId:String;
        private var __groupConfigId:String;
        private var __loader:Loader;
        private var __timeRemaining:int;

        public function NoodleBarIntegration(_arg1:String, _arg2:String=null){
            this.__thirdPartyId = "aflkadsjfadflka";
            this.__groupConfigId = _arg2;
            var _local3:String = ExternalInterface.call("NeoEdge.CGS.NoodleBar.domain");
            var _local4:String = ExternalInterface.call("NeoEdge.CGS.NoodleBar.clientSwfUrl");
            Security.allowDomain(_local3);
            Security.allowInsecureDomain(_local3);
            var _local5:ApplicationDomain = new ApplicationDomain();
            var _local6:LoaderContext = new LoaderContext(false, _local5);
            this.__loader = new Loader();
            this.__loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.__onLoaderComplete, false, 0, true);
            this.__loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.__onLoaderIOError, false, 0, true);
            this.__loader.load(new URLRequest(_local4), _local6);
        }
        private function __onLoaderComplete(_arg1:Event):void{
            this.__loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.__onLoaderComplete);
            this.__loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.__onLoaderIOError);
            var _local2:Object = {thirdPartyId:this.__thirdPartyId, uniqueId:ExternalInterface.call("NeoEdge.CGS.NoodleBar.uniqueId"), groupConfigId:this.__groupConfigId};
            this.__loader.content.addEventListener("clientReady", this.__onClientReady, false, 0, true);
            this.__loader.content.addEventListener("itemAwarded", this.__onItemAwarded, false, 0, true);
            this.__loader.content.addEventListener("pauseGame", this.__onPauseGame, false, 0, true);
            this.__loader.content.addEventListener("unpauseGame", this.__onUnpauseGame, false, 0, true);
            this.__loader.content.addEventListener("prerollCompleted", this.__onPrerollCompleted, false, 0, true);
            this.__loader.content.addEventListener("error", this.__onError, false, 0, true);
            var _local3 = this.__loader.content;
            _local3["init"](_local2);
            _local3 = this.__loader.content;
            _local3["enableBar"]();
            if (this.__loader.content["clientReady"]){
                this.__onClientReady();
            };
        }
        private function __onDisplayManagerStartIncentivizedAd(_arg1:Event):void{
            var _local2 = this.__loader.content;
            _local2["startIncentivizedAd"]();
        }
        private function __onDisplayManagerStartMidroll(_arg1:Event):void{
            var _local2 = this.__loader.content;
            _local2["startMidroll"]();
        }
        private function __onDisplayManagerEnable(_arg1:Event):void{
            var _local2 = this.__loader.content;
            _local2["enableBar"]();
        }
        private function __onDisplayManagerDisable(_arg1:Event):void{
            var _local2 = this.__loader.content;
            _local2["disableBar"]();
        }
        private function __onLoaderIOError(_arg1:IOErrorEvent):void{
            this.__loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.__onLoaderComplete);
            this.__loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.__onLoaderIOError);
            this.__loader = null;
        }
        private function __onClientReady(_arg1:Event=null):void{
            this.__timeRemaining = this.__loader.content["cooldownTimeRemaining"];
            if (this.__timeRemaining == 0){
                var _local2 = this.__loader.content;
                _local2["startMidroll"]();
            };
        }
        private function __onItemAwarded(_arg1:Event):void{
        }
        private function __onPauseGame(_arg1:Event):void{
        }
        private function __onUnpauseGame(_arg1:Event):void{
        }
        private function __onPrerollCompleted(_arg1:Event):void{
        }
        private function __onError(_arg1:Event):void{
        }

    }
}//package com.gaiaonline.monster.view.components.videoAd 
