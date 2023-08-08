//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import com.gaiaonline.monster.model.*;
    import flash.geom.*;
    import flash.text.*;
    import gaia.moga.newuser.view.ui.*;

    class SelectionStats {

        function SelectionStats(_arg1:MovieClip, _arg2:ZodiacMonsterModel){
            var _local3:int = _arg2.attackStrength;
            var _local4:int = _arg2.defenceStrength;
            var _local5:int = _arg2.zodiacStrength;
            this.displayName(_arg1.monsterName, _arg2.name);
            _arg1.rating_attack.gotoAndStop((_local3 + 1));
            _arg1.rating_defense.gotoAndStop((_local4 + 1));
            _arg1.rating_zodiac.gotoAndStop((_local5 + 1));
        }
        private function displayName(_arg1:TextField, _arg2:String):void{
            _arg1.text = _arg2;
            _arg1.visible = false;
            var _local3:Rectangle = _arg1.getRect(_arg1);
            var _local4:BitmapData = new BitmapData(_local3.width, _local3.height, true, 0);
            _local4.draw(_arg1);
            var _local5:Bitmap = new Bitmap(_local4);
            _local5.x = _arg1.x;
            _local5.y = _arg1.y;
            _local5.smoothing = true;
            _arg1.parent.addChild(_local5);
        }

    }
}//package gaia.moga.newuser.view.ui 
