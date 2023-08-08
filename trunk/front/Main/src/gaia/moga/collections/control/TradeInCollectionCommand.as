//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.control {
    import gaia.moga.collections.service.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.collections.event.*;
    import org.robotlegs.mvcs.*;

    public class TradeInCollectionCommand extends Command {

		[Inject]
        public var event:MogaCollectionEvent;
		[Inject]
        public var process:TradeInCollectionProcess;
		[Inject]
        public var gsi:GSIDataService;

        override public function execute():void{
            this.process.collection = this.event.collections[0];
            this.gsi.tradeInCollection(this.process);
        }

    }
}//package gaia.moga.collections.control 
