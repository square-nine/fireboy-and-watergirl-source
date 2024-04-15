package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2TimeStep;
   
   public class b2RevoluteJoint extends b2Joint
   {
      
      public static var tImpulse:b2Vec2 = new b2Vec2();
       
      
      public var m_limitForce:Number;
      
      public var m_motorForce:Number;
      
      public var m_pivotMass:b2Mat22;
      
      public var m_enableLimit:Boolean;
      
      public var m_limitState:int;
      
      public var m_motorMass:Number;
      
      public var m_localAnchor1:b2Vec2;
      
      public var m_localAnchor2:b2Vec2;
      
      private var K1:b2Mat22;
      
      private var K2:b2Mat22;
      
      private var K3:b2Mat22;
      
      private var K:b2Mat22;
      
      public var m_pivotForce:b2Vec2;
      
      public var m_motorSpeed:Number;
      
      public var m_enableMotor:Boolean;
      
      public var m_limitPositionImpulse:Number;
      
      public var m_maxMotorTorque:Number;
      
      public var m_referenceAngle:Number;
      
      public var m_lowerAngle:Number;
      
      public var m_upperAngle:Number;
      
      public function b2RevoluteJoint(param1:b2RevoluteJointDef)
      {
         K = new b2Mat22();
         K1 = new b2Mat22();
         K2 = new b2Mat22();
         K3 = new b2Mat22();
         m_localAnchor1 = new b2Vec2();
         m_localAnchor2 = new b2Vec2();
         m_pivotForce = new b2Vec2();
         m_pivotMass = new b2Mat22();
         super(param1);
         m_localAnchor1.SetV(param1.localAnchor1);
         m_localAnchor2.SetV(param1.localAnchor2);
         m_referenceAngle = param1.referenceAngle;
         m_pivotForce.Set(0,0);
         m_motorForce = 0;
         m_limitForce = 0;
         m_limitPositionImpulse = 0;
         m_lowerAngle = param1.lowerAngle;
         m_upperAngle = param1.upperAngle;
         m_maxMotorTorque = param1.maxMotorTorque;
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
         return m_upperAngle;
      }
      
      public function GetLowerLimit() : Number
      {
         return m_lowerAngle;
      }
      
      public function SetLimits(param1:Number, param2:Number) : void
      {
         m_lowerAngle = param1;
         m_upperAngle = param2;
      }
      
      public function GetMotorSpeed() : Number
      {
         return m_motorSpeed;
      }
      
      override public function GetReactionForce() : b2Vec2
      {
         return m_pivotForce;
      }
      
      override public function SolvePositionConstraints() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:b2Body = null;
         var _loc4_:b2Body = null;
         var _loc5_:Number = NaN;
         var _loc6_:b2Mat22 = null;
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
         _loc3_ = m_body1;
         _loc4_ = m_body2;
         _loc5_ = 0;
         _loc6_ = _loc3_.m_xf.R;
         _loc7_ = m_localAnchor1.x - _loc3_.m_sweep.localCenter.x;
         _loc8_ = m_localAnchor1.y - _loc3_.m_sweep.localCenter.y;
         _loc9_ = _loc6_.col1.x * _loc7_ + _loc6_.col2.x * _loc8_;
         _loc8_ = _loc6_.col1.y * _loc7_ + _loc6_.col2.y * _loc8_;
         _loc7_ = _loc9_;
         _loc6_ = _loc4_.m_xf.R;
         _loc10_ = m_localAnchor2.x - _loc4_.m_sweep.localCenter.x;
         _loc11_ = m_localAnchor2.y - _loc4_.m_sweep.localCenter.y;
         _loc9_ = _loc6_.col1.x * _loc10_ + _loc6_.col2.x * _loc11_;
         _loc11_ = _loc6_.col1.y * _loc10_ + _loc6_.col2.y * _loc11_;
         _loc10_ = _loc9_;
         _loc12_ = _loc3_.m_sweep.c.x + _loc7_;
         _loc13_ = _loc3_.m_sweep.c.y + _loc8_;
         _loc14_ = _loc4_.m_sweep.c.x + _loc10_;
         _loc15_ = _loc4_.m_sweep.c.y + _loc11_;
         _loc16_ = _loc14_ - _loc12_;
         _loc17_ = _loc15_ - _loc13_;
         _loc5_ = Math.sqrt(_loc16_ * _loc16_ + _loc17_ * _loc17_);
         _loc18_ = _loc3_.m_invMass;
         _loc19_ = _loc4_.m_invMass;
         _loc20_ = _loc3_.m_invI;
         _loc21_ = _loc4_.m_invI;
         K1.col1.x = _loc18_ + _loc19_;
         K1.col2.x = 0;
         K1.col1.y = 0;
         K1.col2.y = _loc18_ + _loc19_;
         K2.col1.x = _loc20_ * _loc8_ * _loc8_;
         K2.col2.x = -_loc20_ * _loc7_ * _loc8_;
         K2.col1.y = -_loc20_ * _loc7_ * _loc8_;
         K2.col2.y = _loc20_ * _loc7_ * _loc7_;
         K3.col1.x = _loc21_ * _loc11_ * _loc11_;
         K3.col2.x = -_loc21_ * _loc10_ * _loc11_;
         K3.col1.y = -_loc21_ * _loc10_ * _loc11_;
         K3.col2.y = _loc21_ * _loc10_ * _loc10_;
         K.SetM(K1);
         K.AddM(K2);
         K.AddM(K3);
         K.Solve(tImpulse,-_loc16_,-_loc17_);
         _loc22_ = tImpulse.x;
         _loc23_ = tImpulse.y;
         _loc3_.m_sweep.c.x -= _loc3_.m_invMass * _loc22_;
         _loc3_.m_sweep.c.y -= _loc3_.m_invMass * _loc23_;
         _loc3_.m_sweep.a -= _loc3_.m_invI * (_loc7_ * _loc23_ - _loc8_ * _loc22_);
         _loc4_.m_sweep.c.x += _loc4_.m_invMass * _loc22_;
         _loc4_.m_sweep.c.y += _loc4_.m_invMass * _loc23_;
         _loc4_.m_sweep.a += _loc4_.m_invI * (_loc10_ * _loc23_ - _loc11_ * _loc22_);
         _loc3_.SynchronizeTransform();
         _loc4_.SynchronizeTransform();
         _loc24_ = 0;
         if(m_enableLimit && m_limitState != e_inactiveLimit)
         {
            _loc25_ = _loc4_.m_sweep.a - _loc3_.m_sweep.a - m_referenceAngle;
            _loc26_ = 0;
            if(m_limitState == e_equalLimits)
            {
               _loc2_ = b2Math.b2Clamp(_loc25_,-b2Settings.b2_maxAngularCorrection,b2Settings.b2_maxAngularCorrection);
               _loc26_ = -m_motorMass * _loc2_;
               _loc24_ = b2Math.b2Abs(_loc2_);
            }
            else if(m_limitState == e_atLowerLimit)
            {
               _loc2_ = _loc25_ - m_lowerAngle;
               _loc24_ = b2Math.b2Max(0,-_loc2_);
               _loc2_ = b2Math.b2Clamp(_loc2_ + b2Settings.b2_angularSlop,-b2Settings.b2_maxAngularCorrection,0);
               _loc26_ = -m_motorMass * _loc2_;
               _loc1_ = m_limitPositionImpulse;
               m_limitPositionImpulse = b2Math.b2Max(m_limitPositionImpulse + _loc26_,0);
               _loc26_ = m_limitPositionImpulse - _loc1_;
            }
            else if(m_limitState == e_atUpperLimit)
            {
               _loc2_ = _loc25_ - m_upperAngle;
               _loc24_ = b2Math.b2Max(0,_loc2_);
               _loc2_ = b2Math.b2Clamp(_loc2_ - b2Settings.b2_angularSlop,0,b2Settings.b2_maxAngularCorrection);
               _loc26_ = -m_motorMass * _loc2_;
               _loc1_ = m_limitPositionImpulse;
               m_limitPositionImpulse = b2Math.b2Min(m_limitPositionImpulse + _loc26_,0);
               _loc26_ = m_limitPositionImpulse - _loc1_;
            }
            _loc3_.m_sweep.a -= _loc3_.m_invI * _loc26_;
            _loc4_.m_sweep.a += _loc4_.m_invI * _loc26_;
            _loc3_.SynchronizeTransform();
            _loc4_.SynchronizeTransform();
         }
         return _loc5_ <= b2Settings.b2_linearSlop && _loc24_ <= b2Settings.b2_angularSlop;
      }
      
      public function GetJointSpeed() : Number
      {
         return m_body2.m_angularVelocity - m_body1.m_angularVelocity;
      }
      
      public function SetMotorSpeed(param1:Number) : void
      {
         m_motorSpeed = param1;
      }
      
      public function SetMaxMotorTorque(param1:Number) : void
      {
         m_maxMotorTorque = param1;
      }
      
      public function GetJointAngle() : Number
      {
         return m_body2.m_sweep.a - m_body1.m_sweep.a - m_referenceAngle;
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
         K1.col1.x = _loc10_ + _loc11_;
         K1.col2.x = 0;
         K1.col1.y = 0;
         K1.col2.y = _loc10_ + _loc11_;
         K2.col1.x = _loc12_ * _loc7_ * _loc7_;
         K2.col2.x = -_loc12_ * _loc6_ * _loc7_;
         K2.col1.y = -_loc12_ * _loc6_ * _loc7_;
         K2.col2.y = _loc12_ * _loc6_ * _loc6_;
         K3.col1.x = _loc13_ * _loc9_ * _loc9_;
         K3.col2.x = -_loc13_ * _loc8_ * _loc9_;
         K3.col1.y = -_loc13_ * _loc8_ * _loc9_;
         K3.col2.y = _loc13_ * _loc8_ * _loc8_;
         K.SetM(K1);
         K.AddM(K2);
         K.AddM(K3);
         K.Invert(m_pivotMass);
         m_motorMass = 1 / (_loc12_ + _loc13_);
         if(m_enableMotor == false)
         {
            m_motorForce = 0;
         }
         if(m_enableLimit)
         {
            _loc14_ = _loc3_.m_sweep.a - _loc2_.m_sweep.a - m_referenceAngle;
            if(b2Math.b2Abs(m_upperAngle - m_lowerAngle) < 2 * b2Settings.b2_angularSlop)
            {
               m_limitState = e_equalLimits;
            }
            else if(_loc14_ <= m_lowerAngle)
            {
               if(m_limitState != e_atLowerLimit)
               {
                  m_limitForce = 0;
               }
               m_limitState = e_atLowerLimit;
            }
            else if(_loc14_ >= m_upperAngle)
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
         else
         {
            m_limitForce = 0;
         }
         if(param1.warmStarting)
         {
            _loc2_.m_linearVelocity.x -= param1.dt * _loc10_ * m_pivotForce.x;
            _loc2_.m_linearVelocity.y -= param1.dt * _loc10_ * m_pivotForce.y;
            _loc2_.m_angularVelocity -= param1.dt * _loc12_ * (_loc6_ * m_pivotForce.y - _loc7_ * m_pivotForce.x + m_motorForce + m_limitForce);
            _loc3_.m_linearVelocity.x += param1.dt * _loc11_ * m_pivotForce.x;
            _loc3_.m_linearVelocity.y += param1.dt * _loc11_ * m_pivotForce.y;
            _loc3_.m_angularVelocity += param1.dt * _loc13_ * (_loc8_ * m_pivotForce.y - _loc9_ * m_pivotForce.x + m_motorForce + m_limitForce);
         }
         else
         {
            m_pivotForce.SetZero();
            m_motorForce = 0;
            m_limitForce = 0;
         }
         m_limitPositionImpulse = 0;
      }
      
      public function EnableLimit(param1:Boolean) : void
      {
         m_enableLimit = param1;
      }
      
      public function GetMotorTorque() : Number
      {
         return m_motorForce;
      }
      
      override public function GetReactionTorque() : Number
      {
         return m_limitForce;
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
         _loc11_ = _loc3_.m_linearVelocity.x + -_loc3_.m_angularVelocity * _loc9_ - _loc2_.m_linearVelocity.x - -_loc2_.m_angularVelocity * _loc7_;
         _loc12_ = _loc3_.m_linearVelocity.y + _loc3_.m_angularVelocity * _loc8_ - _loc2_.m_linearVelocity.y - _loc2_.m_angularVelocity * _loc6_;
         _loc13_ = -param1.inv_dt * (m_pivotMass.col1.x * _loc11_ + m_pivotMass.col2.x * _loc12_);
         _loc14_ = -param1.inv_dt * (m_pivotMass.col1.y * _loc11_ + m_pivotMass.col2.y * _loc12_);
         m_pivotForce.x += _loc13_;
         m_pivotForce.y += _loc14_;
         _loc15_ = param1.dt * _loc13_;
         _loc16_ = param1.dt * _loc14_;
         _loc2_.m_linearVelocity.x -= _loc2_.m_invMass * _loc15_;
         _loc2_.m_linearVelocity.y -= _loc2_.m_invMass * _loc16_;
         _loc2_.m_angularVelocity -= _loc2_.m_invI * (_loc6_ * _loc16_ - _loc7_ * _loc15_);
         _loc3_.m_linearVelocity.x += _loc3_.m_invMass * _loc15_;
         _loc3_.m_linearVelocity.y += _loc3_.m_invMass * _loc16_;
         _loc3_.m_angularVelocity += _loc3_.m_invI * (_loc8_ * _loc16_ - _loc9_ * _loc15_);
         if(m_enableMotor && m_limitState != e_equalLimits)
         {
            _loc17_ = _loc3_.m_angularVelocity - _loc2_.m_angularVelocity - m_motorSpeed;
            _loc18_ = -param1.inv_dt * m_motorMass * _loc17_;
            _loc19_ = m_motorForce;
            m_motorForce = b2Math.b2Clamp(m_motorForce + _loc18_,-m_maxMotorTorque,m_maxMotorTorque);
            _loc18_ = m_motorForce - _loc19_;
            _loc2_.m_angularVelocity -= _loc2_.m_invI * param1.dt * _loc18_;
            _loc3_.m_angularVelocity += _loc3_.m_invI * param1.dt * _loc18_;
         }
         if(m_enableLimit && m_limitState != e_inactiveLimit)
         {
            _loc20_ = _loc3_.m_angularVelocity - _loc2_.m_angularVelocity;
            _loc21_ = -param1.inv_dt * m_motorMass * _loc20_;
            if(m_limitState == e_equalLimits)
            {
               m_limitForce += _loc21_;
            }
            else if(m_limitState == e_atLowerLimit)
            {
               _loc10_ = m_limitForce;
               m_limitForce = b2Math.b2Max(m_limitForce + _loc21_,0);
               _loc21_ = m_limitForce - _loc10_;
            }
            else if(m_limitState == e_atUpperLimit)
            {
               _loc10_ = m_limitForce;
               m_limitForce = b2Math.b2Min(m_limitForce + _loc21_,0);
               _loc21_ = m_limitForce - _loc10_;
            }
            _loc2_.m_angularVelocity -= _loc2_.m_invI * param1.dt * _loc21_;
            _loc3_.m_angularVelocity += _loc3_.m_invI * param1.dt * _loc21_;
         }
      }
   }
}
