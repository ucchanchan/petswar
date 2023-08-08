//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.settings.view.ui.*;

    public class Menu extends Sprite {

        private var ui:Asset;
        public var clicked:Signal;
        public var sound:Signal;
        private var map:Object;
        private var travelButton:TravelButton;
        private var questButton:QuestsButton;
        private var dexButton:MenuButton;
        private var settingsButton:SettingsButton;
        private var collectionsButton:MenuButton;
        private var enabled:Vector.<MenuButton>;
        private var isEnabled:Boolean;

        public static const SLIDE:String = "SLIDE";
        public static const TRAVEL:String = "TRAVEL";
        public static const HOME:String = "HOME";
        public static const DEX:String = "DEX";
        public static const QUEST:String = "QUEST";
        public static const SETTINGS:String = "SETTINGS";
        public static const COLLECTIONS:String = "COLLECTIONS";

        public function Menu(_arg1:Asset){
            this.ui = _arg1;
            this.clicked = new Signal(String);
            this.sound = new Signal(String);
            this.enabled = new Vector.<MenuButton>();
            this.isEnabled = false;
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset):void{
            var _local2:MovieClip = MovieClip(_arg1.content);
            this.map = {};
            this.map[TRAVEL] = (this.travelButton = new TravelButton(_local2.travelButton, TRAVEL));
            this.map[QUEST] = (this.questButton = new QuestsButton(_local2.questButton, QUEST));
            this.map[DEX] = (this.dexButton = new MenuButton(_local2.dexButton, DEX));
            this.map[SETTINGS] = (this.settingsButton = new SettingsButton(_local2.settingsButton, SETTINGS));
            this.map[COLLECTIONS] = (this.collectionsButton = new MenuButton(_local2.collectionsButton, COLLECTIONS));
            addChild(_arg1.self);
        }
        public function get settings():Settings{
            return (this.settingsButton.settings);
        }
        public function dispose(_arg1:Boolean=true):void{
            if (!this.ui){
                return;
            };
            var _local2:DisplayObject = this.ui.self;
            if (_local2.parent){
                _local2.parent.removeChild(_local2);
            };
            this.travelButton.dispose(_arg1);
            this.questButton.dispose(_arg1);
            this.dexButton.dispose(_arg1);
            this.settingsButton.dispose(_arg1);
            this.collectionsButton.dispose(_arg1);
            this.settingsButton = null;
            this.travelButton = null;
            this.questButton = null;
            this.dexButton = null;
            this.collectionsButton = null;
            this.ui = null;
        }
        public function setQuestTotal(_arg1:int):void{
            this.questButton.setCount(_arg1);
        }
        public function hideArrow(_arg1:String):void{
            if (_arg1 == HOME){
                _arg1 = TRAVEL;
            };
            this.map[_arg1].arrow = false;
        }
        public function showArrow(_arg1:String):void{
            if (_arg1 == HOME){
                _arg1 = TRAVEL;
            };
            this.map[_arg1].arrow = true;
        }
        public function setup(_arg1:Vector.<String>):void{
            var _local2:String;
            this.enabled.length = 0;
            this.enabled.push(this.settingsButton);
            for each (_local2 in _arg1) {
                this.enabled.push(this.map[_local2]);
            };
            this.update();
        }
        public function setTip(_arg1:String, _arg2:String, _arg3:String):void{
            var _local4:MenuButton = this.map[_arg1];
            _local4.setTip(_arg2, _arg3);
        }
        public function enable():void{
            this.isEnabled = true;
            this.update();
        }
        public function disable():void{
            var _local1:MenuButton;
            this.isEnabled = false;
            for each (_local1 in this.map) {
                _local1.over.removeAll();
                _local1.clicked.removeAll();
                _local1.isEnabled = false;
            };
        }
        private function update():void{
            var _local1:MenuButton;
            for each (_local1 in this.enabled) {
                _local1.over.add(this.onOver);
                _local1.clicked.add(this.onClicked);
                _local1.isEnabled = true;
            };
        }
        private function onOver(_arg1:String):void{
            this.sound.dispatch(SLIDE);
        }
        private function onClicked(_arg1:String):void{
            if (_arg1 != SETTINGS){
                this.disable();
            };
            this.clicked.dispatch(_arg1);
        }

    }
}//package gaia.moga.menu.view.ui 
