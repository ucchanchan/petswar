//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import gaia.moga.dex.model.*;
    import gaia.moga.dex.assets.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;
    import gaia.lib.ui.*;
    import com.gskinner.motion.easing.*;

    public class DexUIMultiples extends Sprite {

        private var ui:Asset;
        private var self:DisplayObject;
        private var language:DexLanguageBundle;
        private var mogaRarity:TextField;
        private var mogaType:TextField;
        private var top:MovieClip;
        private var outlines:MovieClip;
        private var fills:MovieClip;
        private var close:MovieClipButton;
        private var ct:ColorTransform;
        private var tween:GTween;
        private var values:Object;
        private var sourceX:int;
        private var sourceY:int;
        private var scroll:VScrollBar;
        private var list:DexUIMultiplesList;
        private var moga:DexMoga;
        private var _selected:Signal;
        private var _closed:Signal;
        private var _addToTeam:Signal;
        private var _removeFromTeam:Signal;
        private var addToTeamButton:DexUIAddToTeamButton;
        private var _isLocked:Boolean;

        private static const DURATION:Number = 0.2;

        public function DexUIMultiples(_arg1:Asset, _arg2:DexLanguageBundle){
            this.language = _arg2;
            this.ui = _arg1;
            this.self = _arg1.self;
            addChild(this.self);
            var _local3:MovieClip = (_arg1.content as MovieClip);
            this.mogaType = _local3.mogaType;
            this.mogaRarity = _local3.rarity;
            this.scroll = new VScrollBar(_local3.knob, _local3.groove);
            this.scroll.isVisible = false;
            this.list = new DexUIMultiplesList(_local3.list);
            this.list.addToTeam.add(this.onAddToTeam);
            this.list.removeFromTeam.add(this.onRemoveFromTeam);
            this.list.selected.add(this.onListSelection);
            this.self.visible = false;
            this.self.scaleX = (this.self.scaleY = 0.01);
            this.top = _local3.top;
            this.outlines = _local3.outlines;
            this.fills = _local3.fills;
            this.close = new MovieClipButton(_local3.close);
            this.ct = new ColorTransform();
            this.tween = new GTween(this.self, DURATION, null, {ease:Quadratic.easeOut});
            this.values = {scaleX:1, scaleY:1};
            this._addToTeam = new Signal(DexMogaInstance, DexUIAddToTeamButton);
            this._removeFromTeam = new Signal(DexMogaInstance);
            this._selected = new Signal(DexMogaInstance);
            this._closed = new Signal();
        }
        public function show(_arg1:DexMoga, _arg2:int, _arg3:int):void{
            var _local5:uint;
            this.moga = _arg1;
            this.self.x = (this.sourceX = _arg2);
            this.self.y = (this.sourceY = _arg3);
            this.self.visible = true;
            this.setRarity(_arg1.rarity);
            this.list.moga = _arg1;
            _local5 = _arg1.count;
            var _local4 = (_local5 > 5);
            if (_local4){
                this.values.y = (((_arg3 + (5 * 68)) > 540)) ? (540 - (5 * 68)) : _arg3;
                this.scroll.setup(5, _local5);
                this.scroll.reposition.add(this.onReposition);
                this.scroll.isVisible = true;
                this.outlines.gotoAndStop(5);
                this.fills.gotoAndStop(5);
            } else {
                this.values.y = (((_arg3 + (_local5 * 68)) > 540)) ? (540 - (_local5 * 68)) : _arg3;
                this.scroll.isVisible = false;
                this.outlines.gotoAndStop(_local5);
                this.fills.gotoAndStop(_local5);
            };
            this.values.scaleX = 1;
            this.values.scaleY = 1;
            this.values.x = ((_arg2 > 600)) ? 600 : _arg2;
            this.tween.onComplete = null;
            this.tween.setValues(this.values);
            _local5 = _arg1.count;
            this.mogaRarity.text = this.language.getRarity(_arg1.rarity);
            this.mogaType.text = (((_arg1.genericName + " (") + _local5) + ")");
            this.close.clicked.addOnce(this.onClose);
        }
        public function get isLocked():Boolean{
            return (this._isLocked);
        }
        public function set isLocked(_arg1:Boolean):void{
            if (this._isLocked == _arg1){
                return;
            };
            this._isLocked = _arg1;
            this.list.isLocked = _arg1;
        }
        private function onReposition(_arg1:Number):void{
            this.list.position = _arg1;
        }
        public function hide():void{
            if (this.addToTeamButton){
                this.addToTeamButton.showBubble = false;
                this.addToTeamButton = null;
            };
            this.values.x = this.sourceX;
            this.values.y = this.sourceY;
            this.values.scaleX = 0.01;
            this.values.scaleY = 0.01;
            this.tween.onComplete = this.onHideComplete;
            this.tween.setValues(this.values);
        }
        private function onHideComplete(_arg1:GTween):void{
            _arg1.onComplete = null;
            this.self.visible = false;
        }
        private function onClose(_arg1:MovieClipButton):void{
            this.hide();
            this._closed.dispatch();
        }
        private function setRarity(_arg1:int):void{
            var _local2:uint = Color.fromRarity(_arg1);
            Color.setTransform(this.ct, _local2);
            this.outlines.transform.colorTransform = this.ct;
            this.top.transform.colorTransform = this.ct;
        }
        private function onAddToTeam(_arg1:DexMogaInstance, _arg2:DexUIAddToTeamButton):void{
            if (this.addToTeamButton){
                this.addToTeamButton.showBubble = false;
            };
            this.addToTeamButton = _arg2;
            this._addToTeam.dispatch(_arg1, _arg2);
        }
        private function onRemoveFromTeam(_arg1:DexMogaInstance):void{
            this._removeFromTeam.dispatch(_arg1);
        }
        private function onListSelection(_arg1:DexMogaInstance):void{
            this.hide();
            this._selected.dispatch(_arg1);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get closed():ISignal{
            return (this._closed);
        }
        public function get addToTeam():ISignal{
            return (this._addToTeam);
        }
        public function get removeFromTeam():ISignal{
            return (this._removeFromTeam);
        }

    }
}//package gaia.moga.dex.view.ui 
