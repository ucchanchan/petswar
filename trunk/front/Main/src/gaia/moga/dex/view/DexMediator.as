//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import org.robotlegs.mvcs.*;

    public class DexMediator extends Mediator {

		[Inject]
        public var view:Dex;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var model:DexModel;
		[Inject]
        public var sound:SoundService;
        private var soundMap:Object;

        override public function onRegister():void{
            this.view.openShop.add(this.onOpenShop);
            this.view.closed.addOnce(this.onViewClosed);
            this.view.team = this.generateTeam();
            this.setSounds();
        }
        override public function onRemove():void{
            this.clearSounds();
            this.view.openShop.removeAll();
            this.view.closed.removeAll();
            this.view.dispose();
        }
        private function setSounds():void{
            this.soundMap = {};
            this.soundMap["DROP_IN_SLOT"] = this.sound.getFX("sounds/dex_drop_in_slot.mp3");
            this.soundMap["DROP_FAILED"] = this.sound.getFX("sounds/dex_click_invalid.mp3");
            this.soundMap["CLEAR_SLOT"] = this.sound.getFX("sounds/dex_clear_slot.mp3");
            this.soundMap["CLICK_VALID"] = this.sound.getFX("sounds/dex_click_valid.mp3");
            this.soundMap["CLICK_INVALID"] = this.sound.getFX("sounds/dex_click_invalid.mp3");
            this.view.sound.add(this.playSound);
        }
        private function playSound(_arg1:String):void{
            var _local2:SoundProxy = this.soundMap[_arg1];
            if (_local2){
                _local2.play();
            };
        }
        private function clearSounds():void{
            var _local1:SoundProxy;
            for each (_local1 in this.soundMap) {
                _local1.dispose();
            };
            this.soundMap = null;
            this.view.sound.removeAll();
        }
        private function onViewClosed():void{
            var _local1:Vector.<MonsterModel> = this.retrieveTeam();
            dispatch(new TeamEvent(TeamEvent.SET_TEAM, _local1));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, (this.view as Panel)));
        }
        private function generateTeam():Vector.<DexMogaInstance>{
            var _local5:MonsterModel;
            var _local6:DexMogaInstance;
            var _local1:Vector.<MonsterModel> = this.ranch.team.mogas;
            var _local2:uint = _local1.length;
            var _local3:Vector.<DexMogaInstance> = new Vector.<DexMogaInstance>();
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = _local1[_local4];
                if (!_local5){
                } else {
                    _local6 = this.model.getInstance(uint(_local1[_local4].id));
                    _local6.isOnTeam = true;
                    _local3.push(_local6);
                };
                _local4++;
            };
            return (_local3);
        }
        private function retrieveTeam():Vector.<MonsterModel>{
            var _local2:MonsterModel;
            var _local3:Vector.<DexMogaInstance>;
            var _local4:int;
            var _local5:Vector.<MonsterModel>;
            var _local1:Vector.<MonsterModel> = this.ranch.team.mogas;
            for each (_local2 in _local1) {
                if (_local2){
                    _local2.onTeam = 0;
                };
            };
            _local3 = this.view.team;
            _local4 = _local3.length;
            _local5 = new Vector.<MonsterModel>(_local4, true);
            while (_local4--) {
                _local5[_local4] = _local3[_local4].model;
                _local5[_local4].onTeam = (_local4 + 1);
            };
            return (_local5);
        }
        private function onOpenShop():void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
        }

    }
}//package gaia.moga.dex.view 
