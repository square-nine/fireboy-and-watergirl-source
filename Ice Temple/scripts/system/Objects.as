package system
{
   import flash.utils.ByteArray;
   
   public class Objects
   {
       
      
      public function Objects()
      {
         super();
      }
      
      public static function contains(param1:Object, param2:*) : Boolean
      {
         var _loc3_:String = null;
         for(_loc3_ in param1)
         {
            if(param1[_loc3_] == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function copy(param1:Object, param2:Boolean = false) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:ByteArray = null;
         if(param2)
         {
            _loc3_ = {};
            for(_loc4_ in param1)
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
            return _loc3_;
         }
         (_loc5_ = new ByteArray()).writeObject(param1);
         _loc5_.position = 0;
         return _loc5_.readObject();
      }
      
      public static function getMembers(param1:Object, param2:Boolean = false) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc3_:Array = [];
         if(param2)
         {
            for each(_loc4_ in param1)
            {
               _loc3_.push(_loc4_);
            }
         }
         else
         {
            for(_loc5_ in param1)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public static function isSimple(param1:*) : Boolean
      {
         return false;
      }
      
      public static function merge(param1:Object, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:String = null;
         for(_loc4_ in param1)
         {
            if(!param2.hasOwnProperty(_loc4_) || param3)
            {
               param2[_loc4_] = param1[_loc4_];
            }
         }
      }
      
      public static function toArray(param1:Object) : Array
      {
         return getMembers(param1,true);
      }
   }
}
