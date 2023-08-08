//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.smallteam.anim {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.smallteam.*;

    public class NPCTeam extends SmallTeam {

        private var _container:MovieClip;
        private var _npc:Asset;

        public function NPCTeam(_arg1:Asset){
            super(_arg1);
            this._container = MovieClip(_ui.content).container;
        }
        public function set npc(_arg1:Asset):void{
            if (this._npc == _arg1){
                return;
            };
            if (this._npc){
                this._container.removeChild(this._npc.self);
            };
            this._npc = _arg1;
            if (this._npc){
                this._container.addChild(this._npc.self);
            };
        }
        public function get npc():Asset{
            return (this._npc);
        }

    }
}//package com.gaiaonline.monster.view.components.smallteam.anim 
