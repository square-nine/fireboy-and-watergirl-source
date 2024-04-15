package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2AABB
   {
       
      
      public var upperBound:b2Vec2;
      
      public var lowerBound:b2Vec2;
      
      public function b2AABB()
      {
         lowerBound = new b2Vec2();
         upperBound = new b2Vec2();
         super();
      }
      
      public function IsValid() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         _loc1_ = upperBound.x - lowerBound.x;
         _loc2_ = upperBound.y - lowerBound.y;
         _loc3_ = _loc1_ >= 0 && _loc2_ >= 0;
         return _loc3_ && lowerBound.IsValid() && upperBound.IsValid();
      }
   }
}
