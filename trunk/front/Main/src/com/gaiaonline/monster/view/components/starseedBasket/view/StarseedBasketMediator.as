//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class StarseedBasketMediator extends Mediator {

		[Inject]
        public var view:StarseedBasket;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var basketModel:StarseedBasketModel;

        private static const NOVA_FB_ID:String = "100001591722543";

        override public function onRegister():void{
            if (this.application.friendRanchID == NOVA_FB_ID){
                this.view.visible = false;
                return;
            };
            this.view.click.add(this.onBasketClick);
            this.onBasketUpdate();
            this.basketModel.updated.add(this.onBasketUpdate);
        }
        override public function onRemove():void{
            this.basketModel.updated.remove(this.onBasketUpdate);
        }
        private function onBasketClick(_arg1:MouseEvent):void{
            if (this.application.state == ApplicationState.FRIEND_RANCH){
                dispatch(new StarseedBasketEvent(StarseedBasketEvent.OPEN_GIVER_UI));
            } else {
                dispatch(new StarseedBasketEvent(StarseedBasketEvent.OPEN_REQUESTOR_UI));
            };
        }
        private function onBasketUpdate():void{
            if (this.application.state == ApplicationState.FRIEND_RANCH){
                this.view.seedCount = this.basketModel.friendBasket.receivedCount;
            } else {
                this.view.seedCount = this.basketModel.receivedCount;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view 
