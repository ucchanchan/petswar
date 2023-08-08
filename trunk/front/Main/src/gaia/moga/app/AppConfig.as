//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app {

	import com.gaiaonline.monster.constant.SystemConstant;
	
	import flash.utils.flash_proxy;

    public class AppConfig {

        private var _host:String;
        private var _version:String;
        private var _lang:String;

        public static const LANGUAGE:String = "{$LANGUAGE}";

        public function AppConfig(){
            this._host = "";
            this._version = uint(new Date().valueOf()).toString(16);
            this._lang = "en";
        }
        public function init(_arg1:String, _arg2:String):void{
            if (_arg1 != ""){
                this._version = _arg1;
            };
            this._host = _arg2;
        }
        public function parseURL(_arg1:String):String{
            if (_arg1.indexOf("http") != -1){
                return (_arg1);
            };
            if (_arg1.indexOf(LANGUAGE) != -1){
                _arg1 = _arg1.replace(LANGUAGE, this._lang);
            };
			
			if(SystemConstant.TEST_MODE){
				this._host = "static/"
			}
			
			//"http://s.cdn.gaiaonline.com/images/Gaia_Flash/social/fbapps/monsterpets/"
            return ((((this._host + _arg1) + "?version=") + this._version));
        }

    }
}//package gaia.moga.app 
