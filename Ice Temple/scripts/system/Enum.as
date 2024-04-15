package system
{
   public class Enum implements Serializable
   {
       
      
      protected var _name:String;
      
      protected var _value:int;
      
      public function Enum(param1:int = 0, param2:String = "")
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function toSource(param1:int = 0) : String
      {
         var _loc2_:String = Reflection.getClassPath(this);
         if(_name != "")
         {
            return _loc2_ + "." + _name;
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return _name;
      }
      
      public function valueOf() : int
      {
         return _value;
      }
   }
}
