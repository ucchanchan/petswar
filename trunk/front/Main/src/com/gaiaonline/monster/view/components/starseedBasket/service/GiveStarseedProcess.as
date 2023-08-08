//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.service {
    import flash.events.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.*;

    public class GiveStarseedProcess extends GSIProcess {

        public var basketModel:StarseedBasketModel;
        public var dispatcher:IEventDispatcher;
        public var friendID:String;

        public function GiveStarseedProcess(){
            super("GiveStarseedProcess");
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.error){
                this.dispatcher.dispatchEvent(new MinorErrorEvent(MinorErrorEvent.ERROR, ((Errors.SERVER_REPORTED_ERROR_WHILE_GIVING_STARSEEDS + ":") + _arg1.error)));
                return (false);
            };
            this.basketModel.giveFriendSeed(this.friendID);
            return (true);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.service 
