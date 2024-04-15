package
{
   import Box2D.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.*;
   import Box2D.Common.Math.*;
   import Box2D.Dynamics.*;
   import Box2D.Dynamics.Contacts.*;
   import Box2D.Dynamics.Joints.*;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.getTimer;
   import mochi.as3.*;
   
   public class Game extends MovieClip
   {
       
      
      public var AssetHolder:MovieClip;
      
      internal var kongregate:*;
      
      internal var JanSatan:* = false;
      
      internal var ln:* = 41;
      
      internal var score:*;
      
      internal var Teaser:*;
      
      internal var m_level:level;
      
      internal var m_timer:Watch;
      
      internal var m_muter:Muter;
      
      internal var m_qualiter:Qualiter;
      
      internal var m_pauseMenu:PauseMenu;
      
      internal var m_mainMenu:MainMenu;
      
      internal var m_introMenu:IntroMenu;
      
      internal var m_fps:*;
      
      internal var m_transition:Trans;
      
      internal var GameOverBoard:*;
      
      internal var RecuentBoard:*;
      
      internal var window:b2Vec2;
      
      internal var currentsize:b2Vec2;
      
      internal var zoom:* = 1;
      
      internal var vzoom:* = 0;
      
      internal var cur_type:Number;
      
      internal var cur_lev:Number;
      
      internal var cur_node:Number;
      
      internal var The_cookie:SharedObject;
      
      internal var Translation:Array;
      
      internal var Adjacencies:Array;
      
      internal var TimeTable:Array;
      
      internal var NewsArray:Array;
      
      internal var NavisSound:Navis_Sound;
      
      internal var NavisChannel:SoundChannel;
      
      internal var OverSound:Over_Sound;
      
      internal var MusicChannel:SoundChannel;
      
      internal var MenuSound:Menu_Sound;
      
      internal var AdvSound:Adv_Sound;
      
      internal var SpeedSound:Speed_Sound;
      
      internal var DarkSound:Dark_Sound;
      
      internal var PlayingMusic:Boolean;
      
      internal var instr:Instructions;
      
      internal var hisc:*;
      
      internal var h:*;
      
      internal var crd:Credits;
      
      internal var FinishSound1:Finish1;
      
      internal var FinishSound2:Finish2;
      
      internal var Muted:Boolean;
      
      public function Game()
      {
         super();
         addFrameScript(0,this.frame1);
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         contextMenu = _loc1_;
         this.CreatePreloader();
      }
      
      public function MochiErrorHandler(param1:*) : *
      {
      }
      
      internal function KongAPISetup() : *
      {
         var _loc1_:Object = LoaderInfo(root.loaderInfo).parameters;
         Security.allowDomain("http://www.kongregate.com/flash/API_AS3_Local.swf");
         var _loc3_:URLRequest = new URLRequest("http://www.kongregate.com/flash/API_AS3_Local.swf");
         var _loc4_:Loader;
         (_loc4_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.KongAPIloadComplete);
         _loc4_.load(_loc3_);
         this.addChild(_loc4_);
      }
      
      internal function KongAPIloadComplete(param1:Event) : void
      {
         this.kongregate = param1.target.content;
         this.kongregate.services.connect();
      }
      
      public function GameReady() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         MochiServices.connect("ef0e3111e5a4ee94",root);
         this.KongAPISetup();
         this.gotoAndStop(3);
         this.Muted = false;
         this.Translation = new Array("1_1","1_2","3_1","1_3","1_4","3_2","2_1","1_5","1_6","1_7","2_2","3_3","2_3","3_5","1_13","3_6","2_4","1_14","1_16","2_5","1_15","1_17","2_6","1_10","1_11","3_4","2_7","1_12","2_8","1_8","1_9","2_9","4_1","4_2","4_3","1_18","1_19","4_6","2_10","2_11","3_7");
         this.NewsArray = new Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false);
         this.TimeTable = new Array(118,55,35,55,90,27,95,100,110,95,95,22,75,55,100,35,70,35,87,60,30,85,90,80,80,45,115,33,130,82,60,105,44,30,30,45,195,29,115,77,30,10,10,10,10,10,10,10);
         this.NavisSound = new Navis_Sound();
         this.OverSound = new Over_Sound();
         this.The_cookie = SharedObject.getLocal("FBCookie");
         this.MenuSound = new Menu_Sound();
         this.AdvSound = new Adv_Sound();
         this.SpeedSound = new Speed_Sound();
         this.DarkSound = new Dark_Sound();
         if(this.The_cookie.data.stats == undefined)
         {
            this.The_cookie.data.submited = 0;
            this.The_cookie.data.stats = new Array(this.ln);
            this.The_cookie.data.times = new Array(this.ln);
            this.The_cookie.data.timesString = new Array(this.ln);
            _loc2_ = 0;
            while(_loc2_ < this.ln)
            {
               this.The_cookie.data.stats[_loc2_] = -1;
               this.The_cookie.data.times[_loc2_] = 0;
               this.The_cookie.data.timesString[_loc2_] = "";
               _loc2_++;
            }
            this.The_cookie.data.stats[17] = 0;
            this.The_cookie.data.stats[20] = 0;
            this.The_cookie.data.stats[35] = 0;
         }
         trace("THE COOKIE " + this.The_cookie.size);
         this.Adjacencies = new Array(this.ln);
         var _loc1_:* = 0;
         while(_loc1_ < this.ln)
         {
            this.Adjacencies[_loc1_] = new Array(this.ln);
            _loc3_ = 0;
            while(_loc3_ < this.ln)
            {
               this.Adjacencies[_loc1_][_loc3_] = 0;
               _loc3_++;
            }
            _loc1_++;
         }
         this.Adjacencies[35][1] = 1;
         this.Adjacencies[17][35] = 1;
         this.Adjacencies[20][35] = 1;
         this.Adjacencies[1][8] = 1;
         this.Adjacencies[8][6] = 1;
         this.Adjacencies[8][30] = 1;
         this.Adjacencies[8][12] = 1;
         this.Adjacencies[6][2] = 1;
         this.Adjacencies[2][25] = 1;
         this.Adjacencies[2][39] = 1;
         this.Adjacencies[2][30] = 1;
         this.Adjacencies[25][4] = 1;
         this.Adjacencies[25][10] = 1;
         this.Adjacencies[25][7] = 1;
         this.Adjacencies[39][23] = 1;
         this.Adjacencies[12][29] = 1;
         this.Adjacencies[29][30] = 1;
         this.Adjacencies[29][19] = 1;
         this.Adjacencies[29][3] = 1;
         this.Adjacencies[3][36] = 1;
         this.Adjacencies[3][16] = 1;
         this.Adjacencies[3][24] = 1;
         this.Adjacencies[19][15] = 1;
         this.Adjacencies[30][23] = 1;
         this.Adjacencies[30][14] = 1;
         this.Adjacencies[30][15] = 1;
         this.Adjacencies[23][5] = 1;
         this.Adjacencies[23][31] = 1;
         this.Adjacencies[5][0] = 1;
         this.Adjacencies[5][38] = 1;
         this.Adjacencies[5][40] = 1;
         this.Adjacencies[31][14] = 1;
         this.Adjacencies[15][26] = 1;
         this.Adjacencies[15][18] = 1;
         this.Adjacencies[18][27] = 1;
         this.Adjacencies[18][22] = 1;
         this.Adjacencies[18][11] = 1;
         this.Adjacencies[26][14] = 1;
         this.Adjacencies[14][21] = 1;
         this.Adjacencies[21][13] = 1;
         this.Adjacencies[21][28] = 1;
         this.Adjacencies[21][9] = 1;
         _loc1_ = 0;
         while(_loc1_ < this.ln)
         {
            _loc3_ = 0;
            while(_loc3_ < this.ln)
            {
               if(this.Adjacencies[_loc1_][_loc3_] == 1)
               {
                  this.Adjacencies[_loc3_][_loc1_] = 1;
               }
               _loc3_++;
            }
            _loc1_++;
         }
         this.CreateIntroMenu();
         this.m_muter = new Muter();
         this.m_muter.x = 629;
         this.m_muter.y = 11;
         addChild(this.m_muter);
         this.m_muter.muteBtn.addEventListener(MouseEvent.CLICK,this.MuteSound);
         this.m_muter.muteLines.visible = !this.Muted;
         this.m_qualiter = new Qualiter();
         this.m_qualiter.x = 26;
         this.m_qualiter.y = 10;
         addChild(this.m_qualiter);
         this.m_qualiter.muteBtn.addEventListener(MouseEvent.CLICK,this.ChangeQuality);
      }
      
      public function ChangeQuality(param1:*) : *
      {
         if(stage.quality == "LOW")
         {
            stage.quality = "MEDIUM";
            param1.target.parent.txt.text = "M";
         }
         else if(stage.quality == "MEDIUM")
         {
            stage.quality = "HIGH";
            param1.target.parent.txt.text = "H";
         }
         else if(stage.quality == "HIGH")
         {
            stage.quality = "LOW";
            param1.target.parent.txt.text = "L";
         }
      }
      
      public function CreatePreloader() : *
      {
         var _loc1_:* = new PreLoader(this);
         this.addChild(_loc1_);
      }
      
      public function CreateTeaser() : *
      {
         this.TeaserOut();
      }
      
      internal function handleGameManagerReady(param1:Event) : void
      {
      }
      
      public function TeaserClick(param1:MouseEvent) : *
      {
      }
      
      public function TeaserOut() : *
      {
         if(this.Teaser)
         {
            this.Teaser.LinkBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.TeaserClick);
            this.removeChild(this.Teaser);
         }
         this.GameReady();
      }
      
      public function MoreGames(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.miniclip.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function MoreGames2(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.miniclip.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function WalkThroughLink(param1:MouseEvent) : *
      {
      }
      
      internal function StartGameBtn(param1:MouseEvent) : *
      {
         var _loc3_:Number = NaN;
         this.PlayingMusic = false;
         this.MusicChannel.stop();
         new Pusher_Sound().play(0,1);
         var _loc2_:* = param1.target.name.charAt(2);
         if(param1.target.name.length == 5)
         {
            _loc3_ = Number(param1.target.name.charAt(4));
         }
         else
         {
            _loc3_ = parseInt(param1.target.name.charAt(4) + param1.target.name.charAt(5));
         }
         trace(_loc2_ + " " + _loc3_);
         var _loc4_:* = 0;
         while(_loc4_ < this.ln)
         {
            if(this.Translation[_loc4_] == _loc2_ + "_" + _loc3_)
            {
               this.cur_node = _loc4_ + 1;
            }
            _loc4_++;
         }
         this.cur_type = _loc2_;
         this.cur_lev = _loc3_;
         this.NewsArray[this.cur_node - 1] = false;
         this.m_mainMenu.StartBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.StartGame);
         this.m_transition = new Trans();
         this.m_transition.alpha = 0;
         addChild(this.m_transition);
         this.m_transition.addEventListener(Event.ENTER_FRAME,this.Transit);
      }
      
      public function Transit(param1:Event) : *
      {
         this.m_transition.alpha += 0.2;
         if(this.m_transition.alpha > 1)
         {
            removeChild(this.m_mainMenu);
            this.StartGame(this.cur_type,this.cur_lev);
            this.m_transition.removeEventListener(Event.ENTER_FRAME,this.Transit);
            removeChild(this.m_transition);
         }
      }
      
      public function StartGame(param1:Number, param2:Number) : *
      {
         var _loc3_:String = null;
         if(this.PlayingMusic != true)
         {
            this.PlayingMusic = true;
            this.MusicChannel.stop();
            if(param1 == 1 || param1 == 2)
            {
               this.MusicChannel = this.AdvSound.play(0,999);
            }
            else if(param1 == 3)
            {
               this.MusicChannel = this.SpeedSound.play(0,999);
            }
            else
            {
               this.MusicChannel = this.DarkSound.play(0,999);
            }
         }
         if(param1 == 1)
         {
            _loc3_ = "adventure";
         }
         if(param1 == 2)
         {
            _loc3_ = "puzzle";
         }
         if(param1 == 3)
         {
            _loc3_ = "speed";
         }
         if(param1 == 4)
         {
            _loc3_ = "dark";
         }
         this.m_level = new level(_loc3_,param2);
         this.m_level.name = "m_level";
         addChild(this.m_level);
         this.m_level.scaleX = 0.8;
         this.m_level.scaleY = 0.8;
         this.m_level.x += 16;
         this.m_level.y += 16;
         this.m_timer = new Watch();
         this.m_timer.name = "m_timer";
         addChild(this.m_timer);
         this.m_timer.x = 320;
         this.m_timer.y = 20;
         this.m_timer.startTime = getTimer();
         this.m_timer.addEventListener(Event.ENTER_FRAME,this.TimerUpdate,false,0,true);
         this.m_pauseMenu = new PauseMenu();
         addChild(this.m_pauseMenu);
         this.m_pauseMenu.name = "m_pauseMenu";
         this.m_pauseMenu.x = 320;
         this.m_pauseMenu.y = 480;
         this.m_qualiter.x = this.m_muter.x - 50;
         setChildIndex(this.m_muter,numChildren - 1);
         setChildIndex(this.m_qualiter,numChildren - 1);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyPressed);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyReleased);
         stage.focus = this;
      }
      
      public function MuteSound(param1:MouseEvent) : *
      {
         if(this.Muted == false)
         {
            this.Muted = true;
            SoundMixer.soundTransform = new SoundTransform(0);
            this.m_muter.muteLines.visible = false;
         }
         else
         {
            this.Muted = false;
            SoundMixer.soundTransform = new SoundTransform(1);
            this.m_muter.muteLines.visible = true;
         }
      }
      
      public function EndGame() : *
      {
         this.PlayingMusic = false;
         this.MusicChannel.stop();
         var _loc1_:* = 0;
         while(_loc1_ < this.m_level.windChannels.length)
         {
            this.m_level.windChannels[_loc1_].stop();
            _loc1_++;
         }
         this.m_level.FBChannel.stop();
         this.m_level.WGChannel.stop();
         this.m_level.removeEventListener(Event.ENTER_FRAME,this.m_level.Update);
         this.m_pauseMenu.removeEventListener(Event.ENTER_FRAME,this.m_pauseMenu.Update);
         this.m_timer.removeEventListener(Event.ENTER_FRAME,this.TimerUpdate);
         removeChild(this.m_level);
         removeChild(this.m_timer);
         removeChild(this.m_pauseMenu);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyPressed);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyReleased);
         this.CreateMainMenu();
      }
      
      public function RetryGame() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < this.m_level.windChannels.length)
         {
            this.m_level.windChannels[_loc1_].stop();
            _loc1_++;
         }
         this.m_level.StopSounds();
         this.m_level.FBChannel.stop();
         this.m_level.WGChannel.stop();
         this.m_level.removeEventListener(Event.ENTER_FRAME,this.m_level.Update);
         this.m_pauseMenu.removeEventListener(Event.ENTER_FRAME,this.m_pauseMenu.Update);
         this.m_timer.removeEventListener(Event.ENTER_FRAME,this.TimerUpdate);
         removeChild(this.m_level);
         removeChild(this.m_timer);
         removeChild(this.m_pauseMenu);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyPressed);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyReleased);
         this.StartGame(this.cur_type,this.cur_lev);
      }
      
      public function CreateIntroMenu() : *
      {
         if(this.PlayingMusic != true)
         {
            this.MusicChannel = this.MenuSound.play(0,999);
            this.PlayingMusic = true;
         }
         this.m_introMenu = new IntroMenu();
         addChild(this.m_introMenu);
         this.m_introMenu.Buttons.Starter.addEventListener(MouseEvent.CLICK,this.LoadMenu);
         this.m_introMenu.Buttons.Starter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.CLICK,this.LoadInstructions);
         this.m_introMenu.Buttons.Submiter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Submiter.addEventListener(MouseEvent.CLICK,this.ShowHiscore);
         this.m_introMenu.Buttons.Morer.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Morer.addEventListener(MouseEvent.CLICK,this.MoreGames2);
         this.m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.CLICK,this.LoadCredits);
         this.m_introMenu.Buttons.Forester.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Forester.addEventListener(MouseEvent.CLICK,this.PlayForest);
         this.m_introMenu.Buttons.Lighter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Lighter.addEventListener(MouseEvent.CLICK,this.PlayLight);
         this.m_introMenu.ArmorLogo.addEventListener(MouseEvent.CLICK,this.MoreGames);
         if(this.m_muter)
         {
            setChildIndex(this.m_muter,numChildren - 1);
         }
         if(this.m_qualiter)
         {
            setChildIndex(this.m_qualiter,numChildren - 1);
         }
      }
      
      public function ShowHiscore(param1:*) : *
      {
         var evt:* = param1;
         var o:Object = {
            "n":[3,9,13,5,0,0,2,6,15,14,11,8,5,11,14,12],
            "f":function(param1:Number, param2:String):String
            {
               if(param2.length == 16)
               {
                  return param2;
               }
               return this.f(param1 + 1,param2 + this.n[param1].toString(16));
            }
         };
         var boardID:String = String(o.f(0,""));
         MochiScores.showLeaderboard({
            "boardID":boardID,
            "onClose":this.MochiCloseHandler
         });
      }
      
      public function MochiCloseHandler() : *
      {
         trace("MOCHI CLOSE");
      }
      
      internal function postKongStats() : *
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         for(; _loc6_ < this.ln; _loc6_++)
         {
            if(!this.The_cookie.data.stats[_loc6_])
            {
               continue;
            }
            switch(this.The_cookie.data.stats[_loc6_])
            {
               case 0:
                  break;
               case 1:
                  _loc3_++;
                  break;
               case 2:
                  _loc3_++;
                  _loc4_++;
                  break;
               case 3:
                  _loc3_++;
                  _loc4_++;
                  _loc5_++;
                  break;
            }
         }
         if(this.kongregate)
         {
            this.kongregate.stats.submit("levelsA",_loc5_);
            this.kongregate.stats.submit("levelsB",_loc4_);
            this.kongregate.stats.submit("levelsC",_loc3_);
            this.kongregate.stats.submit("diamondA",0);
            this.kongregate.stats.submit("speedA",0);
         }
      }
      
      public function OverSounder(param1:MouseEvent) : *
      {
         this.OverSound.play(0,1);
      }
      
      public function PlayForest(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.miniclip.com/games/forest-temple/");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function PlayLight(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.miniclip.com/games/light-temple");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function GoTwitter(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://twitter.com/armorgames");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function GoFacebook(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.facebook.com/pages/Armor-Games/19522089061");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function LoadHiscore(param1:MouseEvent) : *
      {
         var s:*;
         var able:*;
         var o:Object;
         var boardID:String;
         var evt:MouseEvent = param1;
         var points:* = 0;
         this.score = 0;
         s = 0;
         while(s < 32)
         {
            this.score += Math.max(this.The_cookie.data.stats[s] * 360,0);
            if(this.The_cookie.data.times[s] != 0)
            {
               this.score += Math.max((this.TimeTable[s] - this.The_cookie.data.times[s]) * 12,0);
            }
            s++;
         }
         points = this.score;
         able = true;
         s = 0;
         while(s < 32)
         {
            if(this.The_cookie.data.stats[s] <= 0)
            {
               able = false;
            }
            s++;
         }
         trace("SCORE " + this.score);
         o = {
            "n":[3,9,13,5,0,0,2,6,15,14,11,8,5,11,14,12],
            "f":function(param1:Number, param2:String):String
            {
               if(param2.length == 16)
               {
                  return param2;
               }
               return this.f(param1 + 1,param2 + this.n[param1].toString(16));
            }
         };
         boardID = String(o.f(0,""));
         MochiScores.showLeaderboard({
            "boardID":boardID,
            "score":points,
            "onClose":this.MochiCloseHandler
         });
      }
      
      public function InputChanged(param1:Event) : *
      {
         this.hisc.name_txt_2.text = this.hisc.name_txt.text;
         this.hisc.name_txt_2.autoSize = TextFieldAutoSize.LEFT;
         this.hisc.name_txt.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function ViewHiscores(param1:MouseEvent) : *
      {
      }
      
      public function SendHiscore(param1:MouseEvent) : *
      {
      }
      
      public function loadComplete(param1:Event) : void
      {
         trace("DADAAAA");
      }
      
      internal function closeHandler() : void
      {
         this.The_cookie.data.submited = this.score;
         removeChild(this.h);
      }
      
      internal function closeHandler2() : void
      {
      }
      
      public function BackHiscore(param1:MouseEvent) : *
      {
         removeChild(this.h);
      }
      
      public function ClearData(param1:MouseEvent) : *
      {
         this.The_cookie.data.submited = 0;
         this.The_cookie.data.stats = new Array(this.ln);
         this.The_cookie.data.times = new Array(this.ln);
         this.The_cookie.data.timesString = new Array(this.ln);
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            this.The_cookie.data.stats[_loc2_] = -1;
            this.The_cookie.data.times[_loc2_] = 0;
            this.The_cookie.data.timesString[_loc2_] = "";
            _loc2_++;
         }
         this.The_cookie.data.stats[17] = 0;
         this.The_cookie.data.stats[20] = 0;
         removeChild(this.h);
      }
      
      public function LoadInstructions(param1:MouseEvent) : *
      {
         this.instr = new Instructions();
         addChild(this.instr);
         this.instr.OKO.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.instr.OKO.addEventListener(MouseEvent.CLICK,this.UnLoadInstructions);
      }
      
      public function UnLoadInstructions(param1:MouseEvent) : *
      {
         removeChild(this.instr);
      }
      
      public function LoadCredits(param1:MouseEvent) : *
      {
         this.crd = new Credits();
         addChild(this.crd);
         this.crd.OKO.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.crd.OKO.addEventListener(MouseEvent.CLICK,this.UnLoadCredits);
      }
      
      public function UnLoadCredits(param1:MouseEvent) : *
      {
         removeChild(this.crd);
      }
      
      public function LoadMenu(param1:MouseEvent) : *
      {
         this.m_transition = new Trans();
         this.m_transition.alpha = 0;
         addChild(this.m_transition);
         this.m_transition.addEventListener(Event.ENTER_FRAME,this.Transit2);
      }
      
      public function Transit2(param1:Event) : *
      {
         this.m_transition.alpha += 0.1;
         if(this.m_transition.alpha > 1)
         {
            removeChild(this.m_introMenu);
            this.CreateMainMenu();
            this.m_transition.removeEventListener(Event.ENTER_FRAME,this.Transit2);
            removeChild(this.m_transition);
         }
      }
      
      public function BackToIntro(param1:MouseEvent) : *
      {
         this.m_transition = new Trans();
         this.m_transition.alpha = 0;
         addChild(this.m_transition);
         this.m_transition.addEventListener(Event.ENTER_FRAME,this.Transit3);
      }
      
      public function Transit3(param1:Event) : *
      {
         this.m_transition.alpha += 0.1;
         if(this.m_transition.alpha > 1)
         {
            removeChild(this.m_mainMenu);
            this.CreateIntroMenu();
            this.m_transition.removeEventListener(Event.ENTER_FRAME,this.Transit3);
            removeChild(this.m_transition);
         }
      }
      
      public function CreateMainMenu() : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         this.postKongStats();
         if(this.PlayingMusic != true)
         {
            this.PlayingMusic = true;
            this.MusicChannel = this.MenuSound.play(0,999);
         }
         this.m_mainMenu = new MainMenu();
         addChild(this.m_mainMenu);
         this.m_mainMenu.nextpos = new Array(310,452);
         this.m_mainMenu.oldpos = new Array(310,452);
         this.m_mainMenu.flies.vx = 0;
         this.m_mainMenu.flies.vy = 0;
         this.m_mainMenu.flies.addEventListener(Event.ENTER_FRAME,this.FliesMove);
         this.m_mainMenu.BackToIntro.addEventListener(MouseEvent.CLICK,this.BackToIntro);
         this.m_mainMenu.BackToIntro.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_mainMenu.ArmorLogo.addEventListener(MouseEvent.CLICK,this.MoreGames);
         this.m_mainMenu.Nums.visible = false;
         this.m_mainMenu.ShowLevNum.addEventListener(MouseEvent.MOUSE_OVER,this.ShowNums);
         this.m_mainMenu.ShowLevNum.addEventListener(MouseEvent.MOUSE_OUT,this.HideNums);
         var _loc1_:* = 0;
         while(_loc1_ < this.ln)
         {
            _loc3_ = new TimeText();
            _loc4_ = String(Math.floor(this.TimeTable[_loc1_] / 60));
            _loc5_ = String(this.TimeTable[_loc1_] % 60);
            if(_loc4_.length == 1)
            {
               _loc4_ = "0" + _loc4_;
            }
            if(_loc5_.length == 1)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc3_.txt.text = _loc4_ + ":" + _loc5_;
            _loc3_.x = this.m_mainMenu.Golden_road["node_" + (_loc1_ + 1)].x;
            _loc3_.y = this.m_mainMenu.Golden_road["node_" + (_loc1_ + 1)].y;
            this.m_mainMenu.Times.addChild(_loc3_);
            _loc1_++;
         }
         this.m_mainMenu.Times.visible = false;
         this.m_mainMenu.ShowLevTimes.addEventListener(MouseEvent.MOUSE_OVER,this.ShowTimes);
         this.m_mainMenu.ShowLevTimes.addEventListener(MouseEvent.MOUSE_OUT,this.HideTimes);
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            trace("i " + _loc2_);
            this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].visible = false;
            trace(this.The_cookie.data.stats[_loc2_] + " " + this.m_mainMenu["b_" + this.Translation[_loc2_]]);
            _loc6_ = 0;
            while(_loc6_ < this.ln)
            {
               if(this.Adjacencies[_loc2_][_loc6_] == 1)
               {
                  trace("I + J " + _loc2_ + " " + _loc6_);
                  this.m_mainMenu.camins1.graphics.lineStyle(8,5461606,1);
                  this.m_mainMenu.camins1.graphics.moveTo(this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].y);
                  this.m_mainMenu.camins1.graphics.lineTo(this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].y);
                  this.m_mainMenu.camins2.graphics.lineStyle(11,3355443,0.36);
                  this.m_mainMenu.camins2.graphics.moveTo(this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].y);
                  this.m_mainMenu.camins2.graphics.lineTo(this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].y);
               }
               _loc6_++;
            }
            trace("a");
            if(this.The_cookie.data.stats[_loc2_] >= 0)
            {
               this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].visible = true;
               this.m_mainMenu["b_" + this.Translation[_loc2_]].addEventListener(MouseEvent.CLICK,this.StartGameBtn);
               this.m_mainMenu["b_" + this.Translation[_loc2_]].addEventListener(MouseEvent.ROLL_OVER,this.Glowin);
               this.m_mainMenu["b_" + this.Translation[_loc2_]].addEventListener(MouseEvent.ROLL_OUT,this.Glowout);
               switch(this.The_cookie.data.stats[_loc2_])
               {
                  case 0:
                     this.m_mainMenu["node_" + (_loc2_ + 1)].gotoAndStop(1);
                     break;
                  case 1:
                     this.m_mainMenu["node_" + (_loc2_ + 1)].gotoAndStop(2);
                     break;
                  case 2:
                     this.m_mainMenu["node_" + (_loc2_ + 1)].gotoAndStop(3);
                     break;
                  case 3:
                     this.m_mainMenu["node_" + (_loc2_ + 1)].gotoAndStop(4);
               }
               trace("b");
               if(this.The_cookie.data.stats[_loc2_] > 0)
               {
                  _loc6_ = 0;
                  while(_loc6_ < this.ln)
                  {
                     if(this.Adjacencies[_loc2_][_loc6_] == 1)
                     {
                        this.m_mainMenu.Golden_road.graphics.lineStyle(6,16763904,1);
                        this.m_mainMenu.Golden_road.graphics.moveTo(this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc2_ + 1)].y);
                        this.m_mainMenu.Golden_road.graphics.lineTo(this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].x,this.m_mainMenu.Golden_road["node_" + (_loc6_ + 1)].y);
                     }
                     _loc6_++;
                  }
               }
            }
            else
            {
               this.m_mainMenu["node_" + (_loc2_ + 1)].gotoAndStop(1);
               this.m_mainMenu["b_" + this.Translation[_loc2_]].enabled = false;
            }
            trace("c");
            this.m_mainMenu["node_" + (_loc2_ + 1)].Glower.visible = false;
            if(this.NewsArray[_loc2_] == true)
            {
               this.m_mainMenu["node_" + (_loc2_ + 1)].Now.visible = true;
            }
            else
            {
               this.m_mainMenu["node_" + (_loc2_ + 1)].Now.visible = false;
            }
            this.m_mainMenu["node_" + (_loc2_ + 1)].Time.text = this.The_cookie.data.timesString[_loc2_];
            this.m_mainMenu["node_" + (_loc2_ + 1)].Time.visible = false;
            _loc2_++;
         }
         setChildIndex(this.m_muter,numChildren - 1);
         setChildIndex(this.m_qualiter,numChildren - 1);
         this.m_qualiter.x = 26;
      }
      
      internal function ShowNums(param1:*) : *
      {
         this.m_mainMenu.Nums.visible = true;
      }
      
      internal function HideNums(param1:*) : *
      {
         this.m_mainMenu.Nums.visible = false;
      }
      
      internal function ShowTimes(param1:*) : *
      {
         this.m_mainMenu.Times.visible = true;
      }
      
      internal function HideTimes(param1:*) : *
      {
         this.m_mainMenu.Times.visible = false;
      }
      
      internal function FliesMove(param1:Event) : *
      {
         this.m_mainMenu.flies.vx += (this.m_mainMenu.nextpos[0] - this.m_mainMenu.flies.x) / 5;
         this.m_mainMenu.flies.vy += (this.m_mainMenu.nextpos[1] - this.m_mainMenu.flies.y) / 5;
         this.m_mainMenu.flies.vx *= 0.7;
         this.m_mainMenu.flies.vy *= 0.7;
         this.m_mainMenu.flies.x += this.m_mainMenu.flies.vx;
         this.m_mainMenu.flies.y += this.m_mainMenu.flies.vy;
      }
      
      internal function Glowin(param1:MouseEvent) : *
      {
         if(this.m_mainMenu.nextpos != [param1.target.x,param1.target.y])
         {
            if(this.NavisChannel != null)
            {
               this.NavisChannel.stop();
            }
            this.NavisChannel = this.NavisSound.play(0,1);
         }
         this.m_mainMenu.nextpos = [param1.target.x,param1.target.y];
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            if("b_" + this.Translation[_loc2_] == param1.target.name)
            {
               this.m_mainMenu["node_" + (_loc2_ + 1)].Glower.visible = true;
               this.m_mainMenu["node_" + (_loc2_ + 1)].Time.visible = true;
            }
            _loc2_++;
         }
      }
      
      internal function Glowout(param1:MouseEvent) : *
      {
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            if("b_" + this.Translation[_loc2_] == param1.target.name)
            {
               this.m_mainMenu["node_" + (_loc2_ + 1)].Time.visible = false;
               this.m_mainMenu["node_" + (_loc2_ + 1)].Glower.visible = false;
            }
            _loc2_++;
         }
      }
      
      public function Recuent() : *
      {
         var w:*;
         var i:*;
         var Points:* = undefined;
         this.PlayingMusic = false;
         this.MusicChannel.stop();
         this.m_level.StopSounds();
         this.FinishSound1 = new Finish1();
         this.FinishSound2 = new Finish2();
         trace("A");
         if(this.cur_type == 3)
         {
            this.FinishSound2.play(0,1);
         }
         else
         {
            this.FinishSound1.play(0,1);
         }
         w = 0;
         while(w < this.m_level.windChannels.length)
         {
            this.m_level.windChannels[w].stop();
            w++;
         }
         this.RecuentBoard = new Recuento();
         addChild(this.RecuentBoard);
         this.RecuentBoard.StartEase();
         this.RecuentBoard.Rboard.ToMenuBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            EndGame();
            removeChild(RecuentBoard);
         });
         this.RecuentBoard.Rboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.RecuentBoard.Rboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.RecuentBoard.Rboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.LoadHiscore);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.ToMenuPress);
         trace("B");
         if(this.cur_type == 2)
         {
            this.RecuentBoard.Rboard.RDcounter.visible = false;
            this.RecuentBoard.Rboard.BDcounter.visible = false;
            this.RecuentBoard.Rboard.GDcounter.visible = true;
            this.RecuentBoard.Rboard.GDcounter.gd.text = this.m_level.myContactListener.GreenCount;
         }
         else
         {
            this.RecuentBoard.Rboard.RDcounter.visible = true;
            this.RecuentBoard.Rboard.BDcounter.visible = true;
            this.RecuentBoard.Rboard.GDcounter.visible = false;
            this.RecuentBoard.Rboard.BDcounter.bd.text = this.m_level.myContactListener.BlueCount;
            this.RecuentBoard.Rboard.RDcounter.rd.text = this.m_level.myContactListener.RedCount;
         }
         trace("C");
         this.RecuentBoard.Rboard.Result.A.visible = false;
         this.RecuentBoard.Rboard.Result.B.visible = false;
         this.RecuentBoard.Rboard.Result.C.visible = false;
         this.RecuentBoard.Rboard.Result.F.visible = false;
         this.RecuentBoard.Rboard.time.text = this.m_timer.mins.text + " : " + this.m_timer.secs.text;
         if(this.cur_type == 2)
         {
            if(this.m_level.myContactListener.GreenCount == 1)
            {
               Points = 1;
               if(parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text) <= this.TimeTable[this.cur_node - 1])
               {
                  Points += 1;
               }
               if(this.The_cookie.data.stats[this.cur_node - 1] <= Points + 1)
               {
                  if(this.The_cookie.data.stats[this.cur_node - 1] < Points + 1 || this.The_cookie.data.times[this.cur_node - 1] > parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text))
                  {
                     this.The_cookie.data.times[this.cur_node - 1] = parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text);
                     this.The_cookie.data.timesString[this.cur_node - 1] = this.m_timer.mins.text + ":" + this.m_timer.secs.text;
                  }
                  this.The_cookie.data.stats[this.cur_node - 1] = Points + 1;
               }
               switch(Points)
               {
                  case 0:
                     this.RecuentBoard.Rboard.Result.C.visible = true;
                     break;
                  case 1:
                     this.RecuentBoard.Rboard.Result.B.visible = true;
                     break;
                  case 2:
                     this.RecuentBoard.Rboard.Result.A.visible = true;
               }
            }
            else
            {
               this.RecuentBoard.Rboard.Result.F.visible = true;
            }
         }
         else
         {
            Points = 0;
            if(parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text) <= this.TimeTable[this.cur_node - 1])
            {
               Points += 1;
            }
            if(this.m_level.myContactListener.BlueCount == this.m_level.BDcount && this.m_level.myContactListener.RedCount == this.m_level.RDcount)
            {
               Points += 1;
            }
            if(this.The_cookie.data.stats[this.cur_node - 1] <= 1 + Points)
            {
               if(this.The_cookie.data.stats[this.cur_node - 1] < 1 + Points || this.The_cookie.data.times[this.cur_node - 1] > parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text))
               {
                  this.The_cookie.data.times[this.cur_node - 1] = parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text);
                  this.The_cookie.data.timesString[this.cur_node - 1] = this.m_timer.mins.text + ":" + this.m_timer.secs.text;
               }
               this.The_cookie.data.stats[this.cur_node - 1] = 1 + Points;
            }
            switch(Points)
            {
               case 0:
                  this.RecuentBoard.Rboard.Result.C.visible = true;
                  break;
               case 1:
                  this.RecuentBoard.Rboard.Result.B.visible = true;
                  break;
               case 2:
                  this.RecuentBoard.Rboard.Result.A.visible = true;
            }
         }
         trace("D");
         i = 0;
         while(i < this.ln)
         {
            if(this.Adjacencies[this.cur_node - 1][i] == 1 && this.The_cookie.data.stats[i] == -1)
            {
               this.NewsArray[i] = true;
               this.The_cookie.data.stats[i] = 0;
            }
            i++;
         }
         trace("E");
      }
      
      public function GameOver() : *
      {
         var w:*;
         this.PlayingMusic = false;
         this.MusicChannel.stop();
         this.m_level.StopSounds();
         this.m_level.FBChannel.stop();
         this.m_level.WGChannel.stop();
         this.GameOverBoard = new GameOvero();
         w = 0;
         while(w < this.m_level.windChannels.length)
         {
            this.m_level.windChannels[w].stop();
            w++;
         }
         addChild(this.GameOverBoard);
         this.GameOverBoard.StartEase();
         this.GameOverBoard.GOboard.ToMenuBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            EndGame();
            removeChild(GameOverBoard);
         });
         this.GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            RetryGame();
            removeChild(GameOverBoard);
         });
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.RetryPress);
         this.GameOverBoard.GOboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.LoadHiscore);
      }
      
      public function ToMenuPress(param1:*) : *
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == Keyboard.SPACE)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.ToMenuPress);
            trace("ENTERO");
            this.EndGame();
            removeChild(this.RecuentBoard);
         }
      }
      
      public function RetryPress(param1:*) : *
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == Keyboard.SPACE)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.RetryPress);
            trace("ENTERO");
            this.RetryGame();
            removeChild(this.GameOverBoard);
         }
      }
      
      internal function TimerUpdate(param1:Event) : *
      {
         if(this.m_level.pause == false)
         {
            this.m_timer.currentTime = getTimer() - this.m_timer.startTime;
         }
         else
         {
            this.m_timer.startTime = getTimer() - this.m_timer.currentTime;
         }
         this.m_timer.m = Math.floor(this.m_timer.currentTime / 60000);
         this.m_timer.s = Math.floor((this.m_timer.currentTime - this.m_timer.m * 60000) / 1000);
         this.m_timer.ms = Math.floor((this.m_timer.currentTime - this.m_timer.m * 60000 - this.m_timer.s * 1000) / 100);
         if(this.m_timer.m <= 9)
         {
            this.m_timer.mins.text = "0" + String(this.m_timer.m);
         }
         else
         {
            this.m_timer.mins.text = String(this.m_timer.m);
         }
         if(this.m_timer.s <= 9)
         {
            this.m_timer.secs.text = "0" + String(this.m_timer.s);
         }
         else
         {
            this.m_timer.secs.text = String(this.m_timer.s);
         }
         this.m_timer.cents.text = String(this.m_timer.ms);
      }
      
      private function keyPressed(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         if(param1.keyCode == 80)
         {
            if(this.m_level.ended == false)
            {
               this.m_pauseMenu.Show_Hide(param1 as MouseEvent);
            }
         }
         if(this.m_level.pause == false)
         {
            if(param1.keyCode == 114)
            {
               this.JanSatan = true;
            }
            else if(param1.keyCode == 112 && this.JanSatan == true)
            {
               _loc2_ = 0;
               while(_loc2_ < this.ln)
               {
                  this.The_cookie.data.stats[_loc2_] = 1;
                  this.The_cookie.data.times[_loc2_] = 0;
                  this.The_cookie.data.timesString[_loc2_] = "";
                  _loc2_++;
               }
            }
            else
            {
               this.JanSatan = false;
            }
            switch(param1.keyCode)
            {
               case Keyboard.UP:
                  this.m_level.u_pressed = true;
                  break;
               case Keyboard.RIGHT:
                  this.m_level.r_pressed = true;
                  break;
               case Keyboard.LEFT:
                  this.m_level.l_pressed = true;
                  break;
               case 65:
                  this.m_level.l_pressed2 = true;
                  break;
               case 68:
                  this.m_level.r_pressed2 = true;
                  break;
               case 87:
                  this.m_level.u_pressed2 = true;
            }
         }
         else
         {
            this.m_level.u_pressed = false;
            this.m_level.r_pressed = false;
            this.m_level.l_pressed = false;
            this.m_level.l_pressed2 = false;
            this.m_level.r_pressed2 = false;
            this.m_level.u_pressed2 = false;
         }
      }
      
      private function keyReleased(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.UP:
               this.m_level.u_pressed = false;
               break;
            case Keyboard.RIGHT:
               this.m_level.r_pressed = false;
               break;
            case Keyboard.LEFT:
               this.m_level.l_pressed = false;
               break;
            case 65:
               this.m_level.l_pressed2 = false;
               break;
            case 68:
               this.m_level.r_pressed2 = false;
               break;
            case 87:
               this.m_level.u_pressed2 = false;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
