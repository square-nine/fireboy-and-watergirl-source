package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Dynamics.b2Body;
   
   public class b2PulleyJointDef extends b2JointDef
   {
       
      
      public var groundAnchor1:b2Vec2;
      
      public var groundAnchor2:b2Vec2;
      
      public var localAnchor1:b2Vec2;
      
      public var localAnchor2:b2Vec2;
      
      public var length1:Number;
      
      public var maxLength1:Number;
      
      public var length2:Number;
      
      public var maxLength2:Number;
      
      public var ratio:Number;
      
      public function b2PulleyJointDef()
      {
         this.groundAnchor1 = new b2Vec2();
         this.groundAnchor2 = new b2Vec2();
         this.localAnchor1 = new b2Vec2();
         this.localAnchor2 = new b2Vec2();
         super();
         type = b2Joint.e_pulleyJoint;
         this.groundAnchor1.Set(-1,1);
         this.groundAnchor2.Set(1,1);
         this.localAnchor1.Set(-1,0);
         this.localAnchor2.Set(1,0);
         this.length1 = 0;
         this.maxLength1 = 0;
         this.length2 = 0;
         this.maxLength2 = 0;
         this.ratio = 1;
         collideConnected = true;
      }
      
      public function Initialize(param1:b2Body, param2:b2Body, param3:b2Vec2, param4:b2Vec2, param5:b2Vec2, param6:b2Vec2, param7:Number) : void
      {
         body1 = param1;
         body2 = param2;
         this.groundAnchor1.SetV(param3);
         this.groundAnchor2.SetV(param4);
         this.localAnchor1 = body1.GetLocalPoint(param5);
         this.localAnchor2 = body2.GetLocalPoint(param6);
         var _loc8_:Number = param5.x - param3.x;
         var _loc9_:Number = param5.y - param3.y;
         this.length1 = Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_);
         var _loc10_:Number = param6.x - param4.x;
         var _loc11_:Number = param6.y - param4.y;
         this.length2 = Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_);
         this.ratio = param7;
         var _loc12_:Number = this.length1 + this.ratio * this.length2;
         this.maxLength1 = _loc12_ - this.ratio * b2PulleyJoint.b2_minPulleyLength;
         this.maxLength2 = (_loc12_ - b2PulleyJoint.b2_minPulleyLength) / this.ratio;
      }
   }
}
