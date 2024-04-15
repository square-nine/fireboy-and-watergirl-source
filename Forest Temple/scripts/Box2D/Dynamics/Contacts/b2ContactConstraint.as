package Box2D.Dynamics.Contacts
{
   import Box2D.Collision.b2Manifold;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.b2Body;
   
   public class b2ContactConstraint
   {
       
      
      public var points:Array;
      
      public var restitution:Number;
      
      public var body1:b2Body;
      
      public var manifold:b2Manifold;
      
      public var normal:b2Vec2;
      
      public var body2:b2Body;
      
      public var friction:Number;
      
      public var pointCount:int;
      
      public function b2ContactConstraint()
      {
         var _loc1_:int = 0;
         normal = new b2Vec2();
         super();
         points = new Array(b2Settings.b2_maxManifoldPoints);
         _loc1_ = 0;
         while(_loc1_ < b2Settings.b2_maxManifoldPoints)
         {
            points[_loc1_] = new b2ContactConstraintPoint();
            _loc1_++;
         }
      }
   }
}
