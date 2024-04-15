package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="lever_light_6")]
   public dynamic class lever_light_6 extends MovieClip
   {
       
      
      public function lever_light_6()
      {
         super();
         addFrameScript(0,frame1,1,frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
