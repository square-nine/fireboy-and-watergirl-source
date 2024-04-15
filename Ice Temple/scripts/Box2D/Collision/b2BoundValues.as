package Box2D.Collision
{
   public class b2BoundValues
   {
       
      
      public var lowerValues:Array;
      
      public var upperValues:Array;
      
      public function b2BoundValues()
      {
         this.lowerValues = [0,0];
         this.upperValues = [0,0];
         super();
      }
   }
}
