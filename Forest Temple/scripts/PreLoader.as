package
{
   import CPMStar.*;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.ui.*;
   
   public class PreLoader extends Sprite
   {
       
      
      internal var loader:Loader;
      
      internal var LH:*;
      
      internal var s:*;
      
      internal var loaderMC:LoaderMC;
      
      public function PreLoader(param1:*)
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc6_:DisplayObject = null;
         super();
         LH = new LoaderHolder();
         addChild(LH);
         loaderMC = new LoaderMC();
         loaderMC.x = 323;
         LH.addChild(loaderMC);
         loaderMC.y = 431;
         loaderMC.LoaderBar.scaleX = 0;
         this.tabChildren = false;
         _loc2_ = "kongregate.com";
         _loc3_ = String(param1.loaderInfo.loaderURL);
         _loc4_ = _loc3_.lastIndexOf(_loc2_) > 0;
         trace("1.- " + _loc3_ + " -so- " + _loc4_);
         this.addEventListener(Event.ENTER_FRAME,loadProgress);
         if(_loc4_ == false)
         {
            _loc5_ = "1133Q475133EF";
            _loc6_ = new AdLoader(_loc5_);
            LH.adBox.addChild(_loc6_);
         }
         else
         {
            LH.adBox.visible = false;
            LH.title.y += 200;
         }
      }
      
      public function StartDown(param1:MouseEvent) : *
      {
         stage.frameRate = 25;
         this.removeChild(LH);
         (this.parent as Game).CreateTeaser();
      }
      
      public function loadComplete() : *
      {
         s = new StartBtn();
         s.x = loaderMC.x;
         s.y = loaderMC.y;
         s.addEventListener(MouseEvent.MOUSE_DOWN,StartDown);
         LH.removeChild(loaderMC);
         LH.addChild(s);
      }
      
      public function loadProgress(param1:Event) : *
      {
         var _loc2_:Number = NaN;
         _loc2_ = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
         _loc2_ = Math.round(_loc2_ * 100);
         loaderMC.LoaderBar.scaleX = _loc2_ / 100;
         if(stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal)
         {
            loadComplete();
            this.removeEventListener(Event.ENTER_FRAME,loadProgress);
         }
      }
   }
}
