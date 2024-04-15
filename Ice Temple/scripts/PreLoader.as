package
{
   import CPMStar.*;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.Timer;
   
   public class PreLoader extends Sprite
   {
       
      
      internal var loader:Loader;
      
      internal var loaderMC:LoaderMC;
      
      internal var s:*;
      
      internal var LH:*;
      
      internal var myTimer:Timer;
      
      internal var delaySecs:* = 160;
      
      public function PreLoader(param1:*)
      {
         var _loc5_:String = null;
         var _loc6_:DisplayObject = null;
         this.myTimer = new Timer(100,1000);
         super();
         this.myTimer.start();
         this.LH = new LoaderHolder();
         addChild(this.LH);
         this.loaderMC = new LoaderMC();
         this.loaderMC.x = 323;
         this.LH.addChild(this.loaderMC);
         this.loaderMC.y = 431;
         this.loaderMC.LoaderBar.scaleX = 0;
         this.tabChildren = false;
         var _loc3_:String = String(param1.loaderInfo.loaderURL);
         var _loc4_:*;
         if((_loc4_ = _loc3_.lastIndexOf("kongregate.com") > 0) == false)
         {
            _loc5_ = "6885QE35E9457";
            _loc6_ = new AdLoader(_loc5_);
            this.LH.adBox.addChild(_loc6_);
            this.LH.GameName.visible = false;
         }
         else
         {
            this.delaySecs = 2;
            this.LH.adBox.visible = false;
         }
         this.addEventListener(Event.ENTER_FRAME,this.loadProgress);
      }
      
      public function loadProgress(param1:Event) : *
      {
         var _loc2_:Number = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
         _loc2_ = Math.round(_loc2_ * 100);
         var _loc3_:* = Math.min(_loc2_,100 * this.myTimer.currentCount / this.delaySecs);
         this.loaderMC.LoaderBar.scaleX = _loc3_ / 100;
         if(_loc3_ >= 100)
         {
            this.loadComplete();
            this.removeEventListener(Event.ENTER_FRAME,this.loadProgress);
         }
      }
      
      public function loadComplete() : *
      {
         this.s = new StartBtn();
         this.s.x = this.loaderMC.x;
         this.s.y = this.loaderMC.y;
         this.s.addEventListener(MouseEvent.MOUSE_DOWN,this.StartDown);
         this.LH.removeChild(this.loaderMC);
         this.LH.addChild(this.s);
      }
      
      public function StartDown(param1:MouseEvent) : *
      {
         stage.frameRate = 25;
         this.removeChild(this.LH);
         (this.parent as Game).CreateTeaser();
      }
   }
}
