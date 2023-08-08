//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.controller.process {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.newuser.model.*;

    public class NewUserFlowData extends GSIProcess {

		[Inject]
        public var model:NewUserModel;
		[Inject]
        public var zodiacs:ZodiacModel;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var text:TextService;

        public function NewUserFlowData(){
            super("NewUserFlowData");
        }
        override protected function onInit():void{
            this.server.getZodiacs(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            if (((((!(_arg1)) || (!(_arg1.all_signs)))) || (!(_arg1.monsters)))){
                return (false);
            };
            this.zodiacs.init(_arg1.all_signs);
            this.parseMonsters(_arg1.monsters);
            return (true);
        }
        private function parseMonsters(_arg1:Object):void{
            var _local2:String;
            var _local3:Vector.<ZodiacMonsterModel>;
            for (_local2 in _arg1) {
                _local3 = this.parseZodiacMonsters(_arg1[_local2]);
                this.model.addZodiacMonsters(uint(_local2), _local3);
            };
        }
        private function parseZodiacMonsters(_arg1:Object):Vector.<ZodiacMonsterModel>{
            var _local3:Object;
            var _local4:ZodiacMonsterModel;
            var _local2:Vector.<ZodiacMonsterModel> = new Vector.<ZodiacMonsterModel>();
            for each (_local3 in _arg1) {
                _local4 = new ZodiacMonsterModel(_local3);
                _local4.text = this.text.getMonsterText(_local4.id);
                _local2.push(_local4);
            };
            return (_local2);
        }

    }
}//package gaia.moga.newuser.controller.process 
