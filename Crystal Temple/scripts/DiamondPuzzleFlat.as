package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="DiamondPuzzleFlat")]
   public dynamic class DiamondPuzzleFlat extends MovieClip
   {
       
      
      public function DiamondPuzzleFlat()
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
