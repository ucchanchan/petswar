//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model.zodiac {
    import com.gaiaonline.monster.model.vo.*;
    import __AS3__.vec.*;

    public class ZodiacModel {

        private var isInited:Boolean;
        private var _zodiacs:Vector.<ZodiacVO>;
        private var _zodiacMap:Object;

        public function ZodiacModel(){
            this.isInited = false;
            this._zodiacs = new Vector.<ZodiacVO>();
            this._zodiacMap = {};
        }
        public function init(_arg1:Object):void{
            var _local2:Object;
            var _local3:int;
            var _local4:ZodiacVO;
            if (this.isInited){
                return;
            };
            this.isInited = true;
            for each (_local2 in _arg1) {
                _local3 = _local2.id;
                _local4 = this._zodiacMap[_local3];
                if (!_local4){
                    _local4 = this.generateZodiac(_local2);
                    this._zodiacMap[_local3] = _local4;
                    this._zodiacs.push(_local4);
                } else {
                    if (_local2.modifiers){
                        this.parseModifiers(_local4, _local2.modifiers);
                    };
                };
            };
            this._zodiacs.sort(this.sortZodiacs);
        }
        private function sortZodiacs(_arg1:ZodiacVO, _arg2:ZodiacVO):int{
            return (((_arg1.id < _arg2.id)) ? -1 : 1);
        }
        public function get zodiacs():Vector.<ZodiacVO>{
            return (this._zodiacs);
        }
        public function getZodiacByID(_arg1:uint):ZodiacVO{
            return (this._zodiacMap[_arg1]);
        }
        private function generateZodiac(_arg1:Object):ZodiacVO{
            var _local2:ZodiacVO = new ZodiacVO();
            var _local3:uint = _arg1.id;
            _local2.id = _local3;
            _local2.elementID = ((_local3 >> 1) % 4);
            _local2.row = ((_local3 - 1) >> 1);
            _local2.startDate = _arg1.start_date;
            _local2.endDate = _arg1.end_date;
            _local2.name = _arg1.name;
            _local2.description = _arg1.description;
            this.parseModifiers(_local2, _arg1.modifiers);
            return (_local2);
        }
        private function parseModifiers(_arg1:ZodiacVO, _arg2:Object):void{
            var _local3:String;
            var _local4:String;
            for (_local3 in _arg2) {
                _local4 = String(_arg2[_local3]);
                _arg1.effectiveness.addZodiac(_local4, uint(_local3));
            };
        }

    }
}//package com.gaiaonline.monster.model.zodiac 
