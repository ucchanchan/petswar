//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.top {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import org.osflash.signals.natives.*;
    import flash.text.*;
    import com.gaiaonline.monster.view.components.whistleAlert.*;

    public class Top extends Panel {

        public var ui:Asset;
        private var numWhistlesTF:TextField;
        private var numRechargesTF:TextField;
        private var numSeedsTF:TextField;
        private var premiumCurrencyTF:TextField;
        private var content:MovieClip;
        public var storeClicked:NativeSignal;
        public var rechargeClicked:NativeSignal;
        public var premiumClicked:NativeSignal;
        public var seedClicked:NativeSignal;
        public var prizeClicked:NativeSignal;
        public var whistleClicked:NativeSignal;
        private var whistleAlert:WhistleAlert;

        public function Top(_arg1:Asset){
            this.ui = _arg1;
            addChild(_arg1.self);
            if (!this.content){
                this.content = MovieClip(_arg1.content);
            };
            this.numWhistlesTF = this.content.tray.whistles.label;
            this.numRechargesTF = this.content.tray.recharges.label;
            this.numSeedsTF = this.content.tray.seeds.label;
            this.premiumCurrencyTF = this.content.tray.premium.label;
            this.storeClicked = new NativeSignal(this.content.storeBtn, MouseEvent.CLICK);
            this.rechargeClicked = new NativeSignal(this.content.tray.recharges, MouseEvent.CLICK);
            this.premiumClicked = new NativeSignal(this.content.tray.premium, MouseEvent.CLICK);
            this.seedClicked = new NativeSignal(this.content.tray.seeds, MouseEvent.CLICK);
            this.prizeClicked = new NativeSignal(this.content.dailyPrize, MouseEvent.CLICK);
            this.whistleClicked = new NativeSignal(this.content.tray.whistles, MouseEvent.CLICK);
            this.content.tray.recharges.buttonMode = true;
            this.content.tray.premium.buttonMode = true;
            this.content.tray.seeds.buttonMode = true;
            this.disableDailyPrize();
        }
        public function disableButtons():void{
            this.content.recharges.buttonMode = false;
            this.content.premium.buttonMode = false;
            this.content.seeds.buttonMode = false;
            this.content.tray.whistles.buttonMode = false;
        }
        public function set numWhistles(_arg1:uint):void{
            this.numWhistlesTF.text = _arg1.toString();
        }
        public function set premiumCurrency(_arg1:uint):void{
            this.premiumCurrencyTF.text = _arg1.toString();
        }
        public function set numSeeds(_arg1:uint):void{
            this.numSeedsTF.text = _arg1.toString();
        }
        public function set numRecharges(_arg1:uint):void{
            this.numRechargesTF.text = _arg1.toString();
        }
        public function disableDailyPrize():void{
            this.content.dailyPrize.visible = false;
        }
        public function enableDailyPrize():void{
            this.content.dailyPrize.visible = true;
        }
        public function showWhistleAlert(_arg1:Asset, _arg2:Boolean):void{
            this.content.tray.whistles.buttonMode = true;
            if (((this.whistleAlert) && (contains(this.whistleAlert)))){
                removeChild(this.whistleAlert);
            };
            this.whistleAlert = new WhistleAlert(_arg1, _arg2);
            addChild(this.whistleAlert);
        }
        public function showFriendInfo(_arg1:Asset, _arg2:String):void{
            this.content.friendInfo.title.text = (_arg2 + "'s Home");
        }
        public function disableCelebrate():void{
            this.content.celebrate.visible = false;
        }
        public function hideFriendInfo():void{
            this.content.friendInfo.visible = false;
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.ui){
                return;
            };
            this.storeClicked.removeAll();
            this.storeClicked = null;
            this.numWhistlesTF = null;
            this.numSeedsTF = null;
            this.numRechargesTF = null;
            if (this.ui.self.parent == this){
                removeChild(this.ui.self);
            };
            this.ui.dispose(_arg1);
            this.ui = null;
        }

    }
}//package com.gaiaonline.monster.view.components.top 
