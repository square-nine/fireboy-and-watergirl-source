package system.serializers.eden
{
   public function info(param1:Boolean = false, param2:Boolean = false):String
   {
      var _loc7_:Version = new Version(0,1);
      var _loc8_:* = "";
      if(!param1 && Boolean(config.verbose))
      {
         param1 = true;
      }
      if(param1)
      {
         _loc8_ = (_loc8_ = (_loc8_ += "{sep}{crlf}") + "{name}: {fullname} v{version}{crlf}") + "{sep}";
      }
      else
      {
         _loc8_ += "{name} v{version}";
      }
      if(param2)
      {
         _loc8_ = (_loc8_ = (_loc8_ += "{crlf}config:") + "{config}{crlf}") + "{sep}";
      }
      return Strings.format(_loc8_,{
         "sep":"----------------------------------------------------------------",
         "crlf":"\n",
         "name":"eden",
         "fullname":"ECMASCript data exchange notation",
         "version":_loc7_,
         "config":eden.serialize(config)
      });
   }}
