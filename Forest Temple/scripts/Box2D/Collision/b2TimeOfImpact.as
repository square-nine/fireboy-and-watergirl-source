package Box2D.Collision
{
   import Box2D.Collision.Shapes.b2Shape;
   import Box2D.Common.Math.b2Sweep;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.Math.b2XForm;
   import Box2D.Common.b2Settings;
   
   public class b2TimeOfImpact
   {
      
      public static var s_xf1:b2XForm = new b2XForm();
      
      public static var s_xf2:b2XForm = new b2XForm();
      
      public static var s_p1:b2Vec2 = new b2Vec2();
      
      public static var s_p2:b2Vec2 = new b2Vec2();
       
      
      public function b2TimeOfImpact()
      {
         super();
      }
      
      public static function TimeOfImpact(param1:b2Shape, param2:b2Sweep, param3:b2Shape, param4:b2Sweep) : Number
      {
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
         var _loc17_:b2Vec2 = null;
         var _loc18_:b2Vec2 = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:b2XForm = null;
         var _loc27_:b2XForm = null;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         _loc7_ = param1.m_sweepRadius;
         _loc8_ = param3.m_sweepRadius;
         _loc9_ = param2.t0;
         _loc10_ = param2.c.x - param2.c0.x;
         _loc11_ = param2.c.y - param2.c0.y;
         _loc12_ = param4.c.x - param4.c0.x;
         _loc13_ = param4.c.y - param4.c0.y;
         _loc14_ = param2.a - param2.a0;
         _loc15_ = param4.a - param4.a0;
         _loc16_ = 0;
         _loc17_ = s_p1;
         _loc18_ = s_p2;
         _loc19_ = 20;
         _loc20_ = 0;
         _loc21_ = 0;
         _loc22_ = 0;
         _loc23_ = 0;
         _loc24_ = 0;
         while(true)
         {
            _loc25_ = (1 - _loc16_) * _loc9_ + _loc16_;
            _loc26_ = s_xf1;
            _loc27_ = s_xf2;
            param2.GetXForm(_loc26_,_loc25_);
            param4.GetXForm(_loc27_,_loc25_);
            _loc23_ = b2Distance.Distance(_loc17_,_loc18_,param1,_loc26_,param3,_loc27_);
            if(_loc20_ == 0)
            {
               if(_loc23_ > 2 * b2Settings.b2_toiSlop)
               {
                  _loc24_ = 1.5 * b2Settings.b2_toiSlop;
               }
               else
               {
                  _loc5_ = 0.05 * b2Settings.b2_toiSlop;
                  _loc6_ = _loc23_ - 0.5 * b2Settings.b2_toiSlop;
                  _loc24_ = _loc5_ > _loc6_ ? _loc5_ : _loc6_;
               }
            }
            if(_loc23_ - _loc24_ < 0.05 * b2Settings.b2_toiSlop || _loc20_ == _loc19_)
            {
               break;
            }
            _loc21_ = _loc18_.x - _loc17_.x;
            _loc22_ = _loc18_.y - _loc17_.y;
            _loc28_ = Math.sqrt(_loc21_ * _loc21_ + _loc22_ * _loc22_);
            _loc21_ /= _loc28_;
            _loc22_ /= _loc28_;
            if((_loc29_ = _loc21_ * (_loc10_ - _loc12_) + _loc22_ * (_loc11_ - _loc13_) + (_loc14_ < 0 ? -_loc14_ : _loc14_) * _loc7_ + (_loc15_ < 0 ? -_loc15_ : _loc15_) * _loc8_) == 0)
            {
               _loc16_ = 1;
               break;
            }
            _loc30_ = (_loc23_ - _loc24_) / _loc29_;
            if((_loc31_ = _loc16_ + _loc30_) < 0 || 1 < _loc31_)
            {
               _loc16_ = 1;
               break;
            }
            if(_loc31_ < (1 + 100 * Number.MIN_VALUE) * _loc16_)
            {
               break;
            }
            _loc16_ = _loc31_;
            _loc20_++;
         }
         return _loc16_;
      }
   }
}
