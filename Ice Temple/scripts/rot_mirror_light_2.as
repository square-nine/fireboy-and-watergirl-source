package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="rot_mirror_light_2")]
   public dynamic class rot_mirror_light_2 extends MovieClip
   {
       
      
      public function rot_mirror_light_2()
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
