package CPMStar
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   
   public class AdLoader extends Sprite
   {
       
      
      private var contentspotid:String;
      
      private var cpmstarLoader:Loader;
      
      public function AdLoader(param1:String)
      {
         super();
         this.contentspotid = param1;
         addEventListener(Event.ADDED,addedHandler);
      }
      
      private function addedHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:DisplayObjectContainer = null;
         removeEventListener(Event.ADDED,addedHandler);
         Security.allowDomain("server.cpmstar.com");
         _loc2_ = "http://server.cpmstar.com/adviewas3.swf";
         _loc3_ = parent;
         cpmstarLoader = new Loader();
         cpmstarLoader.contentLoaderInfo.addEventListener(Event.INIT,dispatchHandler);
         cpmstarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,dispatchHandler);
         cpmstarLoader.load(new URLRequest(_loc2_ + "?contentspotid=" + contentspotid));
         addChild(cpmstarLoader);
      }
      
      private function dispatchHandler(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}
