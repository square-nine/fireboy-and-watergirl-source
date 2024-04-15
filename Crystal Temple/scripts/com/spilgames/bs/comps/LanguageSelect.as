package com.spilgames.bs.comps
{
   import com.spilgames.api.SpilGamesServices;
   import com.spilgames.bs.BrandingComponentTypes;
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class LanguageSelect extends MovieClip
   {
      
      public static const DROP_DOWN_DIRECTION_UP:String = "up";
      
      public static const DROP_DOWN_DIRECTION_DOWN:String = "down";
       
      
      private var _implementation:MovieClip;
      
      private var _direction:String = "up";
      
      public function LanguageSelect()
      {
         super();
         this.initConstructor();
      }
      
      public function set direction(param1:String) : void
      {
         if(this._direction != param1)
         {
            this._direction = param1;
            if(this._implementation)
            {
               this._implementation.direction = this._direction;
            }
         }
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize();
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize();
      }
      
      public function setSize(param1:Number = 151, param2:Number = 21) : void
      {
         super.width = 151;
         super.height = 21;
         scaleX = scaleY = 1;
      }
      
      private function initConstructor() : void
      {
         if(BrandingManager.getInstance())
         {
            if(!BrandingManager.getInstance().isReady())
            {
               BrandingManager.getInstance().addEventListener(SpilGamesServices.COMPONENTS_READY,this.onComponentsReady,false,0,true);
            }
            else
            {
               this.onComponentsReady(null);
            }
         }
      }
      
      private function initialize() : void
      {
      }
      
      private function onRender(param1:Event = null) : void
      {
         removeEventListener(Event.RENDER,this.onRender);
         this.initialize();
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         addEventListener(Event.RENDER,this.onRender);
         this.initialize();
      }
      
      private function onComponentsReady(param1:Event = null) : void
      {
         if(BrandingManager.getInstance().isReady())
         {
            BrandingManager.getInstance().removeEventListener(SpilGamesServices.COMPONENTS_READY,this.onComponentsReady);
            while(numChildren)
            {
               removeChildAt(0);
            }
            this._implementation = addChild(BrandingManager.getInstance().createComponent(BrandingComponentTypes.LANGUAGE_SELECTOR) as MovieClip) as MovieClip;
            if(Boolean(this._implementation) && this._implementation.hasOwnProperty("cloneProperties"))
            {
               this._implementation["cloneProperties"](this);
            }
            visible = true;
         }
      }
   }
}
