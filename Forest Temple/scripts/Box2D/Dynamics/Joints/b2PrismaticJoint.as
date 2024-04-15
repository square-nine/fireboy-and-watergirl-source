package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2TimeStep;
   
   public class b2PrismaticJoint extends b2Joint
   {
       
      
      public var m_limitForce:Number;
      
      public var m_refAngle:Number;
      
      public var m_lowerTranslation:Number;
      
      public var m_localXAxis1:b2Vec2;
      
      public var m_torque:Number;
      
      public var m_enableLimit:Boolean;
      
      public var m_motorForce:Number;
      
      public var m_force:Number;
      
      public var m_localYAxis1:b2Vec2;
      
      public var m_motorMass:Number;
      
      public var m_maxMotorForce:Number;
      
      public var m_localAnchor1:b2Vec2;
      
      public var m_localAnchor2:b2Vec2;
      
      public var m_angularMass:Number;
      
      public var m_limitState:int;
      
      public var m_linearMass:Number;
      
      public var m_upperTranslation:Number;
      
      public var m_motorJacobian:b2Jacobian;
      
      public var m_limitPositionImpulse:Number;
      
      public var m_motorSpeed:Number;
      
      public var m_linearJacobian:b2Jacobian;
      
      public var m_enableMotor:Boolean;
      
      public function b2PrismaticJoint(param1:b2PrismaticJointDef)
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         m_localAnchor1 = new b2Vec2();
         m_localAnchor2 = new b2Vec2();
         m_localXAxis1 = new b2Vec2();
         m_localYAxis1 = new b2Vec2();
         m_linearJacobian = new b2Jacobian();
         m_motorJacobian = new b2Jacobian();
         super(param1);
         m_localAnchor1.SetV(param1.localAnchor1);
         m_localAnchor2.SetV(param1.localAnchor2);
         m_localXAxis1.SetV(param1.localAxis1);
         m_localYAxis1.x = -m_localXAxis1.y;
         m_localYAxis1.y = m_localXAxis1.x;
         m_refAngle = param1.referenceAngle;
         m_linearJacobian.SetZero();
         m_linearMass = 0;
         m_force = 0;
         m_angularMass = 0;
         m_torque = 0;
         m_motorJacobian.SetZero();
         m_motorMass = 0;
         m_motorForce = 0;
         m_limitForce = 0;
         m_limitPositionImpulse = 0;
         m_lowerTranslation = param1.lowerTranslation;
         m_upperTranslation = param1.upperTranslation;
         m_maxMotorForce = param1.maxMotorForce;
         m_motorSpeed = param1.motorSpeed;
         m_enableLimit = param1.enableLimit;
         m_enableMotor = param1.enableMotor;
      }
      
      override public function GetAnchor1() : b2Vec2
      {
         return m_body1.GetWorldPoint(m_localAnchor1);
      }
      
      override public function GetAnchor2() : b2Vec2
      {
         return m_body2.GetWorldPoint(m_localAnchor2);
      }
      
      public function EnableMotor(param1:Boolean) : void
      {
         m_enableMotor = param1;
      }
      
      public function GetUpperLimit() : Number
      {
         return m_upperTranslation;
      }
      
      public function GetLowerLimit() : Number
      {
         return m_lowerTranslation;
      }
      
      public function GetJointTranslation() : Number
      {
         var _loc1_:b2Body = null;
         var _loc2_:b2Body = null;
         var _loc4_:b2Vec2 = null;
         var _loc5_:b2Vec2 = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:b2Vec2 = null;
         var _loc9_:Number = NaN;
         _loc1_ = m_body1;
         _loc2_ = m_body2;
         _loc4_ = _loc1_.GetWorldPoint(m_localAnchor1);
         _loc6_ = (_loc5_ = _loc2_.GetWorldPoint(m_localAnchor2)).x - _loc4_.x;
         _loc7_ = _loc5_.y - _loc4_.y;
         return (_loc8_ = _loc1_.GetWorldVector(m_localXAxis1)).x * _loc6_ + _loc8_.y * _loc7_;
      }
      
      public function SetLimits(param1:Number, param2:Number) : void
      {
         m_lowerTranslation = param1;
         m_upperTranslation = param2;
      }
      
      public function GetMotorSpeed() : Number
      {
         return m_motorSpeed;
      }
      
      override public function GetReactionForce() : b2Vec2
      {
         var _loc1_:b2Mat22 = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc1_ = m_body1.m_xf.R;
         _loc2_ = m_limitForce * (_loc1_.col1.x * m_localXAxis1.x + _loc1_.col2.x * m_localXAxis1.y);
         _loc3_ = m_limitForce * (_loc1_.col1.y * m_localXAxis1.x + _loc1_.col2.y * m_localXAxis1.y);
         _loc4_ = m_force * (_loc1_.col1.x * m_localYAxis1.x + _loc1_.col2.x * m_localYAxis1.y);
         _loc5_ = m_force * (_loc1_.col1.y * m_localYAxis1.x + _loc1_.col2.y * m_localYAxis1.y);
         return new b2Vec2(m_limitForce * _loc2_ + m_force * _loc4_,m_limitForce * _loc3_ + m_force * _loc5_);
      }
      
      override public function SolvePositionConstraints() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:b2Body = null;
         var _loc4_:b2Body = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:b2Mat22 = null;
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
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         _loc3_ = m_body1;
         _loc4_ = m_body2;
         _loc5_ = _loc3_.m_invMass;
         _loc6_ = _loc4_.m_invMass;
         _loc7_ = _loc3_.m_invI;
         _loc8_ = _loc4_.m_invI;
         _loc9_ = _loc3_.m_xf.R;
         _loc11_ = m_localAnchor1.x - _loc3_.m_sweep.localCenter.x;
         _loc12_ = m_localAnchor1.y - _loc3_.m_sweep.localCenter.y;
         _loc10_ = _loc9_.col1.x * _loc11_ + _loc9_.col2.x * _loc12_;
         _loc12_ = _loc9_.col1.y * _loc11_ + _loc9_.col2.y * _loc12_;
         _loc11_ = _loc10_;
         _loc9_ = _loc4_.m_xf.R;
         _loc13_ = m_localAnchor2.x - _loc4_.m_sweep.localCenter.x;
         _loc14_ = m_localAnchor2.y - _loc4_.m_sweep.localCenter.y;
         _loc10_ = _loc9_.col1.x * _loc13_ + _loc9_.col2.x * _loc14_;
         _loc14_ = _loc9_.col1.y * _loc13_ + _loc9_.col2.y * _loc14_;
         _loc13_ = _loc10_;
         _loc15_ = _loc3_.m_sweep.c.x + _loc11_;
         _loc16_ = _loc3_.m_sweep.c.y + _loc12_;
         _loc17_ = _loc4_.m_sweep.c.x + _loc13_;
         _loc18_ = _loc4_.m_sweep.c.y + _loc14_;
         _loc19_ = _loc17_ - _loc15_;
         _loc20_ = _loc18_ - _loc16_;
         _loc21_ = (_loc9_ = _loc3_.m_xf.R).col1.x * m_localYAxis1.x + _loc9_.col2.x * m_localYAxis1.y;
         _loc22_ = _loc9_.col1.y * m_localYAxis1.x + _loc9_.col2.y * m_localYAxis1.y;
         _loc23_ = _loc21_ * _loc19_ + _loc22_ * _loc20_;
         _loc23_ = b2Math.b2Clamp(_loc23_,-b2Settings.b2_maxLinearCorrection,b2Settings.b2_maxLinearCorrection);
         _loc24_ = -m_linearMass * _loc23_;
         _loc3_.m_sweep.c.x += _loc5_ * _loc24_ * m_linearJacobian.linear1.x;
         _loc3_.m_sweep.c.y += _loc5_ * _loc24_ * m_linearJacobian.linear1.y;
         _loc3_.m_sweep.a += _loc7_ * _loc24_ * m_linearJacobian.angular1;
         _loc4_.m_sweep.c.x += _loc6_ * _loc24_ * m_linearJacobian.linear2.x;
         _loc4_.m_sweep.c.y += _loc6_ * _loc24_ * m_linearJacobian.linear2.y;
         _loc4_.m_sweep.a += _loc8_ * _loc24_ * m_linearJacobian.angular2;
         _loc25_ = b2Math.b2Abs(_loc23_);
         _loc26_ = _loc4_.m_sweep.a - _loc3_.m_sweep.a - m_refAngle;
         _loc26_ = b2Math.b2Clamp(_loc26_,-b2Settings.b2_maxAngularCorrection,b2Settings.b2_maxAngularCorrection);
         _loc27_ = -m_angularMass * _loc26_;
         _loc3_.m_sweep.a -= _loc3_.m_invI * _loc27_;
         _loc4_.m_sweep.a += _loc4_.m_invI * _loc27_;
         _loc3_.SynchronizeTransform();
         _loc4_.SynchronizeTransform();
         _loc28_ = b2Math.b2Abs(_loc26_);
         if(m_enableLimit && m_limitState != e_inactiveLimit)
         {
            _loc9_ = _loc3_.m_xf.R;
            _loc11_ = m_localAnchor1.x - _loc3_.m_sweep.localCenter.x;
            _loc12_ = m_localAnchor1.y - _loc3_.m_sweep.localCenter.y;
            _loc10_ = _loc9_.col1.x * _loc11_ + _loc9_.col2.x * _loc12_;
            _loc12_ = _loc9_.col1.y * _loc11_ + _loc9_.col2.y * _loc12_;
            _loc11_ = _loc10_;
            _loc9_ = _loc4_.m_xf.R;
            _loc13_ = m_localAnchor2.x - _loc4_.m_sweep.localCenter.x;
            _loc14_ = m_localAnchor2.y - _loc4_.m_sweep.localCenter.y;
            _loc10_ = _loc9_.col1.x * _loc13_ + _loc9_.col2.x * _loc14_;
            _loc14_ = _loc9_.col1.y * _loc13_ + _loc9_.col2.y * _loc14_;
            _loc13_ = _loc10_;
            _loc15_ = _loc3_.m_sweep.c.x + _loc11_;
            _loc16_ = _loc3_.m_sweep.c.y + _loc12_;
            _loc17_ = _loc4_.m_sweep.c.x + _loc13_;
            _loc18_ = _loc4_.m_sweep.c.y + _loc14_;
            _loc19_ = _loc17_ - _loc15_;
            _loc20_ = _loc18_ - _loc16_;
            _loc29_ = (_loc9_ = _loc3_.m_xf.R).col1.x * m_localXAxis1.x + _loc9_.col2.x * m_localXAxis1.y;
            _loc30_ = _loc9_.col1.y * m_localXAxis1.x + _loc9_.col2.y * m_localXAxis1.y;
            _loc31_ = _loc29_ * _loc19_ + _loc30_ * _loc20_;
            _loc32_ = 0;
            if(m_limitState == e_equalLimits)
            {
               _loc1_ = b2Math.b2Clamp(_loc31_,-b2Settings.b2_maxLinearCorrection,b2Settings.b2_maxLinearCorrection);
               _loc32_ = -m_motorMass * _loc1_;
               _loc25_ = b2Math.b2Max(_loc25_,b2Math.b2Abs(_loc26_));
            }
            else if(m_limitState == e_atLowerLimit)
            {
               _loc1_ = _loc31_ - m_lowerTranslation;
               _loc25_ = b2Math.b2Max(_loc25_,-_loc1_);
               _loc1_ = b2Math.b2Clamp(_loc1_ + b2Settings.b2_linearSlop,-b2Settings.b2_maxLinearCorrection,0);
               _loc32_ = -m_motorMass * _loc1_;
               _loc2_ = m_limitPositionImpulse;
               m_limitPositionImpulse = b2Math.b2Max(m_limitPositionImpulse + _loc32_,0);
               _loc32_ = m_limitPositionImpulse - _loc2_;
            }
            else if(m_limitState == e_atUpperLimit)
            {
               _loc1_ = _loc31_ - m_upperTranslation;
               _loc25_ = b2Math.b2Max(_loc25_,_loc1_);
               _loc1_ = b2Math.b2Clamp(_loc1_ - b2Settings.b2_linearSlop,0,b2Settings.b2_maxLinearCorrection);
               _loc32_ = -m_motorMass * _loc1_;
               _loc2_ = m_limitPositionImpulse;
               m_limitPositionImpulse = b2Math.b2Min(m_limitPositionImpulse + _loc32_,0);
               _loc32_ = m_limitPositionImpulse - _loc2_;
            }
            _loc3_.m_sweep.c.x += _loc5_ * _loc32_ * m_motorJacobian.linear1.x;
            _loc3_.m_sweep.c.y += _loc5_ * _loc32_ * m_motorJacobian.linear1.y;
            _loc3_.m_sweep.a += _loc7_ * _loc32_ * m_motorJacobian.angular1;
            _loc4_.m_sweep.c.x += _loc6_ * _loc32_ * m_motorJacobian.linear2.x;
            _loc4_.m_sweep.c.y += _loc6_ * _loc32_ * m_motorJacobian.linear2.y;
            _loc4_.m_sweep.a += _loc8_ * _loc32_ * m_motorJacobian.angular2;
            _loc3_.SynchronizeTransform();
            _loc4_.SynchronizeTransform();
         }
         return _loc25_ <= b2Settings.b2_linearSlop && _loc28_ <= b2Settings.b2_angularSlop;
      }
      
      public function GetJointSpeed() : Number
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
         var _loc15_:b2Vec2 = null;
         var _loc16_:b2Vec2 = null;
         var _loc17_:b2Vec2 = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         _loc1_ = m_body1;
         _loc2_ = m_body2;
         _loc3_ = _loc1_.m_xf.R;
         _loc4_ = m_localAnchor1.x - _loc1_.m_sweep.localCenter.x;
         _loc5_ = m_localAnchor1.y - _loc1_.m_sweep.localCenter.y;
         _loc6_ = _loc3_.col1.x * _loc4_ + _loc3_.col2.x * _loc5_;
         _loc5_ = _loc3_.col1.y * _loc4_ + _loc3_.col2.y * _loc5_;
         _loc4_ = _loc6_;
         _loc3_ = _loc2_.m_xf.R;
         _loc7_ = m_localAnchor2.x - _loc2_.m_sweep.localCenter.x;
         _loc8_ = m_localAnchor2.y - _loc2_.m_sweep.localCenter.y;
         _loc6_ = _loc3_.col1.x * _loc7_ + _loc3_.col2.x * _loc8_;
         _loc8_ = _loc3_.col1.y * _loc7_ + _loc3_.col2.y * _loc8_;
         _loc7_ = _loc6_;
         _loc9_ = _loc1_.m_sweep.c.x + _loc4_;
         _loc10_ = _loc1_.m_sweep.c.y + _loc5_;
         _loc11_ = _loc2_.m_sweep.c.x + _loc7_;
         _loc12_ = _loc2_.m_sweep.c.y + _loc8_;
         _loc13_ = _loc11_ - _loc9_;
         _loc14_ = _loc12_ - _loc10_;
         _loc15_ = _loc1_.GetWorldVector(m_localXAxis1);
         _loc16_ = _loc1_.m_linearVelocity;
         _loc17_ = _loc2_.m_linearVelocity;
         _loc18_ = _loc1_.m_angularVelocity;
         _loc19_ = _loc2_.m_angularVelocity;
         return _loc13_ * (-_loc18_ * _loc15_.y) + _loc14_ * (_loc18_ * _loc15_.x) + (_loc15_.x * (_loc17_.x + -_loc19_ * _loc8_ - _loc16_.x - -_loc18_ * _loc5_) + _loc15_.y * (_loc17_.y + _loc19_ * _loc7_ - _loc16_.y - _loc18_ * _loc4_));
      }
      
      public function SetMotorSpeed(param1:Number) : void
      {
         m_motorSpeed = param1;
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
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         _loc2_ = m_body1;
         _loc3_ = m_body2;
         _loc4_ = _loc2_.m_xf.R;
         _loc6_ = m_localAnchor1.x - _loc2_.m_sweep.localCenter.x;
         _loc7_ = m_localAnchor1.y - _loc2_.m_sweep.localCenter.y;
         _loc5_ = _loc4_.col1.x * _loc6_ + _loc4_.col2.x * _loc7_;
         _loc7_ = _loc4_.col1.y * _loc6_ + _loc4_.col2.y * _loc7_;
         _loc6_ = _loc5_;
         _loc4_ = _loc3_.m_xf.R;
         _loc8_ = m_localAnchor2.x - _loc3_.m_sweep.localCenter.x;
         _loc9_ = m_localAnchor2.y - _loc3_.m_sweep.localCenter.y;
         _loc5_ = _loc4_.col1.x * _loc8_ + _loc4_.col2.x * _loc9_;
         _loc9_ = _loc4_.col1.y * _loc8_ + _loc4_.col2.y * _loc9_;
         _loc8_ = _loc5_;
         _loc10_ = _loc2_.m_invMass;
         _loc11_ = _loc3_.m_invMass;
         _loc12_ = _loc2_.m_invI;
         _loc13_ = _loc3_.m_invI;
         _loc14_ = (_loc4_ = _loc2_.m_xf.R).col1.x * m_localYAxis1.x + _loc4_.col2.x * m_localYAxis1.y;
         _loc15_ = _loc4_.col1.y * m_localYAxis1.x + _loc4_.col2.y * m_localYAxis1.y;
         _loc16_ = _loc3_.m_sweep.c.x + _loc8_ - _loc2_.m_sweep.c.x;
         _loc17_ = _loc3_.m_sweep.c.y + _loc9_ - _loc2_.m_sweep.c.y;
         m_linearJacobian.linear1.x = -_loc14_;
         m_linearJacobian.linear1.y = -_loc15_;
         m_linearJacobian.linear2.x = _loc14_;
         m_linearJacobian.linear2.y = _loc15_;
         m_linearJacobian.angular1 = -(_loc16_ * _loc15_ - _loc17_ * _loc14_);
         m_linearJacobian.angular2 = _loc8_ * _loc15_ - _loc9_ * _loc14_;
         m_linearMass = _loc10_ + _loc12_ * m_linearJacobian.angular1 * m_linearJacobian.angular1 + _loc11_ + _loc13_ * m_linearJacobian.angular2 * m_linearJacobian.angular2;
         m_linearMass = 1 / m_linearMass;
         m_angularMass = _loc12_ + _loc13_;
         if(m_angularMass > Number.MIN_VALUE)
         {
            m_angularMass = 1 / m_angularMass;
         }
         if(m_enableLimit || m_enableMotor)
         {
            _loc18_ = (_loc4_ = _loc2_.m_xf.R).col1.x * m_localXAxis1.x + _loc4_.col2.x * m_localXAxis1.y;
            _loc19_ = _loc4_.col1.y * m_localXAxis1.x + _loc4_.col2.y * m_localXAxis1.y;
            m_motorJacobian.linear1.x = -_loc18_;
            m_motorJacobian.linear1.y = -_loc19_;
            m_motorJacobian.linear2.x = _loc18_;
            m_motorJacobian.linear2.y = _loc19_;
            m_motorJacobian.angular1 = -(_loc16_ * _loc19_ - _loc17_ * _loc18_);
            m_motorJacobian.angular2 = _loc8_ * _loc19_ - _loc9_ * _loc18_;
            m_motorMass = _loc10_ + _loc12_ * m_motorJacobian.angular1 * m_motorJacobian.angular1 + _loc11_ + _loc13_ * m_motorJacobian.angular2 * m_motorJacobian.angular2;
            m_motorMass = 1 / m_motorMass;
            if(m_enableLimit)
            {
               _loc20_ = _loc16_ - _loc6_;
               _loc21_ = _loc17_ - _loc7_;
               _loc22_ = _loc18_ * _loc20_ + _loc19_ * _loc21_;
               if(b2Math.b2Abs(m_upperTranslation - m_lowerTranslation) < 2 * b2Settings.b2_linearSlop)
               {
                  m_limitState = e_equalLimits;
               }
               else if(_loc22_ <= m_lowerTranslation)
               {
                  if(m_limitState != e_atLowerLimit)
                  {
                     m_limitForce = 0;
                  }
                  m_limitState = e_atLowerLimit;
               }
               else if(_loc22_ >= m_upperTranslation)
               {
                  if(m_limitState != e_atUpperLimit)
                  {
                     m_limitForce = 0;
                  }
                  m_limitState = e_atUpperLimit;
               }
               else
               {
                  m_limitState = e_inactiveLimit;
                  m_limitForce = 0;
               }
            }
         }
         if(m_enableMotor == false)
         {
            m_motorForce = 0;
         }
         if(m_enableLimit == false)
         {
            m_limitForce = 0;
         }
         if(param1.warmStarting)
         {
            _loc23_ = param1.dt * (m_force * m_linearJacobian.linear1.x + (m_motorForce + m_limitForce) * m_motorJacobian.linear1.x);
            _loc24_ = param1.dt * (m_force * m_linearJacobian.linear1.y + (m_motorForce + m_limitForce) * m_motorJacobian.linear1.y);
            _loc25_ = param1.dt * (m_force * m_linearJacobian.linear2.x + (m_motorForce + m_limitForce) * m_motorJacobian.linear2.x);
            _loc26_ = param1.dt * (m_force * m_linearJacobian.linear2.y + (m_motorForce + m_limitForce) * m_motorJacobian.linear2.y);
            _loc27_ = param1.dt * (m_force * m_linearJacobian.angular1 - m_torque + (m_motorForce + m_limitForce) * m_motorJacobian.angular1);
            _loc28_ = param1.dt * (m_force * m_linearJacobian.angular2 + m_torque + (m_motorForce + m_limitForce) * m_motorJacobian.angular2);
            _loc2_.m_linearVelocity.x += _loc10_ * _loc23_;
            _loc2_.m_linearVelocity.y += _loc10_ * _loc24_;
            _loc2_.m_angularVelocity += _loc12_ * _loc27_;
            _loc3_.m_linearVelocity.x += _loc11_ * _loc25_;
            _loc3_.m_linearVelocity.y += _loc11_ * _loc26_;
            _loc3_.m_angularVelocity += _loc13_ * _loc28_;
         }
         else
         {
            m_force = 0;
            m_torque = 0;
            m_limitForce = 0;
            m_motorForce = 0;
         }
         m_limitPositionImpulse = 0;
      }
      
      public function GetMotorForce() : Number
      {
         return m_motorForce;
      }
      
      public function SetMaxMotorForce(param1:Number) : void
      {
         m_maxMotorForce = param1;
      }
      
      public function EnableLimit(param1:Boolean) : void
      {
         m_enableLimit = param1;
      }
      
      override public function GetReactionTorque() : Number
      {
         return m_torque;
      }
      
      public function IsLimitEnabled() : Boolean
      {
         return m_enableLimit;
      }
      
      public function IsMotorEnabled() : Boolean
      {
         return m_enableMotor;
      }
      
      override public function SolveVelocityConstraints(param1:b2TimeStep) : void
      {
         var _loc2_:b2Body = null;
         var _loc3_:b2Body = null;
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
         _loc2_ = m_body1;
         _loc3_ = m_body2;
         _loc4_ = _loc2_.m_invMass;
         _loc5_ = _loc3_.m_invMass;
         _loc6_ = _loc2_.m_invI;
         _loc7_ = _loc3_.m_invI;
         _loc9_ = m_linearJacobian.Compute(_loc2_.m_linearVelocity,_loc2_.m_angularVelocity,_loc3_.m_linearVelocity,_loc3_.m_angularVelocity);
         _loc10_ = -param1.inv_dt * m_linearMass * _loc9_;
         m_force += _loc10_;
         _loc11_ = param1.dt * _loc10_;
         _loc2_.m_linearVelocity.x += _loc4_ * _loc11_ * m_linearJacobian.linear1.x;
         _loc2_.m_linearVelocity.y += _loc4_ * _loc11_ * m_linearJacobian.linear1.y;
         _loc2_.m_angularVelocity += _loc6_ * _loc11_ * m_linearJacobian.angular1;
         _loc3_.m_linearVelocity.x += _loc5_ * _loc11_ * m_linearJacobian.linear2.x;
         _loc3_.m_linearVelocity.y += _loc5_ * _loc11_ * m_linearJacobian.linear2.y;
         _loc3_.m_angularVelocity += _loc7_ * _loc11_ * m_linearJacobian.angular2;
         _loc12_ = _loc3_.m_angularVelocity - _loc2_.m_angularVelocity;
         _loc13_ = -param1.inv_dt * m_angularMass * _loc12_;
         m_torque += _loc13_;
         _loc14_ = param1.dt * _loc13_;
         _loc2_.m_angularVelocity -= _loc6_ * _loc14_;
         _loc3_.m_angularVelocity += _loc7_ * _loc14_;
         if(m_enableMotor && m_limitState != e_equalLimits)
         {
            _loc15_ = m_motorJacobian.Compute(_loc2_.m_linearVelocity,_loc2_.m_angularVelocity,_loc3_.m_linearVelocity,_loc3_.m_angularVelocity) - m_motorSpeed;
            _loc16_ = -param1.inv_dt * m_motorMass * _loc15_;
            _loc17_ = m_motorForce;
            m_motorForce = b2Math.b2Clamp(m_motorForce + _loc16_,-m_maxMotorForce,m_maxMotorForce);
            _loc16_ = m_motorForce - _loc17_;
            _loc11_ = param1.dt * _loc16_;
            _loc2_.m_linearVelocity.x += _loc4_ * _loc11_ * m_motorJacobian.linear1.x;
            _loc2_.m_linearVelocity.y += _loc4_ * _loc11_ * m_motorJacobian.linear1.y;
            _loc2_.m_angularVelocity += _loc6_ * _loc11_ * m_motorJacobian.angular1;
            _loc3_.m_linearVelocity.x += _loc5_ * _loc11_ * m_motorJacobian.linear2.x;
            _loc3_.m_linearVelocity.y += _loc5_ * _loc11_ * m_motorJacobian.linear2.y;
            _loc3_.m_angularVelocity += _loc7_ * _loc11_ * m_motorJacobian.angular2;
         }
         if(m_enableLimit && m_limitState != e_inactiveLimit)
         {
            _loc18_ = m_motorJacobian.Compute(_loc2_.m_linearVelocity,_loc2_.m_angularVelocity,_loc3_.m_linearVelocity,_loc3_.m_angularVelocity);
            _loc19_ = -param1.inv_dt * m_motorMass * _loc18_;
            if(m_limitState == e_equalLimits)
            {
               m_limitForce += _loc19_;
            }
            else if(m_limitState == e_atLowerLimit)
            {
               _loc8_ = m_limitForce;
               m_limitForce = b2Math.b2Max(m_limitForce + _loc19_,0);
               _loc19_ = m_limitForce - _loc8_;
            }
            else if(m_limitState == e_atUpperLimit)
            {
               _loc8_ = m_limitForce;
               m_limitForce = b2Math.b2Min(m_limitForce + _loc19_,0);
               _loc19_ = m_limitForce - _loc8_;
            }
            _loc11_ = param1.dt * _loc19_;
            _loc2_.m_linearVelocity.x += _loc4_ * _loc11_ * m_motorJacobian.linear1.x;
            _loc2_.m_linearVelocity.y += _loc4_ * _loc11_ * m_motorJacobian.linear1.y;
            _loc2_.m_angularVelocity += _loc6_ * _loc11_ * m_motorJacobian.angular1;
            _loc3_.m_linearVelocity.x += _loc5_ * _loc11_ * m_motorJacobian.linear2.x;
            _loc3_.m_linearVelocity.y += _loc5_ * _loc11_ * m_motorJacobian.linear2.y;
            _loc3_.m_angularVelocity += _loc7_ * _loc11_ * m_motorJacobian.angular2;
         }
      }
   }
}
