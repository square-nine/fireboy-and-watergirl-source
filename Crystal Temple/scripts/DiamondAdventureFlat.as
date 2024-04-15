package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="DiamondAdventureFlat")]
   public dynamic class DiamondAdventureFlat extends MovieClip
   {
       
      
      public function DiamondAdventureFlat()
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
