package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="MainMenu")]
   public dynamic class MainMenu extends MovieClip
   {
       
      
      public var flies:MovieClip;
      
      public var ShowLevTimes:MovieClip;
      
      public var sponsorLogoHolder:SponsorLogoHolder;
      
      public var Awarder:MovieClip;
      
      public var BackToIntro:MovieClip;
      
      public var ShowLevNum:MovieClip;
      
      public function MainMenu()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
