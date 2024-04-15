package mochi.as3
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class MochiScores
   {
      
      public static var onCloseHandler:Object;
      
      public static var onErrorHandler:Object;
      
      private static var boardID:String;
       
      
      public function MochiScores()
      {
         super();
      }
      
      public static function onClose(param1:Object = null) : void
      {
         if(param1 && param1.error == true && Boolean(onErrorHandler))
         {
            if(param1.errorCode == null)
            {
               param1.errorCode = "IOError";
            }
            onErrorHandler(param1.errorCode);
            MochiServices.doClose();
            return;
         }
         onCloseHandler();
         MochiServices.doClose();
      }
      
      public static function setBoardID(param1:String) : void
      {
         MochiServices.warnID(param1,true);
         MochiScores.boardID = param1;
         MochiServices.send("scores_setBoardID",{"boardID":param1});
      }
      
      public static function showLeaderboard(param1:Object = null) : void
      {
         var n:Number = NaN;
         var options:Object = param1;
         if(options != null)
         {
            delete options.clip;
            MochiServices.setContainer();
            MochiServices.bringToTop();
            if(options.name != null)
            {
               if(options.name is TextField)
               {
                  if(options.name.text.length > 0)
                  {
                     options.name = options.name.text;
                  }
               }
            }
            if(options.score != null)
            {
               if(options.score is TextField)
               {
                  if(options.score.text.length > 0)
                  {
                     options.score = options.score.text;
                  }
               }
               else if(options.score is MochiDigits)
               {
                  options.score = options.score.value;
               }
               n = Number(options.score);
               if(isNaN(n))
               {
                  trace("ERROR: Submitted score \'" + options.score + "\' will be rejected, score is \'Not a Number\'");
               }
               else if(n == Number.NEGATIVE_INFINITY || n == Number.POSITIVE_INFINITY)
               {
                  trace("ERROR: Submitted score \'" + options.score + "\' will be rejected, score is an infinite");
               }
               else
               {
                  if(Math.floor(n) != n)
                  {
                     trace("WARNING: Submitted score \'" + options.score + "\' will be truncated");
                  }
                  options.score = n;
               }
            }
            if(options.onDisplay != null)
            {
               options.onDisplay();
            }
            else if(MochiServices.clip != null)
            {
               if(MochiServices.clip is MovieClip)
               {
                  MochiServices.clip.stop();
               }
               else
               {
                  trace("Warning: Container is not a MovieClip, cannot call default onDisplay.");
               }
            }
         }
         else
         {
            options = {};
            if(MochiServices.clip is MovieClip)
            {
               MochiServices.clip.stop();
            }
            else
            {
               trace("Warning: Container is not a MovieClip, cannot call default onDisplay.");
            }
         }
         if(options.onClose != null)
         {
            onCloseHandler = options.onClose;
         }
         else
         {
            onCloseHandler = function():void
            {
               if(MochiServices.clip is MovieClip)
               {
                  MochiServices.clip.play();
               }
               else
               {
                  trace("Warning: Container is not a MovieClip, cannot call default onClose.");
               }
            };
         }
         if(options.onError != null)
         {
            onErrorHandler = options.onError;
         }
         else
         {
            onErrorHandler = null;
         }
         if(options.boardID == null)
         {
            if(MochiScores.boardID != null)
            {
               options.boardID = MochiScores.boardID;
            }
         }
         MochiServices.warnID(options.boardID,true);
         trace("[MochiScores] NOTE: Security Sandbox Violation errors below are normal");
         MochiServices.send("scores_showLeaderboard",{"options":options},null,onClose);
      }
      
      public static function closeLeaderboard() : void
      {
         MochiServices.send("scores_closeLeaderboard");
      }
      
      public static function getPlayerInfo(param1:Object, param2:Object = null) : void
      {
         MochiServices.send("scores_getPlayerInfo",null,param1,param2);
      }
      
      public static function submit(param1:Number, param2:String, param3:Object = null, param4:Object = null) : void
      {
         param1 = Number(param1);
         if(isNaN(param1))
         {
            trace("ERROR: Submitted score \'" + String(param1) + "\' will be rejected, score is \'Not a Number\'");
         }
         else if(param1 == Number.NEGATIVE_INFINITY || param1 == Number.POSITIVE_INFINITY)
         {
            trace("ERROR: Submitted score \'" + String(param1) + "\' will be rejected, score is an infinite");
         }
         else
         {
            if(Math.floor(param1) != param1)
            {
               trace("WARNING: Submitted score \'" + String(param1) + "\' will be truncated");
            }
            param1 = Number(param1);
         }
         MochiServices.send("scores_submit",{
            "score":param1,
            "name":param2
         },param3,param4);
      }
      
      public static function requestList(param1:Object, param2:Object = null) : void
      {
         MochiServices.send("scores_requestList",null,param1,param2);
      }
      
      public static function scoresArrayToObjects(param1:Object) : Object
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:Object = {};
         for(_loc7_ in param1)
         {
            if(typeof param1[_loc7_] == "object")
            {
               if(param1[_loc7_].cols != null && param1[_loc7_].rows != null)
               {
                  _loc2_[_loc7_] = [];
                  _loc5_ = param1[_loc7_];
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.rows.length)
                  {
                     _loc6_ = {};
                     _loc3_ = 0;
                     while(_loc3_ < _loc5_.cols.length)
                     {
                        _loc6_[_loc5_.cols[_loc3_]] = _loc5_.rows[_loc4_][_loc3_];
                        _loc3_++;
                     }
                     _loc2_[_loc7_].push(_loc6_);
                     _loc4_++;
                  }
               }
               else
               {
                  _loc2_[_loc7_] = {};
                  for(_loc8_ in param1[_loc7_])
                  {
                     _loc2_[_loc7_][_loc8_] = param1[_loc7_][_loc8_];
                  }
               }
            }
            else
            {
               _loc2_[_loc7_] = param1[_loc7_];
            }
         }
         return _loc2_;
      }
   }
}
