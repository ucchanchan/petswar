//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.feeds.*;
    import org.robotlegs.mvcs.*;

    public class FeedStoryMediator extends Mediator {

		[Inject]
        public var view:PublishCaptureFeedConfirm;

        override public function onRegister():void{
            this.view.confirmed.addOnce(this.onConfirm);
        }
        override public function onRemove():void{
            this.view.confirmed.removeAll();
        }
        private function onConfirm(_arg1:MonsterModel):void{
            var _local2:FeedStoryVO = new FeedStoryVO();
            _local2.name = _arg1.defaultName;
            _local2.id = _arg1.monsterID;
            _local2.newName = _arg1.name;
            _local2.instanceId = _arg1.id;
            dispatch(new PostToStreamEvent(PostToStreamEvent.CAPTURE_MONSTER, _local2));
        }

    }
}//package com.gaiaonline.monster.view 
