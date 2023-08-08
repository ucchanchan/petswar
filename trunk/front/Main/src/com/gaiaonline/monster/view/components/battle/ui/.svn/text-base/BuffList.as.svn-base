//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import alecmce.ui.data.list.*;

    public class BuffList {

        private var mapBuffs:Object;
        private var mapItems:Object;
        private var mapItemsBuff:Dictionary;
        private var list:ShortUIList;
        private var _buffRemoved:Signal;
        private var _buffRollOver:Signal;
        private var _buffRollOut:Signal;
        private var _ui:MovieClip;

        private static const BUFF:String = "buff";
        private static const COUNT:uint = 9;

        public function BuffList(){
            this.mapBuffs = {};
            this.mapItems = {};
            this.mapItemsBuff = new Dictionary();
            this._buffRemoved = new Signal(BuffVO);
            this._buffRollOver = new Signal();
            this._buffRollOut = new Signal();
        }
        public function init(_arg1:Sprite):void{
            this.setupList(_arg1);
        }
        public function add(_arg1:BuffVO, _arg2:Asset):Boolean{
            var _local3:String = _arg1.id;
            if (this.mapItems[_local3]){
                return (false);
            };
            var _local4:BuffListItem = new BuffListItem(_arg1.name, _arg2);
            var _local5:Boolean = this.list.add(_local4);
            _local4.rollOver.add(this.onRollOverBuff);
            _local4.rollOut.add(this.onRollOutBuff);
            if (_local5){
                this.mapItems[_local3] = _local4;
                this.mapBuffs[_local3] = _arg1;
                this.mapItemsBuff[_local4] = _arg1;
            };
            return (_local5);
        }
        public function remove(_arg1:BuffVO):Boolean{
            var _local2:String = _arg1.id;
            var _local3:BuffListItem = this.mapItems[_local2];
            if (!_local3){
                return (false);
            };
            var _local4:Boolean = this.list.remove(_local3);
            if (_local4){
                delete this.mapItems[_local2];
                delete this.mapBuffs[_local2];
            };
            return (_local4);
        }
        public function update(_arg1:Object):Vector.<BuffVO>{
            var _local3:String;
            var _local4:uint;
            var _local5:BuffListItem;
            var _local6:BuffVO;
            var _local7:BuffCountVO;
            var _local8:Boolean;
            var _local9:int;
            var _local2:Vector.<BuffVO> = new Vector.<BuffVO>();
            for (_local3 in this.mapItems) {
                _local4 = uint(_local3);
                _local5 = this.mapItems[_local4];
                _local6 = this.mapBuffs[_local4];
                _local7 = _arg1[_local4];
                _local8 = (_local7 == null);
                if (!_local8){
                    _local9 = (_local6.duration - _local7.count);
                    _local8 = (_local9 == 0);
                    if (_local9){
                        _local5.count(_local9);
                    };
                };
                if (((_local8) && (this.remove(_local6)))){
                    _local2.push(_local6);
                };
            };
            return (_local2);
        }
        private function setupList(_arg1:Sprite):void{
            var _local4:Sprite;
            this._ui = MovieClip(_arg1);
            this._ui.toolTip.visible = false;
            var _local2:Vector.<Rectangle> = new Vector.<Rectangle>();
            this._ui.buttonMode = true;
            var _local3:int;
            while (_local3 < COUNT) {
                _local4 = Sprite(_arg1.getChildByName((BUFF + _local3)));
                _local2.push(_local4.getRect(_arg1));
                _arg1.removeChild(_local4);
                _local3++;
            };
            this.list = new ShortUIList(_local2);
            this.list.init(this._ui);
        }
        private function onRollOverBuff(_arg1:BuffListItem):void{
            this._buffRollOver.dispatch(this, this.mapItemsBuff[_arg1], _arg1);
        }
        private function onRollOutBuff(_arg1:BuffListItem):void{
            this._ui.toolTip.visible = false;
            this._buffRollOut.dispatch();
        }
        public function showBuffDescription(_arg1:BuffListItem, _arg2:String, _arg3:String):void{
            this._ui.toolTip.visible = true;
            _arg1.showDescription(this._ui.toolTip, _arg2, _arg3);
        }
        public function hideBuffDescription():void{
            this._ui.toolTip.visible = true;
        }
        public function clear():void{
            this.mapBuffs = {};
            this.mapItems = {};
            this.list.clear();
        }
        public function get buffRemoved():Signal{
            return (this._buffRemoved);
        }
        public function get buffRollOver():Signal{
            return (this._buffRollOver);
        }
        public function get buffRollOut():Signal{
            return (this._buffRollOver);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
