package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="rot_mirror_light_5")]
   public dynamic class rot_mirror_light_5 extends MovieClip
   {
       
      
      public function rot_mirror_light_5()
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
