package com.miniclip.display
{
   import com.miniclip.logger;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class ModalTrap extends Sprite
   {
       
      
      private var _stage:Stage;
      
      private var _bgcolor:uint;
      
      private var _bgalpha:Number;
      
      private var _loaded:Boolean = false;
      
      public function ModalTrap(param1:Stage, param2:uint = 16777215, param3:Number = 0.5)
      {
         super();
         this.name = "modal_trap";
         _stage = param1;
         _bgcolor = param2;
         _bgalpha = param3;
         useHandCursor = false;
         buttonMode = false;
         tabEnabled = false;
         _draw();
         _init();
         hide();
      }
      
      private function _draw() : void
      {
         graphics.beginFill(_bgcolor,_bgalpha);
         graphics.drawRect(0,0,_stage.stageWidth,_stage.stageHeight);
         graphics.endFill();
      }
      
      private function _init() : void
      {
         if(!_loaded)
         {
            _stage.addChild(this);
            _loaded = true;
         }
      }
      
      private function _close() : void
      {
         if(_loaded)
         {
            _stage.removeChild(this);
            _loaded = false;
         }
      }
      
      private function onClick(param1:Event) : void
      {
         logger.log("ModalTrap.onClick( " + param1 + " )");
      }
      
      public function show() : void
      {
         _init();
         buttonMode = true;
         visible = true;
      }
      
      public function hide() : void
      {
         _init();
         buttonMode = false;
         visible = false;
         _close();
      }
      
      public function destroy() : void
      {
         _close();
         _stage = null;
      }
   }
}
