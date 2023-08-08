//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.service {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;

    public class UpdateFriends extends GSIProcess {

		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var model:FriendsModel;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var textService:TextService;
		[Inject]
        public var dispatcher:IEventDispatcher;

        public function UpdateFriends(){
            super("UpdateFriends");
        }
        override protected function onInit():void{
            if (this.model.isInited){
                asyncComplete();
            } else {
                this.server.getFriends(this);
            };
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local2:Friend;
            var _local3:String;
            var _local4:DialogVO;
            if (_arg1.error){
                return (false);
            };
            this.model.isInited = true;
            this.model.update(_arg1.friends);
            if (this.app.defaultFriendID != ""){
                _local2 = this.model.getFriendByID(this.app.defaultFriendID);
                if (_local2 == null){
                    this.app.defaultFriendID = "";
                    this.app.friendRanchID = this.app.userID;
                    if (this.app.showBasketPanel){
                        _local3 = this.textService.getNonFriendBasketLinkDialog();
                        _local4 = new DialogVO(_local3, DialogVO.OK_ONLY);
                        this.dispatcher.dispatchEvent(new DialogEvent(DialogEvent.SHOW_DIALOG, _local4));
                    };
                };
            };
            return (true);
        }

    }
}//package gaia.moga.friendlist.service 
