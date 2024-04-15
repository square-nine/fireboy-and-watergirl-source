package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2TimeStep;
   
   public class b2PulleyJoint extends b2Joint
   {
      
      public static const b2_minPulleyLength:Number = 2;
       
      
      public var m_ground:b2Body;
      
      public var m_maxLength2:Number;
      
      public var m_limitForce1:Number;
      
      public var m_maxLength1:Number;
      
      public var m_limitState1:int;
      
      public var m_limitState2:int;
      
      public var m_limitPositionImpulse2:Number;
      
      public var m_force:Number;
      
      public var m_limitPositionImpulse1:Number;
      
      public var m_constant:Number;
      
      public var m_state:int;
      
      public var m_ratio:Number;
      
      public var m_groundAnchor1:b2Vec2;
      
      public var m_groundAnchor2:b2Vec2;
      
      public var m_localAnchor1:b2Vec2;
      
      public var m_localAnchor2:b2Vec2;
      
      public var m_positionImpulse:Number;
      
      public var m_limitMass2:Number;
      
      public var m_limitMass1:Number;
      
      public var m_pulleyMass:Number;
      
      public var m_u1:b2Vec2;
      
      public var m_u2:b2Vec2;
      
      public var m_limitForce2:Number;
      
      public function b2PulleyJoint(param1:b2PulleyJointDef)
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         m_groundAnchor1 = new b2Vec2();
         m_groundAnchor2 = new b2Vec2();
         m_localAnchor1 = new b2Vec2();
         m_localAnchor2 = new b2Vec2();
         m_u1 = new b2Vec2();
         m_u2 = new b2Vec2();
         super(param1);
         m_ground = m_body1.m_world.m_groundBody;
         m_groundAnchor1.x = param1.groundAnchor1.x - m_ground.m_xf.position.x;
         m_groundAnchor1.y = param1.groundAnchor1.y - m_ground.m_xf.position.y;
         m_groundAnchor2.x = param1.groundAnchor2.x - m_ground.m_xf.position.x;
         m_groundAnchor2.y = param1.groundAnchor2.y - m_ground.m_xf.position.y;
         m_localAnchor1.SetV(param1.localAnchor1);
         m_localAnchor2.SetV(param1.localAnchor2);
         m_ratio = param1.ratio;
         m_constant = param1.length1 + m_ratio * param1.length2;
         m_maxLength1 = b2Math.b2Min(param1.maxLength1,m_constant - m_ratio * b2_minPulleyLength);
         m_maxLength2 = b2Math.b2Min(param1.maxLength2,(m_constant - b2_minPulleyLength) / m_ratio);
         m_force = 0;
         m_limitForce1 = 0;
         m_limitForce2 = 0;
      }
      
      public function GetGroundAnchor2() : b2Vec2
      {
         var _loc1_:b2Vec2 = null;
         _loc1_ = m_ground.m_xf.position.Copy();
         _loc1_.Add(m_groundAnchor2);
         return _loc1_;
      }
      
      override public function GetAnchor1() : b2Vec2
      {
         return m_body1.GetWorldPoint(m_localAnchor1);
      }
      
      override public function GetAnchor2() : b2Vec2
      {
         return m_body2.GetWorldPoint(m_localAnchor2);
      }
      
      override public function GetReactionForce() : b2Vec2
      {
         var _loc1_:b2Vec2 = null;
         _loc1_ = m_u2.Copy();
         _loc1_.Multiply(m_force);
         return _loc1_;
      }
      
      override public function SolvePositionConstraints() : Boolean
      {
         var _loc1_:b2Body = null;
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
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         _loc1_ = m_body1;
         _loc2_ = m_body2;
         _loc4_ = m_ground.m_xf.position.x + m_groundAnchor1.x;
         _loc5_ = m_ground.m_xf.position.y + m_groundAnchor1.y;
         _loc6_ = m_ground.m_xf.position.x + m_groundAnchor2.x;
         _loc7_ = m_ground.m_xf.position.y + m_groundAnchor2.y;
         _loc23_ = 0;
         if(m_state == e_atUpperLimit)
         {
            _loc3_ = _loc1_.m_xf.R;
            _loc8_ = m_localAnchor1.x - _loc1_.m_sweep.localCenter.x;
            _loc9_ = m_localAnchor1.y - _loc1_.m_sweep.localCenter.y;
            _loc22_ = _loc3_.col1.x * _loc8_ + _loc3_.col2.x * _loc9_;
            _loc9_ = _loc3_.col1.y * _loc8_ + _loc3_.col2.y * _loc9_;
            _loc8_ = _loc22_;
            _loc3_ = _loc2_.m_xf.R;
            _loc10_ = m_localAnchor2.x - _loc2_.m_sweep.localCenter.x;
            _loc11_ = m_localAnchor2.y - _loc2_.m_sweep.localCenter.y;
            _loc22_ = _loc3_.col1.x * _loc10_ + _loc3_.col2.x * _loc11_;
            _loc11_ = _loc3_.col1.y * _loc10_ + _loc3_.col2.y * _loc11_;
            _loc10_ = _loc22_;
            _loc12_ = _loc1_.m_sweep.c.x + _loc8_;
            _loc13_ = _loc1_.m_sweep.c.y + _loc9_;
            _loc14_ = _loc2_.m_sweep.c.x + _loc10_;
            _loc15_ = _loc2_.m_sweep.c.y + _loc11_;
            m_u1.Set(_loc12_ - _loc4_,_loc13_ - _loc5_);
            m_u2.Set(_loc14_ - _loc6_,_loc15_ - _loc7_);
            _loc16_ = m_u1.Length();
            _loc17_ = m_u2.Length();
            if(_loc16_ > b2Settings.b2_linearSlop)
            {
               m_u1.Multiply(1 / _loc16_);
            }
            else
            {
               m_u1.SetZero();
            }
            if(_loc17_ > b2Settings.b2_linearSlop)
            {
               m_u2.Multiply(1 / _loc17_);
            }
            else
            {
               m_u2.SetZero();
            }
            _loc18_ = m_constant - _loc16_ - m_ratio * _loc17_;
            _loc23_ = b2Math.b2Max(_loc23_,-_loc18_);
            _loc18_ = b2Math.b2Clamp(_loc18_ + b2Settings.b2_linearSlop,-b2Settings.b2_maxLinearCorrection,0);
            _loc19_ = -m_pulleyMass * _loc18_;
            _loc20_ = m_positionImpulse;
            m_positionImpulse = b2Math.b2Max(0,m_positionImpulse + _loc19_);
            _loc12_ = -(_loc19_ = m_positionImpulse - _loc20_) * m_u1.x;
            _loc13_ = -_loc19_ * m_u1.y;
            _loc14_ = -m_ratio * _loc19_ * m_u2.x;
            _loc15_ = -m_ratio * _loc19_ * m_u2.y;
            _loc1_.m_sweep.c.x += _loc1_.m_invMass * _loc12_;
            _loc1_.m_sweep.c.y += _loc1_.m_invMass * _loc13_;
            _loc1_.m_sweep.a += _loc1_.m_invI * (_loc8_ * _loc13_ - _loc9_ * _loc12_);
            _loc2_.m_sweep.c.x += _loc2_.m_invMass * _loc14_;
            _loc2_.m_sweep.c.y += _loc2_.m_invMass * _loc15_;
            _loc2_.m_sweep.a += _loc2_.m_invI * (_loc10_ * _loc15_ - _loc11_ * _loc14_);
            _loc1_.SynchronizeTransform();
            _loc2_.SynchronizeTransform();
         }
         if(m_limitState1 == e_atUpperLimit)
         {
            _loc3_ = _loc1_.m_xf.R;
            _loc8_ = m_localAnchor1.x - _loc1_.m_sweep.localCenter.x;
            _loc9_ = m_localAnchor1.y - _loc1_.m_sweep.localCenter.y;
            _loc22_ = _loc3_.col1.x * _loc8_ + _loc3_.col2.x * _loc9_;
            _loc9_ = _loc3_.col1.y * _loc8_ + _loc3_.col2.y * _loc9_;
            _loc8_ = _loc22_;
            _loc12_ = _loc1_.m_sweep.c.x + _loc8_;
            _loc13_ = _loc1_.m_sweep.c.y + _loc9_;
            m_u1.Set(_loc12_ - _loc4_,_loc13_ - _loc5_);
            if((_loc16_ = m_u1.Length()) > b2Settings.b2_linearSlop)
            {
               m_u1.x *= 1 / _loc16_;
               m_u1.y *= 1 / _loc16_;
            }
            else
            {
               m_u1.SetZero();
            }
            _loc18_ = m_maxLength1 - _loc16_;
            _loc23_ = b2Math.b2Max(_loc23_,-_loc18_);
            _loc18_ = b2Math.b2Clamp(_loc18_ + b2Settings.b2_linearSlop,-b2Settings.b2_maxLinearCorrection,0);
            _loc19_ = -m_limitMass1 * _loc18_;
            _loc21_ = m_limitPositionImpulse1;
            m_limitPositionImpulse1 = b2Math.b2Max(0,m_limitPositionImpulse1 + _loc19_);
            _loc12_ = -(_loc19_ = m_limitPositionImpulse1 - _loc21_) * m_u1.x;
            _loc13_ = -_loc19_ * m_u1.y;
            _loc1_.m_sweep.c.x += _loc1_.m_invMass * _loc12_;
            _loc1_.m_sweep.c.y += _loc1_.m_invMass * _loc13_;
            _loc1_.m_sweep.a += _loc1_.m_invI * (_loc8_ * _loc13_ - _loc9_ * _loc12_);
            _loc1_.SynchronizeTransform();
         }
         if(m_limitState2 == e_atUpperLimit)
         {
            _loc3_ = _loc2_.m_xf.R;
            _loc10_ = m_localAnchor2.x - _loc2_.m_sweep.localCenter.x;
            _loc11_ = m_localAnchor2.y - _loc2_.m_sweep.localCenter.y;
            _loc22_ = _loc3_.col1.x * _loc10_ + _loc3_.col2.x * _loc11_;
            _loc11_ = _loc3_.col1.y * _loc10_ + _loc3_.col2.y * _loc11_;
            _loc10_ = _loc22_;
            _loc14_ = _loc2_.m_sweep.c.x + _loc10_;
            _loc15_ = _loc2_.m_sweep.c.y + _loc11_;
            m_u2.Set(_loc14_ - _loc6_,_loc15_ - _loc7_);
            if((_loc17_ = m_u2.Length()) > b2Settings.b2_linearSlop)
            {
               m_u2.x *= 1 / _loc17_;
               m_u2.y *= 1 / _loc17_;
            }
            else
            {
               m_u2.SetZero();
            }
            _loc18_ = m_maxLength2 - _loc17_;
            _loc23_ = b2Math.b2Max(_loc23_,-_loc18_);
            _loc18_ = b2Math.b2Clamp(_loc18_ + b2Settings.b2_linearSlop,-b2Settings.b2_maxLinearCorrection,0);
            _loc19_ = -m_limitMass2 * _loc18_;
            _loc21_ = m_limitPositionImpulse2;
            m_limitPositionImpulse2 = b2Math.b2Max(0,m_limitPositionImpulse2 + _loc19_);
            _loc14_ = -(_loc19_ = m_limitPositionImpulse2 - _loc21_) * m_u2.x;
            _loc15_ = -_loc19_ * m_u2.y;
            _loc2_.m_sweep.c.x += _loc2_.m_invMass * _loc14_;
            _loc2_.m_sweep.c.y += _loc2_.m_invMass * _loc15_;
            _loc2_.m_sweep.a += _loc2_.m_invI * (_loc10_ * _loc15_ - _loc11_ * _loc14_);
            _loc2_.SynchronizeTransform();
         }
         return _loc23_ < b2Settings.b2_linearSlop;
      }
      
      override public function InitVelocityConstraints(param1:b2TimeStep) : void
      {
         var _loc2_:b2Body = null;
         var _loc3_:b2Body = null;
         var _loc4_:b2Mat22 = null;
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
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         _loc2_ = m_body1;
         _loc3_ = m_body2;
         _loc4_ = _loc2_.m_xf.R;
         _loc5_ = m_localAnchor1.x - _loc2_.m_sweep.localCenter.x;
         _loc6_ = m_localAnchor1.y - _loc2_.m_sweep.localCenter.y;
         _loc7_ = _loc4_.col1.x * _loc5_ + _loc4_.col2.x * _loc6_;
         _loc6_ = _loc4_.col1.y * _loc5_ + _loc4_.col2.y * _loc6_;
         _loc5_ = _loc7_;
         _loc4_ = _loc3_.m_xf.R;
         _loc8_ = m_localAnchor2.x - _loc3_.m_sweep.localCenter.x;
         _loc9_ = m_localAnchor2.y - _loc3_.m_sweep.localCenter.y;
         _loc7_ = _loc4_.col1.x * _loc8_ + _loc4_.col2.x * _loc9_;
         _loc9_ = _loc4_.col1.y * _loc8_ + _loc4_.col2.y * _loc9_;
         _loc8_ = _loc7_;
         _loc10_ = _loc2_.m_sweep.c.x + _loc5_;
         _loc11_ = _loc2_.m_sweep.c.y + _loc6_;
         _loc12_ = _loc3_.m_sweep.c.x + _loc8_;
         _loc13_ = _loc3_.m_sweep.c.y + _loc9_;
         _loc14_ = m_ground.m_xf.position.x + m_groundAnchor1.x;
         _loc15_ = m_ground.m_xf.position.y + m_groundAnchor1.y;
         _loc16_ = m_ground.m_xf.position.x + m_groundAnchor2.x;
         _loc17_ = m_ground.m_xf.position.y + m_groundAnchor2.y;
         m_u1.Set(_loc10_ - _loc14_,_loc11_ - _loc15_);
         m_u2.Set(_loc12_ - _loc16_,_loc13_ - _loc17_);
         _loc18_ = m_u1.Length();
         _loc19_ = m_u2.Length();
         if(_loc18_ > b2Settings.b2_linearSlop)
         {
            m_u1.Multiply(1 / _loc18_);
         }
         else
         {
            m_u1.SetZero();
         }
         if(_loc19_ > b2Settings.b2_linearSlop)
         {
            m_u2.Multiply(1 / _loc19_);
         }
         else
         {
            m_u2.SetZero();
         }
         if((_loc20_ = m_constant - _loc18_ - m_ratio * _loc19_) > 0)
         {
            m_state = e_inactiveLimit;
            m_force = 0;
         }
         else
         {
            m_state = e_atUpperLimit;
            m_positionImpulse = 0;
         }
         if(_loc18_ < m_maxLength1)
         {
            m_limitState1 = e_inactiveLimit;
            m_limitForce1 = 0;
         }
         else
         {
            m_limitState1 = e_atUpperLimit;
            m_limitPositionImpulse1 = 0;
         }
         if(_loc19_ < m_maxLength2)
         {
            m_limitState2 = e_inactiveLimit;
            m_limitForce2 = 0;
         }
         else
         {
            m_limitState2 = e_atUpperLimit;
            m_limitPositionImpulse2 = 0;
         }
         _loc21_ = _loc5_ * m_u1.y - _loc6_ * m_u1.x;
         _loc22_ = _loc8_ * m_u2.y - _loc9_ * m_u2.x;
         m_limitMass1 = _loc2_.m_invMass + _loc2_.m_invI * _loc21_ * _loc21_;
         m_limitMass2 = _loc3_.m_invMass + _loc3_.m_invI * _loc22_ * _loc22_;
         m_pulleyMass = m_limitMass1 + m_ratio * m_ratio * m_limitMass2;
         m_limitMass1 = 1 / m_limitMass1;
         m_limitMass2 = 1 / m_limitMass2;
         m_pulleyMass = 1 / m_pulleyMass;
         if(param1.warmStarting)
         {
            _loc23_ = param1.dt * (-m_force - m_limitForce1) * m_u1.x;
            _loc24_ = param1.dt * (-m_force - m_limitForce1) * m_u1.y;
            _loc25_ = param1.dt * (-m_ratio * m_force - m_limitForce2) * m_u2.x;
            _loc26_ = param1.dt * (-m_ratio * m_force - m_limitForce2) * m_u2.y;
            _loc2_.m_linearVelocity.x += _loc2_.m_invMass * _loc23_;
            _loc2_.m_linearVelocity.y += _loc2_.m_invMass * _loc24_;
            _loc2_.m_angularVelocity += _loc2_.m_invI * (_loc5_ * _loc24_ - _loc6_ * _loc23_);
            _loc3_.m_linearVelocity.x += _loc3_.m_invMass * _loc25_;
            _loc3_.m_linearVelocity.y += _loc3_.m_invMass * _loc26_;
            _loc3_.m_angularVelocity += _loc3_.m_invI * (_loc8_ * _loc26_ - _loc9_ * _loc25_);
         }
         else
         {
            m_force = 0;
            m_limitForce1 = 0;
            m_limitForce2 = 0;
         }
      }
      
      override public function GetReactionTorque() : Number
      {
         return 0;
      }
      
      public function GetRatio() : Number
      {
         return m_ratio;
      }
      
      public function GetLength2() : Number
      {
         var _loc1_:b2Vec2 = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc1_ = m_body2.GetWorldPoint(m_localAnchor2);
         _loc2_ = m_ground.m_xf.position.x + m_groundAnchor2.x;
         _loc3_ = m_ground.m_xf.position.y + m_groundAnchor2.y;
         _loc4_ = _loc1_.x - _loc2_;
         _loc5_ = _loc1_.y - _loc3_;
         return Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_);
      }
      
      override public function SolveVelocityConstraints(param1:b2TimeStep) : void
      {
         var _loc2_:b2Body = null;
         var _loc3_:b2Body = null;
         var _loc4_:b2Mat22 = null;
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
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         _loc2_ = m_body1;
         _loc3_ = m_body2;
         _loc4_ = _loc2_.m_xf.R;
         _loc5_ = m_localAnchor1.x - _loc2_.m_sweep.localCenter.x;
         _loc6_ = m_localAnchor1.y - _loc2_.m_sweep.localCenter.y;
         _loc7_ = _loc4_.col1.x * _loc5_ + _loc4_.col2.x * _loc6_;
         _loc6_ = _loc4_.col1.y * _loc5_ + _loc4_.col2.y * _loc6_;
         _loc5_ = _loc7_;
         _loc4_ = _loc3_.m_xf.R;
         _loc8_ = m_localAnchor2.x - _loc3_.m_sweep.localCenter.x;
         _loc9_ = m_localAnchor2.y - _loc3_.m_sweep.localCenter.y;
         _loc7_ = _loc4_.col1.x * _loc8_ + _loc4_.col2.x * _loc9_;
         _loc9_ = _loc4_.col1.y * _loc8_ + _loc4_.col2.y * _loc9_;
         _loc8_ = _loc7_;
         if(m_state == e_atUpperLimit)
         {
            _loc10_ = _loc2_.m_linearVelocity.x + -_loc2_.m_angularVelocity * _loc6_;
            _loc11_ = _loc2_.m_linearVelocity.y + _loc2_.m_angularVelocity * _loc5_;
            _loc12_ = _loc3_.m_linearVelocity.x + -_loc3_.m_angularVelocity * _loc9_;
            _loc13_ = _loc3_.m_linearVelocity.y + _loc3_.m_angularVelocity * _loc8_;
            _loc18_ = -(m_u1.x * _loc10_ + m_u1.y * _loc11_) - m_ratio * (m_u2.x * _loc12_ + m_u2.y * _loc13_);
            _loc19_ = -param1.inv_dt * m_pulleyMass * _loc18_;
            _loc20_ = m_force;
            m_force = b2Math.b2Max(0,m_force + _loc19_);
            _loc19_ = m_force - _loc20_;
            _loc14_ = -param1.dt * _loc19_ * m_u1.x;
            _loc15_ = -param1.dt * _loc19_ * m_u1.y;
            _loc16_ = -param1.dt * m_ratio * _loc19_ * m_u2.x;
            _loc17_ = -param1.dt * m_ratio * _loc19_ * m_u2.y;
            _loc2_.m_linearVelocity.x += _loc2_.m_invMass * _loc14_;
            _loc2_.m_linearVelocity.y += _loc2_.m_invMass * _loc15_;
            _loc2_.m_angularVelocity += _loc2_.m_invI * (_loc5_ * _loc15_ - _loc6_ * _loc14_);
            _loc3_.m_linearVelocity.x += _loc3_.m_invMass * _loc16_;
            _loc3_.m_linearVelocity.y += _loc3_.m_invMass * _loc17_;
            _loc3_.m_angularVelocity += _loc3_.m_invI * (_loc8_ * _loc17_ - _loc9_ * _loc16_);
         }
         if(m_limitState1 == e_atUpperLimit)
         {
            _loc10_ = _loc2_.m_linearVelocity.x + -_loc2_.m_angularVelocity * _loc6_;
            _loc11_ = _loc2_.m_linearVelocity.y + _loc2_.m_angularVelocity * _loc5_;
            _loc18_ = -(m_u1.x * _loc10_ + m_u1.y * _loc11_);
            _loc19_ = -param1.inv_dt * m_limitMass1 * _loc18_;
            _loc20_ = m_limitForce1;
            m_limitForce1 = b2Math.b2Max(0,m_limitForce1 + _loc19_);
            _loc19_ = m_limitForce1 - _loc20_;
            _loc14_ = -param1.dt * _loc19_ * m_u1.x;
            _loc15_ = -param1.dt * _loc19_ * m_u1.y;
            _loc2_.m_linearVelocity.x += _loc2_.m_invMass * _loc14_;
            _loc2_.m_linearVelocity.y += _loc2_.m_invMass * _loc15_;
            _loc2_.m_angularVelocity += _loc2_.m_invI * (_loc5_ * _loc15_ - _loc6_ * _loc14_);
         }
         if(m_limitState2 == e_atUpperLimit)
         {
            _loc12_ = _loc3_.m_linearVelocity.x + -_loc3_.m_angularVelocity * _loc9_;
            _loc13_ = _loc3_.m_linearVelocity.y + _loc3_.m_angularVelocity * _loc8_;
            _loc18_ = -(m_u2.x * _loc12_ + m_u2.y * _loc13_);
            _loc19_ = -param1.inv_dt * m_limitMass2 * _loc18_;
            _loc20_ = m_limitForce2;
            m_limitForce2 = b2Math.b2Max(0,m_limitForce2 + _loc19_);
            _loc19_ = m_limitForce2 - _loc20_;
            _loc16_ = -param1.dt * _loc19_ * m_u2.x;
            _loc17_ = -param1.dt * _loc19_ * m_u2.y;
            _loc3_.m_linearVelocity.x += _loc3_.m_invMass * _loc16_;
            _loc3_.m_linearVelocity.y += _loc3_.m_invMass * _loc17_;
            _loc3_.m_angularVelocity += _loc3_.m_invI * (_loc8_ * _loc17_ - _loc9_ * _loc16_);
         }
      }
      
      public function GetLength1() : Number
      {
         var _loc1_:b2Vec2 = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc1_ = m_body1.GetWorldPoint(m_localAnchor1);
         _loc2_ = m_ground.m_xf.position.x + m_groundAnchor1.x;
         _loc3_ = m_ground.m_xf.position.y + m_groundAnchor1.y;
         _loc4_ = _loc1_.x - _loc2_;
         _loc5_ = _loc1_.y - _loc3_;
         return Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_);
      }
      
      public function GetGroundAnchor1() : b2Vec2
      {
         var _loc1_:b2Vec2 = null;
         _loc1_ = m_ground.m_xf.position.Copy();
         _loc1_.Add(m_groundAnchor1);
         return _loc1_;
      }
   }
}
