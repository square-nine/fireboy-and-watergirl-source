package system.reflection
{
   public interface ClassInfo extends TypeInfo
   {
       
      
      function get accessors() : Array;
      
      function get constants() : Array;
      
      function get filter() : FilterType;
      
      function set filter(param1:FilterType) : void;
      
      function get members() : Array;
      
      function get methods() : Array;
      
      function get name() : String;
      
      function get properties() : Array;
      
      function get superClass() : ClassInfo;
      
      function get variables() : Array;
      
      function hasInterface(... rest) : Boolean;
      
      function inheritFrom(... rest) : Boolean;
      
      function isDynamic() : Boolean;
      
      function isFinal() : Boolean;
      
      function isInstance() : Boolean;
      
      function isStatic() : Boolean;
      
      function toXML() : XML;
   }
}
