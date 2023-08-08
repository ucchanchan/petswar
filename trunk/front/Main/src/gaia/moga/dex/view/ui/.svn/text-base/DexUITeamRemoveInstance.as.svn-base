//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
	import com.gskinner.motion.*;
	import __AS3__.vec.*;
	import alecmce.async.*;
	import gaia.moga.dex.model.*;
	
	public class DexUITeamRemoveInstance extends AsyncBase {
		
		private var team:DexUITeam;
		private var removed:DexMogaInstance;
		public var proportion:Number;// = 0
		private var moves:Vector.<MoveVO>;
		private var shifts:Vector.<ShiftVO>;
		private var removedItem:DexUITeamItem;
		private var removedX:Number;
		
		private static const IN_AND_OUT:Number = 0.15;
		private static const SLIDE:Number = 0.3;
		
		public function DexUITeamRemoveInstance(_arg1:DexUITeam, _arg2:DexMogaInstance){
			this.team = _arg1;
			this.removed = _arg2;
		}
		override protected function onInit():void{
			var _local6:GTween;
			var _local7:GTween;
			var _local8:GTween;
			var _local9:DexUITeamItem;
			var _local1:int = this.team.team.indexOf(this.removed);
			var _local2:Vector.<DexUITeamItem> = this.team.items;
			var _local3:uint = _local2.length;
			var _local4:uint = _local1;
			this.moves = new Vector.<MoveVO>();
			this.shifts = new Vector.<ShiftVO>();
			var _local5:int = (_local1 + 1);
			while (_local5 < _local3) {
				_local9 = _local2[_local5];
				if (_local9.moga == null){
				} else {
					_local4 = _local5;
					this.shifts.push(new ShiftVO(_local5, (_local5 - 1)));
					this.moves.push(new MoveVO(_local9, _local2[_local5].ui.x, _local2[(_local5 - 1)].ui.x));
				};
				_local5++;
			};
			this.shifts.push(new ShiftVO(_local1, _local4));
			this.removedItem = _local2[_local1];
			this.removedX = _local2[_local4].ui.x;
			_local6 = new GTween(this.removedItem.ui, IN_AND_OUT, {scaleX:0.001, scaleY:0.001}, {onComplete:this.onExitComplete});
			_local7 = new GTween(this, SLIDE, {proportion:1}, {onChange:this.onChange, onComplete:this.onSlideComplete});
			_local8 = new GTween(this.removedItem.ui, IN_AND_OUT, {scaleX:1, scaleY:1}, {onComplete:this.onEnterComplete});
			_local7.paused = true;
			_local8.paused = true;
			_local6.nextTween = _local7;
			_local7.nextTween = _local8;
		}
		private function onExitComplete(_arg1:GTween):void{
			this.removedItem.ui.visible = false;
		}
		private function onChange(_arg1:GTween):void{
			var _local3:MoveVO;
			var _local2:int = this.moves.length;
			while (_local2--) {
				_local3 = this.moves[_local2];
				_local3.item.ui.x = (_local3.fromPosition + (_local3.dPosition * this.proportion));
			};
		}
		private function onSlideComplete(_arg1:GTween):void{
			var _local8:ShiftVO;
			var _local2:Vector.<DexUITeamItem> = this.team.items;
			var _local3:Vector.<DexUITeamItem> = _local2.concat();
			var _local4:Vector.<DexMogaInstance> = this.team.team;
			var _local5:Vector.<DexMogaInstance> = _local4.concat();
			var _local6:uint = _local4.length;
			var _local7:int = this.shifts.length;
			while (_local7--) {
				_local8 = this.shifts[_local7];
				_local2[_local8.target] = _local3[_local8.from];
				_local4[_local8.target] = ((_local8.from < _local6)) ? _local5[_local8.from] : null;
			};
			_local4.length = (_local6 - 1);
			this.removedItem.ui.visible = true;
			this.removedItem.ui.x = this.removedX;
		}
		private function onEnterComplete(_arg1:GTween):void{
			asyncComplete();
		}
		
	}
}//package gaia.moga.dex.view.ui 
import gaia.moga.dex.view.ui.DexUITeamItem;
final class MoveVO {
	
	public var item:DexUITeamItem;
	public var fromPosition:Number;
	public var dPosition:Number;
	
	public function MoveVO(_arg1:DexUITeamItem, _arg2:Number, _arg3:Number){
		this.item = _arg1;
		this.fromPosition = _arg2;
		this.dPosition = (_arg3 - _arg2);
	}
}
final class ShiftVO {
	
	public var from:uint;
	public var target:uint;
	
	public function ShiftVO(_arg1:uint, _arg2:uint){
		this.from = _arg1;
		this.target = _arg2;
	}
}
