//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster {
    import flash.geom.*;
    import gaia.moga.monster.*;

    public class Color {

        public static const RED:uint = 12722214;
        public static const AMBER:uint = 16428315;
        public static const GREEN:uint = 13631350;
        public static const BLUE:uint = 3971770;
        public static const MESSAGE_RED:uint = 16737894;
        public static const MESSAGE_GREEN:uint = 6736998;
        public static const MESSAGE_BLUE:uint = 2003199;
        public static const MESSAGE_ORANGE:uint = 0xFF8800;
        public static const MESSAGE_GOLD:uint = 0xEECC00;
        public static const DARK_GREEN:uint = 4628573;
        public static const RARITY_COMMON:uint = 0xFFFFFF;
        public static const RARITY_UNCOMMON:uint = 65362;
        public static const RARITY_RARE:uint = 3316223;
        public static const RARITY_EPIC:uint = 16713973;
        public static const RARITY_LEGENDARY:uint = 16224828;
        public static const RARITY_LIMITED:uint = 0xB50000;

        public static function fromHealth(_arg1:Number):uint{
            var _local2:uint = ((_arg1 > 0.3)) ? GREEN : ((_arg1 > 0.1)) ? AMBER : RED;
            return ((4278190080 | _local2));
        }
        public static function fromXP(_arg1:Number):uint{
            return ((4278190080 | BLUE));
        }
        public static function fromMessage(_arg1:String):uint{
            var _local2:uint;
            switch (_arg1){
                case "RED":
                    _local2 = MESSAGE_RED;
                    break;
                case "GREEN":
                    _local2 = MESSAGE_GREEN;
                    break;
                case "BLUE":
                    _local2 = MESSAGE_BLUE;
                    break;
                case "ORANGE":
                    _local2 = MESSAGE_ORANGE;
                    break;
                case "GOLD":
                    _local2 = MESSAGE_GOLD;
                    break;
            };
            return (_local2);
        }
        public static function fromRarity(_arg1:uint):uint{
            var _local2:uint;
            switch (_arg1){
                case Rarity.BEGINNER:
                case Rarity.COMMON:
                    _local2 = RARITY_COMMON;
                    break;
                case Rarity.UNCOMMON:
                    _local2 = RARITY_UNCOMMON;
                    break;
                case Rarity.RARE:
                case Rarity.SUPER_RARE:
                    _local2 = RARITY_RARE;
                    break;
                case Rarity.EPIC:
                    _local2 = RARITY_EPIC;
                    break;
                case Rarity.LEGENDARY:
                    _local2 = RARITY_LEGENDARY;
                    break;
                case Rarity.LIMITED:
                    _local2 = RARITY_LIMITED;
                    break;
            };
            return ((4278190080 | _local2));
        }
        public static function setTransform(_arg1:ColorTransform, _arg2:uint):void{
            _arg1.alphaOffset = 0;
            _arg1.redOffset = 0;
            _arg1.greenOffset = 0;
            _arg1.blueOffset = 0;
            _arg1.alphaMultiplier = (((_arg2 >>> 24) & 0xFF) / 0xFF);
            _arg1.redMultiplier = (((_arg2 >>> 16) & 0xFF) / 0xFF);
            _arg1.greenMultiplier = (((_arg2 >>> 8) & 0xFF) / 0xFF);
            _arg1.blueMultiplier = ((_arg2 & 0xFF) / 0xFF);
        }

    }
}//package com.gaiaonline.monster 
