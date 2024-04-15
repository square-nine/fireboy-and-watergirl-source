package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="WaterGirlStairs")]
   public dynamic class WaterGirlStairs extends MovieClip
   {
       
      
      public var head:MovieClip;
      
      public function WaterGirlStairs()
      {
         super();
         addFrameScript(34,frame35);
      }
      
      internal function frame35() : *
      {
         (this.parent.parent as Game).Recuent();
         stop();
      }
   }
}
