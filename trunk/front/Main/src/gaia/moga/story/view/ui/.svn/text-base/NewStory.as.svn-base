//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
	import flash.display.*;
	import alecmce.ui.*;
	import org.osflash.signals.*;
	import __AS3__.vec.*;
	import com.gaiaonline.monster.view.components.app.panel.*;
	import alecmce.ui.button.*;
	//import gaia.moga.story.model.StoryAnim;
	import gaia.moga.story.model.StoryAction;
	import gaia.moga.story.model.StoryAsset;
	import gaia.moga.story.model.StoryCode;
	import gaia.moga.story.model.StoryLoader;
	import gaia.moga.story.model.StoryModel;
	import gaia.moga.story.model.WebStoryLoader;
	import gaia.moga.story.view.assets.*;
	import gaia.moga.story.view.anim.*;
	import gaia.moga.story.view.anim.StoryAnim;
	
	
	public class NewStory extends Panel {
		
		private var bundle:StoryAssetBundle;
		private var model:StoryModel;
		private var _backgroundContainer:Sprite;
		private var _characterContainer:Sprite;
		private var _bubblesContainer:Sprite;
		private var _foregroundContainer:Sprite;
		private var _skipContainer:Sprite;
		private var _background:Asset;
		private var _foreground:Asset;
		private var anim:StoryAnim;
		private var skip:MovieClipButton;
		private var hasEnded:Boolean;
		private var _complete:Signal;
		private var isPlaying:Boolean;
		
		private static const PLAYER:String = "PLAYER";
		
		public function NewStory(_arg1:StoryAssetBundle){
			this.bundle = _arg1;
			this.model = _arg1.model;
			this.hasEnded = false;
			this._complete = new Signal(NewStory);
			addChild((this._backgroundContainer = new Sprite()));
			addChild((this._characterContainer = new Sprite()));
			addChild((this._bubblesContainer = new Sprite()));
			addChild((this._foregroundContainer = new Sprite()));
			addChild((this._skipContainer = new Sprite()));
		}
		public function play():void{
			if (this.isPlaying){
				return;
			};
			this.isPlaying = true;
			this.iterate(true);
			if (this.model.canSkip){
				this.wireSkipButton();
			};
		}
		override public function dispose(_arg1:Boolean=true):void{
			super.dispose(_arg1);
			this._complete.removeAll();
			this.bundle.dispose(_arg1);
			if (this.skip){
				this.clearSkip();
			};
		}
		private function iterate(_arg1:Boolean):void{
			while (((!(this.anim)) && (!(this.hasEnded)))) {
				if (_arg1){
					this.anim = this.processAction(this.model.iterate());
				} else {
					this.anim = this.undoActions(this.model.back());
				};
			};
			if (this.hasEnded){
				this.storyComplete();
			} else {
				this.anim.complete.addOnce(this.onAsyncComplete);
				this.anim.init();
			};
		}
		//import gaia.moga.story.model.StoryAnim;
		public function onAsyncComplete(_arg1:StoryAnim):void{
			this.anim = null;
			if (!this.hasEnded){
				this.iterate(_arg1.forwards);
			};
		}
		private function processAction(_arg1:StoryAction):StoryAnim{
			var _local2:Asset;
			var _local3:StoryAnim;
			if (((_arg1.element) && (!((_arg1.element.id == PLAYER))))){
				_local2 = this.bundle.getAsset(_arg1.element.id);
			};
			switch (_arg1.code){
				case StoryCode.BACKGROUND:
					_local3 = this.processBackground(_arg1, _local2);
					break;
				case StoryCode.FOREGROUND:
					_local3 = this.processForeground(_arg1, _local2);
					break;
				case StoryCode.IN:
					_local3 = new StoryAssetInAnim(this._characterContainer, _local2);
					break;
				case StoryCode.OUT:
					_local3 = new StoryAssetOutAnim(_local2);
					break;
				case StoryCode.PLAY:
					_local3 = new StoryAssetPlayAnim(this._characterContainer, _local2);
					break;
				case StoryCode.NPC_TALK:
					_local3 = this.processNPCTalk(_arg1);
					break;
				case StoryCode.PLAYER_TALK:
					_local3 = this.processPlayerTalk(_arg1);
					break;
				case StoryCode.END:
					this.hasEnded = true;
					break;
			};
			return (_local3);
		}
		private function undoActions(_arg1:Vector.<StoryAction>):StoryAnim{
			var _local2:StoryAnimStack = new StoryAnimStack("NewStory-Stack");
			var _local3:uint = _arg1.length;
			var _local4:int;
			while (_local4 < _local3) {
				_local2.push(this.undoAction(_arg1[_local4]));
				_local4++;
			};
			return (_local2);
		}
		private function undoAction(_arg1:StoryAction):StoryAnim{
			var _local2:Asset;
			var _local3:StoryAnim;
			if (((_arg1.element) && (!((_arg1.element.id == PLAYER))))){
				_local2 = this.bundle.getAsset(_arg1.element.id);
			};
			switch (_arg1.code){
				case StoryCode.NPC_TALK:
					_local3 = this.processNPCTalk(_arg1);
					break;
				case StoryCode.PLAYER_TALK:
					_local3 = this.processPlayerTalk(_arg1);
					break;
				case StoryCode.BACKGROUND:
					if (_arg1.replacement){
						_local2 = this.bundle.getAsset(_arg1.replacement.id);
						_local3 = this.processBackground(_arg1, _local2);
					};
					break;
				case StoryCode.FOREGROUND:
					if (_arg1.replacement){
						_local2 = this.bundle.getAsset(_arg1.replacement.id);
						_local3 = this.processForeground(_arg1, _local2);
					};
					break;
				case StoryCode.IN:
					_local3 = new StoryAssetOutAnim(_local2);
					break;
				case StoryCode.OUT:
					_local3 = new StoryAssetInAnim(this._characterContainer, _local2);
					break;
			};
			return (_local3);
		}
		private function processPlayerTalk(_arg1:StoryAction):StoryAnim{
			var _local2:SpeechBubble = (this.bundle.getAsset(StoryAssetBundle.PLAYER_BUBBLE) as SpeechBubble);
			_arg1.end = ((_arg1.end) || (SpeechBubbleEnd.RIGHT_ARROW));
			return (new StoryTalk(this._bubblesContainer, _local2, _arg1));
		}
		private function processNPCTalk(_arg1:StoryAction):StoryAnim{
			var _local2:SpeechBubble = (this.bundle.getAsset(StoryAssetBundle.NPC_BUBBLE) as SpeechBubble);
			_arg1.end = ((_arg1.end) || (SpeechBubbleEnd.RIGHT_ARROW));
			return (new StoryTalk(this._bubblesContainer, _local2, _arg1));
		}
		private function processBackground(_arg1:StoryAction, _arg2:Asset):StoryAnim{
			var _local3:StoryAnim;
			if (this._background){
				_local3 = new StorySwapBackgroundAnim(this._background, _arg2);
			};
			this._backgroundContainer.addChild(_arg2.self);
			this._background = _arg2;
			return (_local3);
		}
		private function processForeground(_arg1:StoryAction, _arg2:Asset):StoryAnim{
			var _local3:StoryAnim;
			if (this._foreground){
				_local3 = new StorySwapBackgroundAnim(this._foreground, _arg2);
			};
			this._foregroundContainer.addChild(_arg2.self);
			this._foreground = _arg2;
			return (_local3);
		}
		private function storyComplete():void{
			this._complete.dispatch(this);
		}
		public function get complete():ISignal{
			return (this._complete);
		}
		private function wireSkipButton():void{
			var _local1:Asset = this.bundle.getAsset(StoryAssetBundle.SKIP);
			this.skip = new MovieClipButton((_local1.content as MovieClip).skip);
			this.skip.clicked.addOnce(this.onSkip);
			this.skip.isEnabled = true;
			this._skipContainer.addChild(_local1.self);
		}
		private function clearSkip():void{
			var _local1:Asset = this.bundle.getAsset(StoryAssetBundle.SKIP);
			if (((_local1) && ((_local1.self.parent == this._skipContainer)))){
				this._skipContainer.removeChild(_local1.self);
			};
			this.skip.clicked.removeAll();
			this.skip = null;
		}
		private function onSkip(_arg1:MovieClipButton):void{
			if (this.anim){
				this.anim.cancel();
				this.anim.complete.removeAll();
				this.anim = null;
			};
			this.skip.isEnabled = false;
			this.storyComplete();
		}
		
	}
}//package gaia.moga.story.view.ui 
