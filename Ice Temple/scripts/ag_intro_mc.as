package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="ag_intro_mc")]
   public dynamic class ag_intro_mc extends MovieClip
   {
       
      
      public var LinkBtn:SimpleButton;
      
      public function ag_intro_mc()
      {
         super();
         addFrameScript(217,this.frame218);
      }
      
      internal function frame218() : *
      {
         stop();
         (this.parent as Game).TeaserOut();
      }
   }
}
