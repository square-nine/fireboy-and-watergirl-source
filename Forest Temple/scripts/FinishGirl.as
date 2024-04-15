package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="FinishGirl")]
   public dynamic class FinishGirl extends MovieClip
   {
       
      
      public function FinishGirl()
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
