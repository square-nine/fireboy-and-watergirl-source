package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Dynamics.b2Body;
   
   public class b2RevoluteJointDef extends b2JointDef
   {
       
      
      public var localAnchor1:b2Vec2;
      
      public var localAnchor2:b2Vec2;
      
      public var referenceAngle:Number;
      
      public var enableLimit:Boolean;
      
      public var lowerAngle:Number;
      
      public var upperAngle:Number;
      
      public var enableMotor:Boolean;
      
      public var motorSpeed:Number;
      
      public var maxMotorTorque:Number;
      
      public function b2RevoluteJointDef()
      {
         this.localAnchor1 = new b2Vec2();
         this.localAnchor2 = new b2Vec2();
         super();
         type = b2Joint.e_revoluteJoint;
         this.localAnchor1.Set(0,0);
         this.localAnchor2.Set(0,0);
         this.referenceAngle = 0;
         this.lowerAngle = 0;
         this.upperAngle = 0;
         this.maxMotorTorque = 0;
         this.motorSpeed = 0;
         this.enableLimit = false;
         this.enableMotor = false;
      }
      
      public function Initialize(param1:b2Body, param2:b2Body, param3:b2Vec2) : void
      {
         body1 = param1;
         body2 = param2;
         this.localAnchor1 = body1.GetLocalPoint(param3);
         this.localAnchor2 = body2.GetLocalPoint(param3);
         this.referenceAngle = body2.GetAngle() - body1.GetAngle();
      }
   }
}
