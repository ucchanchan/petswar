//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gotoshop {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class GotoShopMediator extends Mediator {

		[Inject]
        public var dialog:GotoShopDialog;

        override public function onRegister():void{
            this.dialog.response.addOnce(this.openShop);
        }
        override public function onRemove():void{
            this.dialog.response.removeAll();
        }
        private function openShop():void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
        }

    }
}//package gaia.moga.gotoshop 
