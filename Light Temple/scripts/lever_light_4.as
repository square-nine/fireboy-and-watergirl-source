package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="lever_light_4")]
   public dynamic class lever_light_4 extends MovieClip
   {
       
      
      public function lever_light_4()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
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
