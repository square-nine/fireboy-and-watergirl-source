package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="Watch")]
   public dynamic class Watch extends MovieClip
   {
       
      
      public var m:Number;
      
      public var mins:TextField;
      
      public var startTime:Number;
      
      public var secs:TextField;
      
      public var s:Number;
      
      public var ms:Number;
      
      public var cents:TextField;
      
      public var currentTime:Number;
      
      public function Watch()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
