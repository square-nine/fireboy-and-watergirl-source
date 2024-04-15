package Playtomic
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public final class Link
   {
      
      private static var Clicks:Array = new Array();
       
      
      public function Link()
      {
         super();
      }
      
      public static function Open(param1:String, param2:String, param3:String, param4:Boolean = false, param5:String = "_blank") : Boolean
      {
         var baseurlname:String;
         var result:Boolean = false;
         var url:String = param1;
         var name:String = param2;
         var group:String = param3;
         var trackonly:Boolean = param4;
         var target:String = param5;
         var unique:int = 0;
         var bunique:int = 0;
         var total:int = 0;
         var btotal:int = 0;
         var fail:int = 0;
         var bfail:int = 0;
         var key:String = url + "." + name;
         var baseurl:String = url;
         baseurl = baseurl.replace("http://","");
         if(baseurl.indexOf("/") > -1)
         {
            baseurl = baseurl.substring(0,baseurl.indexOf("/"));
         }
         if(baseurl.indexOf("?") > -1)
         {
            baseurl = baseurl.substring(0,baseurl.indexOf("?"));
         }
         baseurl = "http://" + baseurl + "/";
         baseurlname = baseurl;
         if(baseurlname.indexOf("//") > -1)
         {
            baseurlname = baseurlname.substring(baseurlname.indexOf("//") + 2);
         }
         baseurlname = baseurlname.replace("www.","");
         if(baseurlname.indexOf("/") > -1)
         {
            baseurlname = baseurlname.substring(0,baseurlname.indexOf("/"));
         }
         try
         {
            if(!trackonly)
            {
               navigateToURL(new URLRequest(url),target);
            }
            if(Clicks.indexOf(key) > -1)
            {
               total = 1;
            }
            else
            {
               total = 1;
               unique = 1;
               Clicks.push(key);
            }
            if(Clicks.indexOf(baseurlname) > -1)
            {
               btotal = 1;
            }
            else
            {
               btotal = 1;
               bunique = 1;
               Clicks.push(baseurlname);
            }
            result = true;
         }
         catch(err:Error)
         {
            fail = 1;
            bfail = 1;
            result = false;
         }
         Log.Link(baseurl,baseurlname.toLowerCase(),"DomainTotals",bunique,btotal,bfail);
         Log.Link(url,name,group,unique,total,fail);
         Log.ForceSend();
         return result;
      }
   }
}
