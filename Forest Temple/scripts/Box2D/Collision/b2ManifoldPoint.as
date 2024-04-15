package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2ManifoldPoint
   {
       
      
      public var separation:Number;
      
      public var localPoint2:b2Vec2;
      
      public var normalImpulse:Number;
      
      public var tangentImpulse:Number;
      
      public var localPoint1:b2Vec2;
      
      public var id:b2ContactID;
      
      public function b2ManifoldPoint()
      {
         localPoint1 = new b2Vec2();
         localPoint2 = new b2Vec2();
         id = new b2ContactID();
         super();
      }
      
      public function Set(param1:b2ManifoldPoint) : void
      {
         localPoint1.SetV(param1.localPoint1);
         localPoint2.SetV(param1.localPoint2);
         separation = param1.separation;
         normalImpulse = param1.normalImpulse;
         tangentImpulse = param1.tangentImpulse;
         id.key = param1.id.key;
      }
      
      public function Reset() : void
      {
         localPoint1.SetZero();
         localPoint2.SetZero();
         separation = 0;
         normalImpulse = 0;
         tangentImpulse = 0;
         id.key = 0;
      }
   }
}
