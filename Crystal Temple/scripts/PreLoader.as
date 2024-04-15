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
      
      internal var loaderMC:*;
      
      internal var s:*;
      
      internal var LH:*;
      
      internal var myTimer:Timer;
      
      internal var delaySecs:* = 120;
      
      public function PreLoader(param1:Object, param2:Boolean)
      {
         var _loc3_:String = null;
         var _loc4_:DisplayObject = null;
         this.myTimer = new Timer(100,1000);
         super();
         this.myTimer.start();
         trace("A");
         this.LH = param1["LoaderInstance"];
         this.LH.visible = true;
         trace("Loade Instance " + this.LH);
         addChild(this.LH);
         this.loaderMC = param1["LoaderMC"];
         trace("b1");
         this.loaderMC.x = 323;
         this.LH.addChild(this.loaderMC);
         this.loaderMC.y = 431;
         this.loaderMC.LoaderBar.scaleX = 0;
         trace("b2");
         this.s = param1["Startbutton"];
         this.s.visilbe = false;
         this.tabChildren = false;
         if(param2)
         {
            trace("d");
            _loc3_ = "8570Q1F3B074E";
            _loc4_ = new AdLoader(_loc3_);
            this.LH.adBox.addChild(_loc4_);
            this.LH.GameName.visible = false;
         }
         else
         {
            this.delaySecs = 2;
            this.LH.adBox.visible = false;
         }
         trace("e");
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
         this.s.visilbe = true;
         this.s.x = this.loaderMC.x;
         this.s.y = this.loaderMC.y;
         this.s.addEventListener(MouseEvent.MOUSE_DOWN,this.StartDown);
         this.LH.removeChild(this.loaderMC);
         this.LH.addChild(this.s);
      }
      
      public function StartDown(param1:MouseEvent) : *
      {
         this.removeChild(this.LH);
         (this.parent as Game).CreateTeaser();
      }
   }
}
