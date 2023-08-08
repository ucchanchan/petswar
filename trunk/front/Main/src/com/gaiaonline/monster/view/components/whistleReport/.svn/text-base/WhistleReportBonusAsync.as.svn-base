//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleReport {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.async.*;

    public class WhistleReportBonusAsync extends AsyncBase {

        private var _asset:Asset;
        private var _animSuffix:String;// = "1x"
        private var _currentAnim:MovieClip;
        private var _xp:int;// = 0
        private var _monsterName:String;// = ""

        public static const BONUS_1X:String = "1x";
        public static const BONUS_2X:String = "2x";
        public static const BONUS_3X:String = "3x";
        private static const BONUS_CLIP_PREFIX:String = "mogaFriendBonus";
        private static const PLACEMENT_TABLE:Object = {mogaFriendBonus1x:{x:110, y:-45}, mogaFriendBonus2x:{x:120, y:-110}, mogaFriendBonus3x:{x:110, y:-150}};

        public function WhistleReportBonusAsync(_arg1:Asset, _arg2:Boolean=true){
            this._asset = _arg1;
            if (_arg2){
                init();
            };
        }
        public function setBonusMultiplier(_arg1:String):void{
            this._animSuffix = _arg1;
        }
        public function setData(_arg1:String, _arg2:int):void{
            this._xp = _arg2;
            this._monsterName = _arg1;
            if (this._currentAnim){
                this.setClipData(this._currentAnim);
            };
        }
        public function get currentAnim():MovieClip{
            this._currentAnim = (this._asset.content[(BONUS_CLIP_PREFIX + this._animSuffix)] as MovieClip);
            if (this._currentAnim != null){
                this._currentAnim.gotoAndStop(1);
                this._currentAnim.addFrameScript((this._currentAnim.totalFrames - 1), this.onFinalFrame);
                this.setClipData(this._currentAnim);
            };
            return (this._currentAnim);
        }
        private function setClipData(_arg1:DisplayObject):void{
            var _local5:String;
            var _local2:MovieClip = (_arg1 as MovieClip);
            var _local3:int = int(this._animSuffix.charAt(0));
            var _local4:int = Math.floor((this._xp / _local3));
            if (_local2.xp_msg_mc){
                _local5 = (((this._monsterName + " got <span class='xpCol'>") + _local4.toString(10)) + " XP</span>");
                if (_local3 > 1){
                    _local5 = (_local5 + ((" <span class='bonusCol'>x" + _local3) + "!"));
                } else {
                    _local5 = (_local5 + "!");
                };
                _local2.xp_msg_mc.xp_msg_text.htmlText = _local5;
            };
            if (_local2.xp_get_mc){
                _local2.xp_get_mc.horoscope_xp.text = (this._xp.toString(10) + " XP");
            };
        }
        override protected function onInit():void{
            var _local2:DisplayObject;
            super.onInit();
            var _local1:int;
            while (_local1 < Sprite(this._asset.content).numChildren) {
                _local2 = Sprite(this._asset.content).getChildAt(_local1);
                _local2.x = 378;
                _local2.y = -2;
                this.setClipData(_local2);
                _local1++;
            };
        }
        private function onFinalFrame():void{
            this._currentAnim.stop();
            asyncComplete();
        }

    }
}//package com.gaiaonline.monster.view.components.whistleReport 
