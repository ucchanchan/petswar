//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;

    public class SetMonsterStorageProcess extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
        public var isStored:Boolean;
        public var id:String;

        public function SetMonsterStorageProcess(){
            super("SetMonsterStorageProcess");
        }
        override protected function onInit():void{
            this.server.setMonsterStorageState(this, this.isStored, this.id);
        }
        override protected function parse(_arg1:Object):Boolean{
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
