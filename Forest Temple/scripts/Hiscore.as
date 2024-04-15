package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="Hiscore")]
   public dynamic class Hiscore extends MovieClip
   {
       
      
      public var HS:MovieClip;
      
      public var points_txt:TextField;
      
      public var Reset:MovieClip;
      
      public var ViewHS:SimpleButton;
      
      public var NoHS:MovieClip;
      
      public var BackBTN:SimpleButton;
      
      public function Hiscore()
      {
         super();
      }
   }
}
