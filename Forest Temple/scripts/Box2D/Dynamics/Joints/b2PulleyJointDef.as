package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Dynamics.b2Body;
   
   public class b2PulleyJointDef extends b2JointDef
   {
       
      
      public var maxLength2:Number;
      
      public var length1:Number;
      
      public var length2:Number;
      
      public var maxLength1:Number;
      
      public var ratio:Number;
      
      public var groundAnchor1:b2Vec2;
      
      public var groundAnchor2:b2Vec2;
      
      public var localAnchor1:b2Vec2;
      
      public var localAnchor2:b2Vec2;
      
      public function b2PulleyJointDef()
      {
         groundAnchor1 = new b2Vec2();
         groundAnchor2 = new b2Vec2();
         localAnchor1 = new b2Vec2();
         localAnchor2 = new b2Vec2();
         super();
         type = b2Joint.e_pulleyJoint;
         groundAnchor1.Set(-1,1);
         groundAnchor2.Set(1,1);
         localAnchor1.Set(-1,0);
         localAnchor2.Set(1,0);
         length1 = 0;
         maxLength1 = 0;
         length2 = 0;
         maxLength2 = 0;
         ratio = 1;
         collideConnected = true;
      }
      
      public function Initialize(param1:b2Body, param2:b2Body, param3:b2Vec2, param4:b2Vec2, param5:b2Vec2, param6:b2Vec2, param7:Number) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         body1 = param1;
         body2 = param2;
         groundAnchor1.SetV(param3);
         groundAnchor2.SetV(param4);
         localAnchor1 = body1.GetLocalPoint(param5);
         localAnchor2 = body2.GetLocalPoint(param6);
         _loc8_ = param5.x - param3.x;
         _loc9_ = param5.y - param3.y;
         length1 = Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_);
         _loc10_ = param6.x - param4.x;
         _loc11_ = param6.y - param4.y;
         length2 = Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_);
         ratio = param7;
         _loc12_ = length1 + ratio * length2;
         maxLength1 = _loc12_ - ratio * b2PulleyJoint.b2_minPulleyLength;
         maxLength2 = (_loc12_ - b2PulleyJoint.b2_minPulleyLength) / ratio;
      }
   }
}
