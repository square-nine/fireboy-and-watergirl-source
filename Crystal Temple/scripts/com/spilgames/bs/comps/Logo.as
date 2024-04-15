package com.spilgames.bs.comps
{
   import com.spilgames.api.SpilGamesServices;
   import com.spilgames.bs.BrandingComponentTypes;
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class Logo extends MovieClip
   {
       
      
      private var _validated:Boolean = true;
      
      private var _serverSideImplementation:*;
      
      private var _uniqueIdentifier:String = "More_Games_Button_CustomButton";
      
      public function Logo()
      {
         super();
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
      
      public function get uniqueIdentifier() : String
      {
         return this._uniqueIdentifier;
      }
      
      public function set uniqueIdentifier(param1:String) : void
      {
         if(this._uniqueIdentifier != param1)
         {
            this._uniqueIdentifier = param1;
         }
      }
      
      public function setSize(param1:Number = 202, param2:Number = 35) : void
      {
         super.width = 202;
         super.height = 35;
         scaleX = scaleY = 1;
      }
      
      private function onComponentsReady(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         if(BrandingManager.getInstance().isReady())
         {
            BrandingManager.getInstance().removeEventListener(SpilGamesServices.COMPONENTS_READY,this.onComponentsReady);
            _loc2_ = numChildren;
            while(--_loc2_ > -1)
            {
               removeChildAt(0);
            }
            this._serverSideImplementation = addChild(BrandingManager.getInstance().createComponent(BrandingComponentTypes.LOGO) as MovieClip);
            visible = true;
         }
      }
   }
}
