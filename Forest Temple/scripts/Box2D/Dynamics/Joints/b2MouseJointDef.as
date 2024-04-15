package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2MouseJointDef extends b2JointDef
   {
       
      
      public var frequencyHz:Number;
      
      public var dampingRatio:Number;
      
      public var maxForce:Number;
      
      public var target:b2Vec2;
      
      public var timeStep:Number;
      
      public function b2MouseJointDef()
      {
         target = new b2Vec2();
         super();
         type = b2Joint.e_mouseJoint;
         maxForce = 0;
         frequencyHz = 5;
         dampingRatio = 0.7;
         timeStep = 1 / 60;
      }
   }
}
