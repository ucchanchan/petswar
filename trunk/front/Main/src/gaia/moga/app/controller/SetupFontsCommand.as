//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.app.controller {
    import gaia.moga.assets.*;
    import org.robotlegs.mvcs.*;

    public class SetupFontsCommand extends Command {

		[Inject]
        public var fonts:FontFactory;

        override public function execute():void{
            this.fonts.register("assets/fonts/heygorgeous.swf");
        }

    }
}//package gaia.moga.app.controller 
