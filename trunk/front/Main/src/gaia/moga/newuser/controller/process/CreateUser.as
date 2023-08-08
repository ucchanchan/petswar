//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.controller.process {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.newuser.model.*;

    public class CreateUser extends GSIProcess {

		[Inject]
        public var model:NewUserModel;
		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var server:GSIDataService;

        public function CreateUser(){
            super("CreateUser");
        }
        override protected function onInit():void{
            var _local1:ZodiacMonsterModel = this.model.chosen;
            var _local2:Object = {};
            _local2.user_locale = this.app.locale;
            _local2.user_gender = this.app.gender;
            if (this.app.promo){
                _local2.promo = this.app.promo;
            };
            this.server.createUser(this, _local1.zodiac, _local1.id, _local1.name, this.app.email, _local2);
        }
        override protected function parse(_arg1:Object):Boolean{
            return (true);
        }

    }
}//package gaia.moga.newuser.controller.process 
