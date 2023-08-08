//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import alecmce.ui.*;
    import alecmce.ui.button.*;
    import flash.text.*;

    public class IconButton extends MovieClipButton {

        private var _icon:Asset;

        public function IconButton(_arg1:MovieClip){
            super(_arg1);
        }
        public function set points(_arg1:String):void{
            var _local2:MovieClip = _ui.points;
            var _local3:TextField = _local2.points;
            _local3.text = _arg1;
        }
        public function set icon(_arg1:Asset):void{
            if (this._icon == _arg1){
                return;
            };
            if (this._icon){
                _ui.container.removeChild(this._icon.self);
                this._icon.dispose();
            };
            this._icon = _arg1;
            if (_ui.container.icon){
                _ui.container.icon.visible = (_arg1 == null);
            };
            var _local2:InteractiveObject = InteractiveObject(this._icon.self);
            _local2.mouseEnabled = false;
            _ui.container.addChild(this._icon.self);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
