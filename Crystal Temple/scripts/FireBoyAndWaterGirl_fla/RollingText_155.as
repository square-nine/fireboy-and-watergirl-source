package FireBoyAndWaterGirl_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.RollingText_155")]
   public dynamic class RollingText_155 extends MovieClip
   {
       
      
      public var P1:Portal;
      
      public function RollingText_155()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this.cacheAsBitmap = true;
      }
   }
}
