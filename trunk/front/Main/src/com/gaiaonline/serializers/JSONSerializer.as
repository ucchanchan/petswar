//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.serializers {
    import com.adobe.serialization.json.*;

    public class JSONSerializer {

        public static const encodeName:String = "json";

        public static function serialize(_arg1):String{
            return (JSON.encode(_arg1));
        }
        public static function unserialize(_arg1:String){
            return (JSON.decode(_arg1));
        }

    }
}//package com.gaiaonline.serializers 
