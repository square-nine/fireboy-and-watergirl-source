package system.diagnostics
{
   import flash.errors.IllegalOperationError;
   import system.Strings;
   import system.terminals.Console;
   
   public class TraceConsole implements Console
   {
       
      
      protected var _buffer:String = "";
      
      public function TraceConsole()
      {
         super();
      }
      
      protected function _formatMessage(param1:Array) : String
      {
         if(param1.length == 0)
         {
            return "";
         }
         var _loc2_:String = String(param1.shift());
         if(param1.length == 0)
         {
            return _loc2_;
         }
         param1.unshift(_loc2_);
         return Strings.format.apply(Strings,param1);
      }
      
      public function read() : String
      {
         throw new IllegalOperationError(this + " read() method is illegal in this console.");
      }
      
      public function readLine() : String
      {
         throw new IllegalOperationError(this + " readLine() method is illegal in this console.");
      }
      
      public function write(... rest) : void
      {
         _buffer += _formatMessage(rest);
      }
      
      public function writeLine(... rest) : void
      {
         var _loc2_:String = _formatMessage(rest);
         trace(_buffer + _loc2_);
         _buffer = "";
      }
   }
}
