//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;
    import com.gskinner.motion.easing.*;

    public class BattleUIStatus {

        public var complete:Signal;
        public var ui:MovieClip;
        private var labelTF:TextField;
        private var levelTF:TextField;
        private var hpTF:TextField;
        private var zodiacContainer:MovieClip;
        private var bar:Sprite;
        private var background:Sprite;
        private var tinted:MovieClip;
        private var _buffList:BuffList;
        private var _tween:GTween;
        private var _maxtween:GTween;
        private var _name:String;
        private var _value:int;
        private var _max:int;
        private var _displayMax:int;
        private var _time:Number;
        private var _level:String;
        private var _fullX:Number;
        private var _buffRemoved:Signal;
        private var _zodiac:Asset;

        private static const TIME:Number = 1;
        private static const PADDING:uint = 3;
        private static const LEVEL_TEXT:String = "Lv. ";

        public function BattleUIStatus(_arg1:MovieClip){
            this._buffRemoved = new Signal(Object);
            this.complete = new Signal(BattleUIStatus);
            this._buffList = new BuffList();
            this._buffList.buffRemoved.add(this.onBuffRemoved);
            this._name = "";
            this._level = "";
            this._value = 0;
            this._max = 0;
            this._displayMax = 0;
            this.init(_arg1);
        }
        public function onBuffRemoved(_arg1:BuffVO):void{
            var _local2:Object = {buff:_arg1, name:this._name};
            this._buffRemoved.dispatch(_local2);
        }
        public function get zodiac():Asset{
            return (this._zodiac);
        }
        public function clear():void{
            this.setup("", 0, 0, 0, null);
            this._buffList.clear();
        }
        public function setup(_arg1:String, _arg2:int, _arg3:int, _arg4:int, _arg5:Asset):void{
            this._name = _arg1;
            this._value = _arg2;
            this._max = _arg3;
            this._displayMax = _arg3;
            this._level = (_arg4) ? (LEVEL_TEXT + _arg4.toString()) : "";
            this.labelTF.text = this._name;
            this.levelTF.text = this._level;
            this.levelTF.x = ((this.labelTF.x + this.labelTF.getLineMetrics(0).width) + PADDING);
            this.hpTF.text = ((this._value + "/") + this._displayMax);
            this.tweenHP();
            this.setZodiac(_arg5);
        }
        private function setZodiac(_arg1:Asset):void{
            if (this._zodiac == _arg1){
                return;
            };
            if (this._zodiac){
                this.zodiacContainer.removeChild(this._zodiac.self);
            };
            this._zodiac = _arg1;
            if (this._zodiac){
                this.zodiacContainer.addChild(this._zodiac.self);
            };
        }
        public function set value(_arg1:int):void{
            this._value = _arg1;
            if (this._value < 0){
                this._value = 0;
            };
            this.update();
        }
        public function adjust(_arg1:int):void{
            this._value = (this._value + _arg1);
            if (this._value < 0){
                this._value = 0;
            };
            this.update();
        }
        private function update():void{
            this.hpTF.text = (this._displayMax) ? ((this._value + "/") + this._displayMax) : "";
            this.tweenHP();
        }
        public function setHp(_arg1:int, _arg2:int):void{
            _arg1 = ((_arg1 < 0)) ? 0 : ((_arg1 > _arg2)) ? _arg2 : _arg1;
            var _local3 = !((this._value == _arg1));
            var _local4 = !((this._displayMax == _arg2));
            this._value = _arg1;
            this._displayMax = _arg2;
            this.hpTF.text = (this._displayMax) ? ((this._value + "/") + this._displayMax) : "";
            if (((_local3) || (_local4))){
                if (_local4){
                    this.tweenMaxHP();
                };
                this.tweenHP();
            };
        }
        private function onComplete(_arg1:GTween):void{
            this.complete.dispatch(this);
        }
        public function get buffList():BuffList{
            return (this._buffList);
        }
        public function updateBuffs(_arg1:MonsterModel):Vector.<BuffVO>{
            return (this._buffList.update(_arg1.buffCounts));
        }
        private function init(_arg1:MovieClip):void{
            this.ui = _arg1;
            _arg1.alpha = 0;
            _arg1.visible = false;
            this.labelTF = TextField(_arg1.label);
            this.labelTF.autoSize = TextFieldAutoSize.RIGHT;
            this.labelTF.text = "";
            this.levelTF = TextField(_arg1.level);
            this.levelTF.autoSize = TextFieldAutoSize.RIGHT;
            this.levelTF.text = "";
            this.hpTF = _arg1.hp;
            this.hpTF.text = "";
            this.tinted = _arg1.bar;
            new GTween(this.tinted, 0.001, {tint:Color.fromHealth((this._value / this._max))});
            this.bar = this.tinted.bar;
            this._fullX = this.bar.x;
            this._time = (1 / this._fullX);
            this.bar.x = 0;
            var _local2:MovieClip = _arg1.bg_mask;
            this.background = _local2.bg_bar;
            this.background.x = 0;
            this._buffList.init(Sprite(_arg1.buffList));
            this.zodiacContainer = MovieClip(_arg1.zodiacIcon);
            if (this.zodiacContainer.numChildren){
                this.zodiacContainer.removeChildAt(0);
            };
            if (this._zodiac){
                this.zodiacContainer.addChild(this._zodiac.self);
            };
            this._tween = new GTween(this.bar, TIME);
            this._tween.ease = Quadratic.easeInOut;
            this._tween.onComplete = this.onComplete;
            this._maxtween = new GTween(this.background, TIME);
            this._maxtween.ease = Quadratic.easeInOut;
        }
        private function tweenHP():void{
            var _local1:Number = (this._value / this._displayMax);
            var _local2:Number = (this._max) ? (_local1 * this._fullX) : 0;
            var _local3:Number = (this._time * (this.bar.x - _local2));
            this._tween.delay = _local3;
            this._tween.setValue("x", _local2);
            new GTween(this.tinted, TIME, {tint:Color.fromHealth(_local1)});
        }
        private function tweenMaxHP():void{
            var _local1:Number = (this._displayMax / this._max);
            var _local2:Number = (this._max) ? ((_local1 * this._fullX) - this._fullX) : 0;
            this._maxtween.setValue("x", _local2);
        }
        public function showBuffStatus(_arg1:BuffList, _arg2:BuffListItem, _arg3:String, _arg4:String):void{
            _arg1.showBuffDescription(_arg2, _arg3, _arg4);
        }
        public function get hintTarget():MovieClip{
            return (this.tinted);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
