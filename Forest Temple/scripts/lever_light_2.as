package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="lever_light_2")]
   public dynamic class lever_light_2 extends MovieClip
   {
       
      
      public function lever_light_2()
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
