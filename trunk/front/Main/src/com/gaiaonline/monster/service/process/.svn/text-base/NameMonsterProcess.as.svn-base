//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;

    public class NameMonsterProcess extends GSIProcess {

        private var TRIM:RegExp;

		[Inject]
        public var server:GSIDataService;
        public var monsterName:String;
        public var id:int;

        public function NameMonsterProcess(){
            this.TRIM = /^[ \n\r]+|[ \n\r]+$/g;
            super("NameMonsterProcess");
        }
        override protected function onInit():void{
            this.monsterName = this.monsterName.replace(this.TRIM, "");
            this.server.nameMonster(this, this.monsterName, this.id);
        }
        override protected function parse(_arg1:Object):Boolean{
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
