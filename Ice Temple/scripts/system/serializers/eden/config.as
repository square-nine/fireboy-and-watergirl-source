package system.serializers.eden
{
   public var config:EdenConfigurator = new EdenConfigurator({
      "compress":true,
      "copyObjectByValue":false,
      "strictMode":true,
      "undefineable":undefined,
      "verbose":false,
      "security":true,
      "authorized":["Array.*","Boolean","Date","Error","Math.*","Number.*","Object","String","Infinity"],
      "allowFunctionCall":true,
      "autoAddScopePath":false,
      "arrayIndexAsBracket":false
   });
}
