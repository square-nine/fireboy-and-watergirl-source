package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="DiamondSpeedFlat")]
   public dynamic class DiamondSpeedFlat extends MovieClip
   {
       
      
      public function DiamondSpeedFlat()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
