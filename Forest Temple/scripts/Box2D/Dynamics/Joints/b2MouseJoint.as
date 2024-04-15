package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2TimeStep;
   
   public class b2MouseJoint extends b2Joint
   {
       
      
      public var m_beta:Number;
      
      public var m_mass:b2Mat22;
      
      public var m_target:b2Vec2;
      
      public var m_impulse:b2Vec2;
      
      public var m_localAnchor:b2Vec2;
      
      private var K1:b2Mat22;
      
      private var K2:b2Mat22;
      
      private var K:b2Mat22;
      
      public var m_gamma:Number;
      
      public var m_C:b2Vec2;
      
      public var m_maxForce:Number;
      
      public function b2MouseJoint(param1:b2MouseJointDef)
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:b2Mat22 = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         K = new b2Mat22();
         K1 = new b2Mat22();
         K2 = new b2Mat22();
         m_localAnchor = new b2Vec2();
         m_target = new b2Vec2();
         m_impulse = new b2Vec2();
         m_mass = new b2Mat22();
         m_C = new b2Vec2();
         super(param1);
         m_target.SetV(param1.target);
         _loc2_ = m_target.x - m_body2.m_xf.position.x;
         _loc3_ = m_target.y - m_body2.m_xf.position.y;
         _loc4_ = m_body2.m_xf.R;
         m_localAnchor.x = _loc2_ * _loc4_.col1.x + _loc3_ * _loc4_.col1.y;
         m_localAnchor.y = _loc2_ * _loc4_.col2.x + _loc3_ * _loc4_.col2.y;
         m_maxForce = param1.maxForce;
         m_impulse.SetZero();
         _loc5_ = m_body2.m_mass;
         _loc6_ = 2 * b2Settings.b2_pi * param1.frequencyHz;
         _loc7_ = 2 * _loc5_ * param1.dampingRatio * _loc6_;
         _loc8_ = param1.timeStep * _loc5_ * (_loc6_ * _loc6_);
         m_gamma = 1 / (_loc7_ + _loc8_);
         m_beta = _loc8_ / (_loc7_ + _loc8_);
      }
      
      override public function GetAnchor1() : b2Vec2
      {
         return m_target;
      }
      
      override public function GetAnchor2() : b2Vec2
      {
         return m_body2.GetWorldPoint(m_localAnchor);
      }
      
      override public function GetReactionForce() : b2Vec2
      {
         return m_impulse;
      }
      
      override public function SolvePositionConstraints() : Boolean
      {
         return true;
      }
      
      override public function InitVelocityConstraints(param1:b2TimeStep) : void
      {
         var _loc2_:b2Body = null;
         var _loc3_:b2Mat22 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         _loc2_ = m_body2;
         _loc3_ = _loc2_.m_xf.R;
         _loc4_ = m_localAnchor.x - _loc2_.m_sweep.localCenter.x;
         _loc5_ = m_localAnchor.y - _loc2_.m_sweep.localCenter.y;
         _loc6_ = _loc3_.col1.x * _loc4_ + _loc3_.col2.x * _loc5_;
         _loc5_ = _loc3_.col1.y * _loc4_ + _loc3_.col2.y * _loc5_;
         _loc4_ = _loc6_;
         _loc7_ = _loc2_.m_invMass;
         _loc8_ = _loc2_.m_invI;
         K1.col1.x = _loc7_;
         K1.col2.x = 0;
         K1.col1.y = 0;
         K1.col2.y = _loc7_;
         K2.col1.x = _loc8_ * _loc5_ * _loc5_;
         K2.col2.x = -_loc8_ * _loc4_ * _loc5_;
         K2.col1.y = -_loc8_ * _loc4_ * _loc5_;
         K2.col2.y = _loc8_ * _loc4_ * _loc4_;
         K.SetM(K1);
         K.AddM(K2);
         K.col1.x += m_gamma;
         K.col2.y += m_gamma;
         K.Invert(m_mass);
         m_C.x = _loc2_.m_sweep.c.x + _loc4_ - m_target.x;
         m_C.y = _loc2_.m_sweep.c.y + _loc5_ - m_target.y;
         _loc2_.m_angularVelocity *= 0.98;
         _loc9_ = param1.dt * m_impulse.x;
         _loc10_ = param1.dt * m_impulse.y;
         _loc2_.m_linearVelocity.x += _loc7_ * _loc9_;
         _loc2_.m_linearVelocity.y += _loc7_ * _loc10_;
         _loc2_.m_angularVelocity += _loc8_ * (_loc4_ * _loc10_ - _loc5_ * _loc9_);
      }
      
      override public function GetReactionTorque() : Number
      {
         return 0;
      }
      
      public function SetTarget(param1:b2Vec2) : void
      {
         if(m_body2.IsSleeping())
         {
            m_body2.WakeUp();
         }
         m_target = param1;
      }
      
      override public function SolveVelocityConstraints(param1:b2TimeStep) : void
      {
         var _loc2_:b2Body = null;
         var _loc3_:b2Mat22 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         _loc2_ = m_body2;
         _loc3_ = _loc2_.m_xf.R;
         _loc6_ = m_localAnchor.x - _loc2_.m_sweep.localCenter.x;
         _loc7_ = m_localAnchor.y - _loc2_.m_sweep.localCenter.y;
         _loc4_ = _loc3_.col1.x * _loc6_ + _loc3_.col2.x * _loc7_;
         _loc7_ = _loc3_.col1.y * _loc6_ + _loc3_.col2.y * _loc7_;
         _loc6_ = _loc4_;
         _loc8_ = _loc2_.m_linearVelocity.x + -_loc2_.m_angularVelocity * _loc7_;
         _loc9_ = _loc2_.m_linearVelocity.y + _loc2_.m_angularVelocity * _loc6_;
         _loc3_ = m_mass;
         _loc4_ = _loc8_ + m_beta * param1.inv_dt * m_C.x + m_gamma * param1.dt * m_impulse.x;
         _loc5_ = _loc9_ + m_beta * param1.inv_dt * m_C.y + m_gamma * param1.dt * m_impulse.y;
         _loc10_ = -param1.inv_dt * (_loc3_.col1.x * _loc4_ + _loc3_.col2.x * _loc5_);
         _loc11_ = -param1.inv_dt * (_loc3_.col1.y * _loc4_ + _loc3_.col2.y * _loc5_);
         _loc12_ = m_impulse.x;
         _loc13_ = m_impulse.y;
         m_impulse.x += _loc10_;
         m_impulse.y += _loc11_;
         if((_loc14_ = m_impulse.Length()) > m_maxForce)
         {
            m_impulse.Multiply(m_maxForce / _loc14_);
         }
         _loc10_ = m_impulse.x - _loc12_;
         _loc11_ = m_impulse.y - _loc13_;
         _loc15_ = param1.dt * _loc10_;
         _loc16_ = param1.dt * _loc11_;
         _loc2_.m_linearVelocity.x += _loc2_.m_invMass * _loc15_;
         _loc2_.m_linearVelocity.y += _loc2_.m_invMass * _loc16_;
         _loc2_.m_angularVelocity += _loc2_.m_invI * (_loc6_ * _loc16_ - _loc7_ * _loc15_);
      }
   }
}
