package Box2D.Common
{
   import Box2D.Common.Math.b2Math;
   
   public class b2Color
   {
       
      
      private var _g:uint = 0;
      
      private var _b:uint = 0;
      
      private var _r:uint = 0;
      
      public function b2Color(param1:Number, param2:Number, param3:Number)
      {
         _r = 0;
         _g = 0;
         _b = 0;
         super();
         _r = uint(255 * b2Math.b2Clamp(param1,0,1));
         _g = uint(255 * b2Math.b2Clamp(param2,0,1));
         _b = uint(255 * b2Math.b2Clamp(param3,0,1));
      }
      
      public function Set(param1:Number, param2:Number, param3:Number) : void
      {
         _r = uint(255 * b2Math.b2Clamp(param1,0,1));
         _g = uint(255 * b2Math.b2Clamp(param2,0,1));
         _b = uint(255 * b2Math.b2Clamp(param3,0,1));
      }
      
      public function get color() : uint
      {
         return _r | _g << 8 | _b << 16;
      }
      
      public function set r(param1:Number) : void
      {
         _r = uint(255 * b2Math.b2Clamp(param1,0,1));
      }
      
      public function set b(param1:Number) : void
      {
         _b = uint(255 * b2Math.b2Clamp(param1,0,1));
      }
      
      public function set g(param1:Number) : void
      {
         _g = uint(255 * b2Math.b2Clamp(param1,0,1));
      }
   }
}
