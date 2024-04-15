package Box2D.Collision.Shapes
{
   import Box2D.Collision.b2AABB;
   import Box2D.Collision.b2Segment;
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.Math.b2XForm;
   import Box2D.Common.b2Settings;
   
   public class b2CircleShape extends b2Shape
   {
       
      
      public var m_radius:Number;
      
      public var m_localPosition:b2Vec2;
      
      public function b2CircleShape(param1:b2ShapeDef)
      {
         var _loc2_:b2CircleDef = null;
         m_localPosition = new b2Vec2();
         super(param1);
         _loc2_ = param1 as b2CircleDef;
         m_type = e_circleShape;
         m_localPosition.SetV(_loc2_.localPosition);
         m_radius = _loc2_.radius;
      }
      
      override public function TestPoint(param1:b2XForm, param2:b2Vec2) : Boolean
      {
         var _loc3_:b2Mat22 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = param1.R;
         _loc4_ = param1.position.x + (_loc3_.col1.x * m_localPosition.x + _loc3_.col2.x * m_localPosition.y);
         _loc5_ = param1.position.y + (_loc3_.col1.y * m_localPosition.x + _loc3_.col2.y * m_localPosition.y);
         _loc4_ = param2.x - _loc4_;
         _loc5_ = param2.y - _loc5_;
         return _loc4_ * _loc4_ + _loc5_ * _loc5_ <= m_radius * m_radius;
      }
      
      public function GetLocalPosition() : b2Vec2
      {
         return m_localPosition;
      }
      
      override public function TestSegment(param1:b2XForm, param2:Array, param3:b2Vec2, param4:b2Segment, param5:Number) : Boolean
      {
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
         _loc6_ = param1.R;
         _loc7_ = param1.position.x + (_loc6_.col1.x * m_localPosition.x + _loc6_.col2.x * m_localPosition.y);
         _loc8_ = param1.position.y + (_loc6_.col1.y * m_localPosition.x + _loc6_.col2.y * m_localPosition.y);
         _loc9_ = param4.p1.x - _loc7_;
         _loc10_ = param4.p1.y - _loc8_;
         if((_loc11_ = _loc9_ * _loc9_ + _loc10_ * _loc10_ - m_radius * m_radius) < 0)
         {
            return false;
         }
         _loc12_ = param4.p2.x - param4.p1.x;
         _loc13_ = param4.p2.y - param4.p1.y;
         _loc14_ = _loc9_ * _loc12_ + _loc10_ * _loc13_;
         _loc15_ = _loc12_ * _loc12_ + _loc13_ * _loc13_;
         if((_loc16_ = _loc14_ * _loc14_ - _loc15_ * _loc11_) < 0 || _loc15_ < Number.MIN_VALUE)
         {
            return false;
         }
         _loc17_ = -(_loc14_ + Math.sqrt(_loc16_));
         if(0 <= _loc17_ && _loc17_ <= param5 * _loc15_)
         {
            _loc17_ /= _loc15_;
            param2[0] = _loc17_;
            param3.x = _loc9_ + _loc17_ * _loc12_;
            param3.y = _loc10_ + _loc17_ * _loc13_;
            param3.Normalize();
            return true;
         }
         return false;
      }
      
      override public function ComputeMass(param1:b2MassData) : void
      {
         param1.mass = m_density * b2Settings.b2_pi * m_radius * m_radius;
         param1.center.SetV(m_localPosition);
         param1.I = param1.mass * (0.5 * m_radius * m_radius + (m_localPosition.x * m_localPosition.x + m_localPosition.y * m_localPosition.y));
      }
      
      override public function ComputeSweptAABB(param1:b2AABB, param2:b2XForm, param3:b2XForm) : void
      {
         var _loc4_:b2Mat22 = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc4_ = param2.R;
         _loc5_ = param2.position.x + (_loc4_.col1.x * m_localPosition.x + _loc4_.col2.x * m_localPosition.y);
         _loc6_ = param2.position.y + (_loc4_.col1.y * m_localPosition.x + _loc4_.col2.y * m_localPosition.y);
         _loc4_ = param3.R;
         _loc7_ = param3.position.x + (_loc4_.col1.x * m_localPosition.x + _loc4_.col2.x * m_localPosition.y);
         _loc8_ = param3.position.y + (_loc4_.col1.y * m_localPosition.x + _loc4_.col2.y * m_localPosition.y);
         param1.lowerBound.Set((_loc5_ < _loc7_ ? _loc5_ : _loc7_) - m_radius,(_loc6_ < _loc8_ ? _loc6_ : _loc8_) - m_radius);
         param1.upperBound.Set((_loc5_ > _loc7_ ? _loc5_ : _loc7_) + m_radius,(_loc6_ > _loc8_ ? _loc6_ : _loc8_) + m_radius);
      }
      
      public function GetRadius() : Number
      {
         return m_radius;
      }
      
      override public function UpdateSweepRadius(param1:b2Vec2) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = m_localPosition.x - param1.x;
         _loc3_ = m_localPosition.y - param1.y;
         _loc2_ = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         m_sweepRadius = _loc2_ + m_radius - b2Settings.b2_toiSlop;
      }
      
      override public function ComputeAABB(param1:b2AABB, param2:b2XForm) : void
      {
         var _loc3_:b2Mat22 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = param2.R;
         _loc4_ = param2.position.x + (_loc3_.col1.x * m_localPosition.x + _loc3_.col2.x * m_localPosition.y);
         _loc5_ = param2.position.y + (_loc3_.col1.y * m_localPosition.x + _loc3_.col2.y * m_localPosition.y);
         param1.lowerBound.Set(_loc4_ - m_radius,_loc5_ - m_radius);
         param1.upperBound.Set(_loc4_ + m_radius,_loc5_ + m_radius);
      }
   }
}
