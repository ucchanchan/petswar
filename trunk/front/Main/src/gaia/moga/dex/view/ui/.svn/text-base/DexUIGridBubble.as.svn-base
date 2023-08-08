//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import flash.geom.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;

    public class DexUIGridBubble {

        private var ui:MovieClip;
        private var language:DexLanguageBundle;
        private var background:MovieClip;
        private var moga:TextField;
        private var count:TextField;
        private var rarity:TextField;
        private var ct:ColorTransform;
        private var tween:GTween;

        private static const DURATION:Number = 0.2;

        public function DexUIGridBubble(_arg1:MovieClip, _arg2:DexLanguageBundle){
            this.ui = _arg1;
            this.language = _arg2;
            _arg1.alpha = 0;
            _arg1.mouseEnabled = false;
            _arg1.mouseChildren = false;
            this.background = _arg1.background;
            this.moga = _arg1.moga;
            this.moga.selectable = false;
            this.count = _arg1.count;
            this.count.selectable = false;
            this.rarity = _arg1.rarity;
            this.rarity.selectable = false;
            this.ct = new ColorTransform(1, 1, 1, 1);
            this.tween = new GTween(_arg1, DURATION);
        }
        public function show(_arg1:DexMoga, _arg2:Number, _arg3:Number):void{
            var _local7:String;
            this.ui.x = _arg2;
            this.ui.y = _arg3;
            var _local4:uint = _arg1.count;
            if (!_local4){
                return;
            };
            var _local5:uint = _arg1.getInstance(0).model.level;
            var _local6:uint = _arg1.getInstance((_local4 - 1)).model.level;
            switch (_local4){
                case 1:
                    _local7 = ("Lv. " + _local5);
                    break;
                case 2:
                    _local7 = ((("Lvs. " + _local5) + ", ") + _local6);
                    break;
                default:
                    _local7 = ((("Lvs. " + _local5) + "..") + _local6);
                    break;
            };
            this.moga.text = _local7;
            this.count.text = _local4.toString();
            this.rarity.text = this.language.getRarity(_arg1.rarity);
            var _local8:uint = Color.fromRarity(_arg1.rarity);
            this.ct.alphaMultiplier = (((_local8 >>> 24) & 0xFF) / 0xFF);
            this.ct.redMultiplier = (((_local8 >>> 16) & 0xFF) / 0xFF);
            this.ct.greenMultiplier = (((_local8 >>> 8) & 0xFF) / 0xFF);
            this.ct.blueMultiplier = ((_local8 & 0xFF) / 0xFF);
            this.background.transform.colorTransform = this.ct;
            this.ui.alpha = 0;
            this.tween.setValue("alpha", 1);
            this.ui.mouseEnabled = false;
            this.ui.mouseChildren = false;
        }
        public function hide():void{
            this.tween.setValue("alpha", 0);
        }

    }
}//package gaia.moga.dex.view.ui 
