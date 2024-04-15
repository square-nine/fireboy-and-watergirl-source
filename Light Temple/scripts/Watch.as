package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="Watch")]
   public dynamic class Watch extends MovieClip
   {
       
      
      public var secs:TextField;
      
      public var mins:TextField;
      
      public var cents:TextField;
      
      public var startTime:Number;
      
      public var currentTime:Number;
      
      public var m:Number;
      
      public var s:Number;
      
      public var ms:Number;
      
      public function Watch()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
