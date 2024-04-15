package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="FinishBoy")]
   public dynamic class FinishBoy extends MovieClip
   {
       
      
      public function FinishBoy()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
