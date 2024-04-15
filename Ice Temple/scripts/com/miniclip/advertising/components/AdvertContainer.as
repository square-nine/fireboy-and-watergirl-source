package com.miniclip.advertising.components
{
   import com.miniclip.proto.ComponentBase;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   
   [Embed(source="/_assets/assets.swf", symbol="com.miniclip.advertising.components.AdvertContainer")]
   public class AdvertContainer extends ComponentBase
   {
      
      public static const ID_0:String = "g0";
      
      public static const ID_1:String = "g1";
      
      public static const ID_2:String = "g2";
      
      public static const ID_3:String = "g3";
       
      
      private const alpha_jump_per_frame:Number = 0.1;
      
      public var _id:String = "";
      
      private var advertManager:Object;
      
      private var advertManagerClass:Object;
      
      private var _viewArea_width:Number;
      
      private var _viewArea_height:Number;
      
      private var debugBG:Sprite;
      
      public function AdvertContainer(param1:String = "", param2:int = -1, param3:int = -1)
      {
         super(true,param2,param3);
         this._id = param1;
      }
      
      private function forceAddToStage() : void
      {
      }
      
      public function destroy() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this._updateShow);
         while(this.numChildren > 0)
         {
            removeChildAt(0);
         }
         if(this.advertManager)
         {
            try
            {
               this.advertManager.dismiss(this);
            }
            catch(er:Error)
            {
               trace("Error: advertManager.dismiss(this) failed" + String(er));
            }
         }
      }
      
      public function getId() : String
      {
         return this._id;
      }
      
      public function getContainer() : DisplayObjectContainer
      {
         return this as DisplayObjectContainer;
      }
      
      public function addImage(param1:DisplayObject, param2:Number = -1, param3:Number = -1) : void
      {
         this._viewArea_width = param2 > 0 ? param2 : width;
         this._viewArea_height = param3 > 0 ? param3 : height;
         var _loc4_:Number = this._viewArea_width / param1.width;
         var _loc5_:Number = this._viewArea_width / param1.height;
         var _loc6_:Number;
         if((_loc6_ = _loc4_ < _loc5_ ? _loc4_ : _loc5_) < 1)
         {
            param1.scaleX = param1.scaleY = _loc6_;
         }
         param1.x = (width - param1.width) / 2;
         param1.y = (height - param1.height) / 2;
         if(Boolean(this.debugBG) && contains(this.debugBG))
         {
            removeChild(this.debugBG);
         }
         this.addChild(param1);
         this.show();
      }
      
      private function drawBg() : void
      {
         this.drawDefaultImage();
      }
      
      private function drawDefaultImage() : void
      {
         var _loc1_:Graphics = this.debugBG.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0.5);
         _loc1_.lineStyle(1,16711680);
         _loc1_.drawRect(0,0,width,height);
         _loc1_.endFill();
         addChild(this.debugBG);
      }
      
      override public function show() : void
      {
         if(showing_complete == false)
         {
            this.alpha = 0;
            this.visible = true;
            this.addEventListener(Event.ENTER_FRAME,this._updateShow);
         }
      }
      
      override public function hide() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this._updateShow);
         this.visible = false;
         showing_complete = false;
      }
      
      private function _updateShow(param1:Event) : void
      {
         if(this.alpha < 1)
         {
            this.alpha += this.alpha_jump_per_frame;
         }
         else
         {
            showing_complete = true;
            this.alpha = 1;
            this.removeEventListener(Event.ENTER_FRAME,this._updateShow);
         }
      }
      
      override protected function INITIALIZE() : void
      {
         trace("*****************************************");
         trace(" **** ADVERT CONTAINER INITIALIZE **** ");
         trace("_id " + this._id);
         this.debugBG = new Sprite();
         try
         {
            this.advertManagerClass = getDefinitionByName("com.miniclip.gamemanager.AdvertManager");
         }
         catch(er:ReferenceError)
         {
            trace("ADVERT MANAGER CLASS NOT FOUND ");
         }
         if(this._id == "")
         {
            this._id = AdvertContainer.ID_0;
         }
         if(this.advertManagerClass)
         {
            this.advertManagerClass.getInstance.registerContainer(this);
         }
         else
         {
            this.drawDefaultImage();
         }
         this.show();
      }
   }
}
