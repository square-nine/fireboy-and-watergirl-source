package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   
   public class b2Manifold
   {
       
      
      public var points:Array;
      
      public var pointCount:int = 0;
      
      public var normal:b2Vec2;
      
      public function b2Manifold()
      {
         var _loc1_:int = 0;
         pointCount = 0;
         super();
         points = new Array(b2Settings.b2_maxManifoldPoints);
         _loc1_ = 0;
         while(_loc1_ < b2Settings.b2_maxManifoldPoints)
         {
            points[_loc1_] = new b2ManifoldPoint();
            _loc1_++;
         }
         normal = new b2Vec2();
      }
      
      public function Set(param1:b2Manifold) : void
      {
         var _loc2_:int = 0;
         pointCount = param1.pointCount;
         _loc2_ = 0;
         while(_loc2_ < b2Settings.b2_maxManifoldPoints)
         {
            (points[_loc2_] as b2ManifoldPoint).Set(param1.points[_loc2_]);
            _loc2_++;
         }
         normal.SetV(param1.normal);
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < b2Settings.b2_maxManifoldPoints)
         {
            (points[_loc1_] as b2ManifoldPoint).Reset();
            _loc1_++;
         }
         normal.SetZero();
         pointCount = 0;
      }
   }
}
