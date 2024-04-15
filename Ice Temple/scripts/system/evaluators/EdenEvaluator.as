package system.evaluators
{
   import system.eden;
   
   public class EdenEvaluator implements Evaluable
   {
       
      
      private var _serialized:Boolean;
      
      public function EdenEvaluator(param1:Boolean = true)
      {
         super();
         _serialized = param1;
      }
      
      public function eval(param1:*) : *
      {
         var _loc2_:* = eden.deserialize(param1);
         if(_serialized)
         {
            return eden.serialize(_loc2_);
         }
         return _loc2_;
      }
   }
}
