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
   import Playtomic.*;
   import com.adobe.serialization.json.JSON;
   import com.spilgames.api.AwardsService;
   import com.spilgames.api.DataService;
   import com.spilgames.api.ScoreService;
   import com.spilgames.api.SpilGamesServices;
   import com.spilgames.bs.BrandingManager;
   import com.spilgames.bs.comps.LanguageSelect;
   import com.spilgames.bs.comps.Logo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Game extends MovieClip
   {
       
      
      public var Startbutton:StartBtn;
      
      public var LoaderMC:MovieClip;
      
      public var txt3:TextField;
      
      public var LoaderInstance:LoaderHolder;
      
      internal var JanSatan:* = false;
      
      internal var ln:* = 40;
      
      internal var score:*;
      
      internal var Teaser:*;
      
      internal var m_level:level;
      
      internal var m_timer:Watch;
      
      internal var m_muter:Muter;
      
      internal var m_logoHolder:Sprite;
      
      internal var m_walker:*;
      
      internal var m_morer:*;
      
      internal var m_qualiter:Qualiter;
      
      internal var m_pauseMenu:PauseMenu;
      
      internal var m_mainMenu:MainMenu;
      
      internal var m_introMenu:IntroMenu;
      
      internal var m_fps:*;
      
      internal var m_transition:Trans;
      
      internal var m_nodeTree:MovieClip;
      
      internal var GameOverBoard:*;
      
      internal var RecuentBoard:*;
      
      internal var window:b2Vec2;
      
      internal var currentsize:b2Vec2;
      
      internal var zoom:* = 1;
      
      internal var vzoom:* = 0;
      
      internal var cur_type:Number;
      
      internal var cur_lev:Number;
      
      internal var cur_node:Number;
      
      internal var The_cookie:*;
      
      internal var Translation:Array;
      
      internal var Adjacencies:Array;
      
      internal var TimeTable:Array;
      
      internal var NewsArray:Array;
      
      internal var NavisSound:Navis_Sound;
      
      internal var NavisChannel:SoundChannel;
      
      internal var OverSound:Over_Sound;
      
      internal var ClickSound:Pusher_Sound;
      
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
      
      internal var useJson:Boolean = true;
      
      private const JsonData:Class = Game_JsonData;
      
      internal var SharedLevelsArray:Object;
      
      internal var Muted:Boolean;
      
      public var brandingManager:BrandingManager;
      
      public function Game()
      {
         var myMenu:ContextMenu;
         var levelsCookie:*;
         var bytes:ByteArray;
         var jsonObject:Object;
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         myMenu = new ContextMenu();
         myMenu.hideBuiltInItems();
         contextMenu = myMenu;
         this["LoaderInstance"].visible = false;
         try
         {
            this.APISetup();
         }
         catch(error:*)
         {
            trace("EMERGENCY ADS");
            CreatePreloader(true);
         }
         levelsCookie = SharedObject.getLocal("FB4","/");
         bytes = new this.JsonData() as ByteArray;
         jsonObject = com.adobe.serialization.json.JSON.decode(bytes.readUTFBytes(bytes.length));
         if(!this.useJson)
         {
            this.SharedLevelsArray = levelsCookie.data.LevelsArray;
         }
         else
         {
            this.SharedLevelsArray = jsonObject;
         }
         trace("EMBEDED JSON DATA  LEVEL 0: " + jsonObject[0]);
      }
      
      public function APISetup() : void
      {
         var _loc1_:SpilGamesServices = SpilGamesServices.getInstance();
         this.brandingManager = BrandingManager.getInstance();
         _loc1_.addEventListener(SpilGamesServices.SERVICES_READY,this.onServicesReady);
         _loc1_.addEventListener(SpilGamesServices.SERVICE_ERROR,this.onServicesReady);
         this.brandingManager.addEventListener(SpilGamesServices.COMPONENTS_READY,this.onBrandingComponentsReady);
         _loc1_.connect(this,"f3eea80c7627f4ee2b907453156f4fb1",false,new LocalizationPack());
      }
      
      public function onServicesReady(param1:Event) : void
      {
         trace("onServicesReady");
         if(this.ValidateLocation())
         {
            this.CreatePreloader(false);
         }
         else
         {
            this.CreatePreloader(!param1.target.isDomainAllowed());
         }
      }
      
      public function onBrandingComponentsReady(param1:Event) : void
      {
         trace("onComponentsReady");
      }
      
      public function ValidateLocation() : *
      {
         var _loc1_:* = ["kongregate.com"];
         trace("currentURL " + this.loaderInfo.loaderURL);
         var _loc2_:* = this.loaderInfo.loaderURL.split("/")[2];
         trace("currentDomain " + _loc2_);
         var _loc3_:* = false;
         var _loc4_:* = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(_loc2_.lastIndexOf(_loc1_[_loc4_]) >= 0)
            {
               _loc3_ = true;
            }
            _loc4_++;
         }
         trace("LOCATION IS VALID = " + _loc3_);
         return _loc3_;
      }
      
      public function setLocalData() : void
      {
         var _loc1_:* = undefined;
         this.The_cookie = SharedObject.getLocal("FBCookie");
         if(!this.The_cookie.data.awards)
         {
            this.The_cookie.data.awards = new Object();
            this.The_cookie.data.awards["ten"] = false;
            this.The_cookie.data.awards["all"] = false;
            this.The_cookie.data.awards["tenA"] = false;
            this.The_cookie.data.awards["allA"] = false;
         }
         if(this.The_cookie.data.stats == undefined)
         {
            this.The_cookie.data.submited = 0;
            this.The_cookie.data.stats = new Array(this.ln);
            this.The_cookie.data.times = new Array(this.ln);
            this.The_cookie.data.timesString = new Array(this.ln);
            _loc1_ = 0;
            while(_loc1_ < this.ln)
            {
               this.The_cookie.data.stats[_loc1_] = -1;
               this.The_cookie.data.times[_loc1_] = 0;
               this.The_cookie.data.timesString[_loc1_] = "";
               _loc1_++;
            }
            this.The_cookie.data.stats[0] = 3;
            this.The_cookie.data.stats[29] = 0;
            this.The_cookie.data.stats[32] = 0;
            this.The_cookie.data.stats[33] = 0;
            this.The_cookie.data.stats[34] = 0;
         }
      }
      
      public function getSavedData() : void
      {
         this.setLocalData();
      }
      
      public function myDataIDCallback(param1:int, param2:Object) : void
      {
         if(param2.success)
         {
            trace("Data ID: " + param2.dataID);
            if(DataService.isAvailable())
            {
               DataService.loadData(param2.dataID,this.myDataCallback);
            }
         }
         else
         {
            this.setLocalData();
            this.saveCurrentData();
         }
      }
      
      public function myDataCallback(param1:int, param2:Object) : void
      {
         if(param2.succes)
         {
            trace("Data: " + param2.xml.data);
         }
      }
      
      public function saveCurrentData() : void
      {
         var _loc1_:* = com.adobe.serialization.json.JSON.encode(this.The_cookie.data);
         var _loc2_:XML = new XML(_loc1_);
         if(DataService.isAvailable())
         {
            trace("saving data");
            DataService.saveData(_loc2_);
         }
      }
      
      public function GameReady() : *
      {
         var _loc2_:* = undefined;
         MochiBot.track(this,"255de103");
         this.gotoAndStop(2);
         this.Muted = false;
         this.Translation = new Array("1_1","1_2","3_1","1_3","1_4","3_2","2_1","1_5","1_6","1_7","2_2","3_3","2_3","3_5","1_13","3_6","2_4","1_14","1_16","2_5","1_15","1_17","2_6","1_10","1_11","3_4","2_7","1_12","2_8","1_8","1_9","2_9","4_1","4_2","4_3","1_18","1_19","4_6","2_10","2_11","3_7");
         this.NewsArray = new Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false);
         this.TimeTable = new Array(0,25,60,55,50,110,70,70,50,55,70,40,50,55,45,45,50,50,40,25,75,80,75,55,95,50,130,40,65,40,35,35,35,30,40,75,35,55,70,90);
         this.NavisSound = new Navis_Sound();
         this.OverSound = new Over_Sound();
         this.ClickSound = new Pusher_Sound();
         this.MenuSound = new Menu_Sound();
         this.AdvSound = new Adv_Sound();
         this.SpeedSound = new Speed_Sound();
         this.DarkSound = new Dark_Sound();
         trace("GOING TO GET DATA");
         this.getSavedData();
         this.Adjacencies = new Array(this.ln);
         var _loc1_:* = 0;
         while(_loc1_ < this.ln)
         {
            this.Adjacencies[_loc1_] = new Array(this.ln);
            _loc2_ = 0;
            while(_loc2_ < this.ln)
            {
               this.Adjacencies[_loc1_][_loc2_] = 0;
               _loc2_++;
            }
            _loc1_++;
         }
         this.Adjacencies[29][37] = 1;
         this.Adjacencies[29][18] = 1;
         this.Adjacencies[29][39] = 1;
         this.Adjacencies[37][38] = 1;
         this.Adjacencies[37][8] = 1;
         this.Adjacencies[37][16] = 1;
         this.Adjacencies[37][18] = 1;
         this.Adjacencies[39][18] = 1;
         this.Adjacencies[39][9] = 1;
         this.Adjacencies[39][28] = 1;
         this.Adjacencies[39][36] = 1;
         this.Adjacencies[1][16] = 1;
         this.Adjacencies[1][9] = 1;
         this.Adjacencies[1][18] = 1;
         this.Adjacencies[1][4] = 1;
         this.Adjacencies[15][8] = 1;
         this.Adjacencies[15][5] = 1;
         this.Adjacencies[15][11] = 1;
         this.Adjacencies[15][16] = 1;
         this.Adjacencies[23][19] = 1;
         this.Adjacencies[23][35] = 1;
         this.Adjacencies[23][36] = 1;
         this.Adjacencies[23][9] = 1;
         this.Adjacencies[38][22] = 1;
         this.Adjacencies[38][8] = 1;
         this.Adjacencies[28][36] = 1;
         this.Adjacencies[28][20] = 1;
         this.Adjacencies[31][4] = 1;
         this.Adjacencies[31][11] = 1;
         this.Adjacencies[31][25] = 1;
         this.Adjacencies[31][17] = 1;
         this.Adjacencies[31][19] = 1;
         this.Adjacencies[7][11] = 1;
         this.Adjacencies[7][4] = 1;
         this.Adjacencies[12][4] = 1;
         this.Adjacencies[12][19] = 1;
         this.Adjacencies[30][5] = 1;
         this.Adjacencies[30][3] = 1;
         this.Adjacencies[30][10] = 1;
         this.Adjacencies[30][25] = 1;
         this.Adjacencies[21][25] = 1;
         this.Adjacencies[21][11] = 1;
         this.Adjacencies[13][10] = 1;
         this.Adjacencies[13][27] = 1;
         this.Adjacencies[13][35] = 1;
         this.Adjacencies[13][17] = 1;
         this.Adjacencies[6][25] = 1;
         this.Adjacencies[6][17] = 1;
         this.Adjacencies[14][17] = 1;
         this.Adjacencies[14][19] = 1;
         this.Adjacencies[20][35] = 1;
         this.Adjacencies[20][27] = 1;
         this.Adjacencies[20][2] = 1;
         this.Adjacencies[20][36] = 1;
         this.Adjacencies[22][8] = 1;
         this.Adjacencies[22][5] = 1;
         this.Adjacencies[22][3] = 1;
         this.Adjacencies[22][26] = 1;
         this.Adjacencies[3][26] = 1;
         this.Adjacencies[3][24] = 1;
         this.Adjacencies[27][2] = 1;
         this.Adjacencies[27][24] = 1;
         this.Adjacencies[24][26] = 1;
         this.Adjacencies[24][10] = 1;
         this.Adjacencies[24][2] = 1;
         trace("ADJACENTIES OK");
         _loc1_ = 0;
         while(_loc1_ < this.ln)
         {
            _loc2_ = 0;
            while(_loc2_ < this.ln)
            {
               if(this.Adjacencies[_loc1_][_loc2_] == 1)
               {
                  this.Adjacencies[_loc2_][_loc1_] = 1;
               }
               _loc2_++;
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
      
      public function CreatePreloader(param1:Boolean) : *
      {
         var _loc2_:* = new PreLoader(this,param1);
         this.addChild(_loc2_);
      }
      
      public function CreateTeaser() : *
      {
         if(Boolean(SoundMixer) && Boolean(SoundMixer.soundTransform))
         {
            trace("Setting volume");
            SoundMixer.soundTransform = new SoundTransform(1);
         }
         this.Teaser = new ATenTeaser();
         this.Teaser.teaserMC.addEventListener("teaserOut",this.TeaserOut);
         this.Teaser.addEventListener(MouseEvent.MOUSE_DOWN,this.TeaserClick);
         this.addChild(this.Teaser);
         trace("TEASER ADDED " + this.Teaser.teaserMC);
         this.Teaser.teaserMC.gotoAndPlay(2);
      }
      
      internal function handleGameManagerReady(param1:Event) : void
      {
      }
      
      public function TeaserClick(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.a10.com/");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function TeaserOut(param1:Event) : *
      {
         trace("TEASER OUTING");
         if(this.Teaser)
         {
            param1.target.removeEventListener("teaserOut",this.TeaserOut);
            this.removeChild(this.Teaser);
         }
         this.GameReady();
      }
      
      public function MoreGames(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.a10.com/");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function MoreGames2(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://www.a10.com/");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function WalkThroughLink(param1:MouseEvent) : *
      {
         Link.Open("http://www.a10.com/walkthrough-games/fireboy-and-watergirl-4-the-crystal-temple-walkthrough","Walkthrough","Menu");
      }
      
      internal function StartGameBtn(param1:MouseEvent) : *
      {
         this.PlayingMusic = false;
         this.MusicChannel.stop();
         new Pusher_Sound().play(0,1);
         trace(param1.target.name);
         var _loc2_:Number = Number(param1.target.name.substring(param1.target.name.indexOf("_") + 1,param1.target.name.length));
         trace("TARGETO " + param1.target.name);
         trace("LEVEL NUMBER " + _loc2_);
         this.cur_lev = _loc2_;
         this.cur_node = _loc2_;
         this.NewsArray[this.cur_node] = false;
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
            this.StartGame(this.cur_lev);
            this.m_transition.removeEventListener(Event.ENTER_FRAME,this.Transit);
            removeChild(this.m_transition);
         }
      }
      
      public function StartGame(param1:Number) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = com.adobe.serialization.json.JSON.decode(this.SharedLevelsArray[param1 - 1]);
         trace("STARTING LEVEL OF TYPE " + _loc2_.LevelType);
         switch(_loc2_.LevelType)
         {
            case "a":
               _loc3_ = 1;
               break;
            case "p":
               _loc3_ = 2;
               break;
            case "s":
               _loc3_ = 3;
               break;
            default:
               _loc3_ = 1;
         }
         this.cur_type = _loc3_;
         if(this.PlayingMusic != true)
         {
            this.PlayingMusic = true;
            this.MusicChannel.stop();
            if(_loc3_ == 1 || _loc3_ == 2)
            {
               this.MusicChannel = this.AdvSound.play(0,999);
            }
            else if(_loc3_ == 3)
            {
               this.MusicChannel = this.SpeedSound.play(0,999);
            }
            else
            {
               this.MusicChannel = this.DarkSound.play(0,999);
            }
         }
         this.m_level = new level(param1);
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
         this.m_logoHolder = new Logo();
         this.addChild(this.m_logoHolder);
         this.m_logoHolder.x = -25;
         this.m_logoHolder.y = 5;
         this.m_logoHolder.scaleX = 0.7;
         this.m_logoHolder.scaleY = 0.7;
         this.m_morer = new Sprite();
         this.m_morer.addChild(new MorerBtn());
         this.m_morer.scaleX = 0.7;
         this.m_morer.scaleY = 0.7;
         this.addChild(this.m_morer);
         this.m_morer.x = this.m_morer.width / 2;
         this.m_morer.y = 463;
         this.m_morer.addEventListener(MouseEvent.MOUSE_DOWN,this.MoreGames);
         this.m_walker = new Sprite();
         this.m_walker.addChild(new WalkerBtn());
         this.m_walker.scaleX = 0.7;
         this.m_walker.scaleY = 0.7;
         this.addChild(this.m_walker);
         this.m_walker.x = 640 - this.m_morer.width / 2;
         this.m_walker.y = 463;
         this.m_walker.addEventListener(MouseEvent.MOUSE_DOWN,this.WalkThroughLink);
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
         this.m_level.StopSounds();
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
         removeChild(this.m_logoHolder);
         removeChild(this.m_morer);
         removeChild(this.m_walker);
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
         this.StartGame(this.cur_lev);
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
         this.m_introMenu.Buttons.Starter.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.CLICK,this.LoadInstructions);
         this.m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Walker.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Walker.addEventListener(MouseEvent.CLICK,this.WalkThroughLink);
         this.m_introMenu.Buttons.Walker.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Morer.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Morer.addEventListener(MouseEvent.CLICK,this.MoreGames2);
         this.m_introMenu.Buttons.Morer.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.MOUSE_DOWN,this.LoadCredits);
         this.m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.CLICK,this.ClickSounder);
         this.m_introMenu.Buttons.Forester.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Forester.addEventListener(MouseEvent.CLICK,this.PlayForest);
         this.m_introMenu.Buttons.Forester.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Lighter.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Lighter.addEventListener(MouseEvent.CLICK,this.PlayLight);
         this.m_introMenu.Buttons.Lighter.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Icer.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Icer.addEventListener(MouseEvent.CLICK,this.PlayIce);
         this.m_introMenu.Buttons.Icer.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.Buttons.Adder.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.m_introMenu.Buttons.Adder.addEventListener(MouseEvent.CLICK,this.AddToSite);
         this.m_introMenu.Buttons.Adder.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.m_introMenu.sponsorLogoHolder.setCenter();
         if(this.m_muter)
         {
            setChildIndex(this.m_muter,numChildren - 1);
         }
         if(this.m_qualiter)
         {
            setChildIndex(this.m_qualiter,numChildren - 1);
         }
         var _loc1_:LanguageSelect = new LanguageSelect();
         this.brandingManager.addEventListener(SpilGamesServices.LOCALE_CHANGED,this.changedLanguage);
         _loc1_.x = 640 - _loc1_.width;
         _loc1_.y = 480 - _loc1_.height;
         this.m_introMenu.addChild(_loc1_);
      }
      
      public function changedLanguage(param1:Event) : *
      {
         trace("Language CHANGE");
         removeChild(this.m_introMenu);
         this.BackToIntro(new MouseEvent("caca"));
      }
      
      public function ShowHiscore(param1:*) : *
      {
      }
      
      public function OverSounder(param1:MouseEvent) : *
      {
         this.OverSound.play(0,1);
      }
      
      public function ClickSounder(param1:MouseEvent) : *
      {
         this.ClickSound.play(0,1);
      }
      
      public function GoAwards(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://www.a10.com/puzzle-games/fireboy-and-watergirl-4-the-crystal-temple");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function AddToSite(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = new URLRequest(this.brandingManager.getAddToSiteLink());
         navigateToURL(_loc2_,"_blank");
      }
      
      public function PlayForest(param1:MouseEvent) : *
      {
         Link.Open("http://www.a10.com/puzzle-games/fireboy-and-watergirl-the-forest-temple","CrossPromo_FBWG1","Menu");
      }
      
      public function PlayLight(param1:MouseEvent) : *
      {
         Link.Open("http://www.a10.com/puzzle-games/fireboy-and-watergirl-2-the-light-temple","CrossPromo_FBWG2","Menu");
      }
      
      public function PlayIce(param1:MouseEvent) : *
      {
         Link.Open("http://www.a10.com/puzzle-games/fireboy-and-watergirl-3-ice-temple","CrossPromo_FBWG3","Menu");
      }
      
      public function SendScore() : void
      {
         var _loc1_:* = this.CalculateScore();
         trace("subbmitting score: " + _loc1_);
         if(ScoreService.isAvailable())
         {
            ScoreService.submitScore(_loc1_,this.scoreCallBack);
         }
         else
         {
            trace("SCORESERVICE NOT AVAILABLE");
         }
         var _loc2_:Object = this.CalculateAwards();
         trace("awards " + _loc2_["ten"] + " " + _loc2_["all"] + " " + _loc2_["tenA"] + " " + _loc2_["allA"]);
         if(AwardsService.isAvailable())
         {
            if(Boolean(_loc2_["ten"]) && this.The_cookie.data.awards["ten"] == false)
            {
               this.The_cookie.data.awards["ten"] = true;
               AwardsService.submitAward("award1",this.awardCallBack);
            }
            if(Boolean(_loc2_["all"]) && this.The_cookie.data.awards["all"] == false)
            {
               this.The_cookie.data.awards["all"] = true;
               AwardsService.submitAward("award3",this.awardCallBack);
            }
            if(Boolean(_loc2_["tenA"]) && this.The_cookie.data.awards["tenA"] == false)
            {
               this.The_cookie.data.awards["tenA"] = true;
               AwardsService.submitAward("award2",this.awardCallBack);
            }
            if(Boolean(_loc2_["allA"]) && this.The_cookie.data.awards["allA"] == false)
            {
               this.The_cookie.data.awards["allA"] = true;
               AwardsService.submitAward("award4",this.awardCallBack);
            }
         }
      }
      
      internal function awardCallBack(param1:int, param2:Object) : void
      {
         if(!param2.success)
         {
            trace(param2.errorMessage);
         }
         else
         {
            trace("Award submitted: " + param2.xml);
            trace("Awards saved " + this.The_cookie.data.awards["ten"] + " " + this.The_cookie.data.awards["allA"]);
         }
      }
      
      internal function scoreCallBack(param1:int, param2:Object) : void
      {
         if(!param2.success)
         {
            trace(param2.errorMessage);
         }
         else
         {
            trace("Score submitted: " + param2.xml);
         }
      }
      
      public function CalculateScore() : Number
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            _loc1_ += Math.max(this.The_cookie.data.stats[_loc2_] * 360,0);
            if(this.The_cookie.data.times[_loc2_] != 0)
            {
               _loc1_ += Math.max((this.TimeTable[_loc2_] - this.The_cookie.data.times[_loc2_]) * 12,0);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function CalculateAwards() : Object
      {
         var _loc1_:* = {
            "all":false,
            "allA":false,
            "ten":false,
            "tenA":false
         };
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 1;
         while(_loc4_ < this.ln)
         {
            if(this.The_cookie.data.stats[_loc4_] > 0)
            {
               _loc2_++;
            }
            if(this.The_cookie.data.stats[_loc4_] == 3)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         trace("COUNT AND ACOUNT" + _loc2_ + " " + _loc3_ + " TOTAL " + this.ln);
         if(_loc2_ > 9)
         {
            _loc1_["ten"] = true;
         }
         if(_loc2_ == this.ln - 1)
         {
            _loc1_["all"] = true;
         }
         if(_loc3_ > 9)
         {
            _loc1_["tenA"] = true;
         }
         if(_loc3_ == this.ln - 1)
         {
            _loc1_["allA"] = true;
         }
         return _loc1_;
      }
      
      public function LoadHiscore(param1:MouseEvent) : *
      {
         var _loc2_:* = 0;
         this.score = 0;
         var _loc3_:* = 0;
         while(_loc3_ < 32)
         {
            this.score += Math.max(this.The_cookie.data.stats[_loc3_] * 360,0);
            if(this.The_cookie.data.times[_loc3_] != 0)
            {
               this.score += Math.max((this.TimeTable[_loc3_] - this.The_cookie.data.times[_loc3_]) * 12,0);
            }
            _loc3_++;
         }
         _loc2_ = this.score;
         var _loc4_:* = true;
         _loc3_ = 0;
         while(_loc3_ < 32)
         {
            if(this.The_cookie.data.stats[_loc3_] <= 0)
            {
               _loc4_ = false;
            }
            _loc3_++;
         }
         trace("SCORE " + this.score);
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
         this.The_cookie = SharedObject.getLocal("FBCookie");
         this.The_cookie.data.awards = new Object();
         this.The_cookie.data.awards["ten"] = false;
         this.The_cookie.data.awards["all"] = false;
         this.The_cookie.data.awards["tenA"] = false;
         this.The_cookie.data.awards["allA"] = false;
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
         this.The_cookie.data.stats[0] = 3;
         this.The_cookie.data.stats[29] = 0;
         this.The_cookie.data.stats[32] = 0;
         this.The_cookie.data.stats[33] = 0;
         this.The_cookie.data.stats[34] = 0;
      }
      
      public function SpecialData1(param1:MouseEvent) : *
      {
         this.The_cookie = SharedObject.getLocal("FBCookie");
         this.The_cookie.data.awards = new Object();
         this.The_cookie.data.awards["ten"] = false;
         this.The_cookie.data.awards["all"] = false;
         this.The_cookie.data.awards["tenA"] = false;
         this.The_cookie.data.awards["allA"] = false;
         this.The_cookie.data.submited = 0;
         this.The_cookie.data.stats = new Array(this.ln);
         this.The_cookie.data.times = new Array(this.ln);
         this.The_cookie.data.timesString = new Array(this.ln);
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            this.The_cookie.data.stats[_loc2_] = 1;
            this.The_cookie.data.times[_loc2_] = 0;
            this.The_cookie.data.timesString[_loc2_] = "";
            _loc2_++;
         }
         this.The_cookie.data.stats[0] = 3;
         this.The_cookie.data.stats[29] = 0;
      }
      
      public function SpecialData2(param1:MouseEvent) : *
      {
         this.The_cookie = SharedObject.getLocal("FBCookie");
         this.The_cookie.data.awards = new Object();
         this.The_cookie.data.awards["ten"] = false;
         this.The_cookie.data.awards["all"] = false;
         this.The_cookie.data.awards["tenA"] = false;
         this.The_cookie.data.awards["allA"] = false;
         this.The_cookie.data.submited = 0;
         this.The_cookie.data.stats = new Array(this.ln);
         this.The_cookie.data.times = new Array(this.ln);
         this.The_cookie.data.timesString = new Array(this.ln);
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            this.The_cookie.data.stats[_loc2_] = 3;
            this.The_cookie.data.times[_loc2_] = 0;
            this.The_cookie.data.timesString[_loc2_] = "";
            _loc2_++;
         }
         this.The_cookie.data.stats[0] = 3;
         this.The_cookie.data.stats[29] = 1;
      }
      
      public function LoadInstructions(param1:MouseEvent) : *
      {
         if(!this.instr)
         {
            this.instr = new Instructions();
            addChild(this.instr);
            this.instr.OKO.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
            this.instr.OKO.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
            this.instr.OKO.addEventListener(MouseEvent.CLICK,this.UnLoadInstructions);
         }
      }
      
      public function UnLoadInstructions(param1:MouseEvent) : *
      {
         removeChild(this.instr);
         this.instr = null;
      }
      
      public function LoadCredits(param1:MouseEvent) : *
      {
         if(!this.crd)
         {
            this.crd = new Credits();
            addChild(this.crd);
            this.crd.OKO.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
            this.crd.OKO.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
            this.crd.OKO.addEventListener(MouseEvent.CLICK,this.UnLoadCredits);
         }
      }
      
      public function UnLoadCredits(param1:MouseEvent) : *
      {
         removeChild(this.crd);
         this.crd = null;
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
         var evt:Event = param1;
         this.m_transition.alpha += 0.1;
         if(this.m_transition.alpha > 1)
         {
            try
            {
               removeChild(this.m_mainMenu);
            }
            catch(error:*)
            {
               trace("controlled error");
            }
            this.CreateIntroMenu();
            this.m_transition.removeEventListener(Event.ENTER_FRAME,this.Transit3);
            removeChild(this.m_transition);
         }
      }
      
      public function CreateMainMenu() : *
      {
         var _loc3_:* = undefined;
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
         this.m_mainMenu.BackToIntro.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         if(!this.m_nodeTree)
         {
            this.CreateNodeTree();
         }
         this.m_mainMenu.addChild(this.m_nodeTree);
         this.m_mainMenu.Times = this.CreateTimes();
         this.m_mainMenu.Nums = new NumsSprite();
         this.m_mainMenu.addChild(this.m_mainMenu.Times);
         this.m_mainMenu.addChild(this.m_mainMenu.Nums);
         this.m_mainMenu.Nums.visible = false;
         this.m_mainMenu.Times.visible = false;
         this.m_mainMenu.ShowLevNum.addEventListener(MouseEvent.MOUSE_OVER,this.ShowNums);
         this.m_mainMenu.ShowLevNum.addEventListener(MouseEvent.MOUSE_OUT,this.HideNums);
         this.m_mainMenu.ShowLevTimes.addEventListener(MouseEvent.MOUSE_OVER,this.ShowTimes);
         this.m_mainMenu.ShowLevTimes.addEventListener(MouseEvent.MOUSE_OUT,this.HideTimes);
         var _loc1_:SpilGamesServices = SpilGamesServices.getInstance();
         if(_loc1_.isDomainAllowed())
         {
            this.m_mainMenu.Awarder.visible = false;
         }
         this.m_mainMenu.Awarder.addEventListener(MouseEvent.MOUSE_DOWN,this.GoAwards);
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            if(this.The_cookie.data.stats[_loc2_] >= 0)
            {
               this.m_nodeTree.Golden_road["node_" + _loc2_].visible = true;
               this.m_nodeTree["node_" + _loc2_].addEventListener(MouseEvent.CLICK,this.StartGameBtn);
               this.m_nodeTree["node_" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,this.Glowin);
               this.m_nodeTree["node_" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.Glowout);
               switch(this.The_cookie.data.stats[_loc2_])
               {
                  case 0:
                     this.m_nodeTree["node_" + _loc2_].gotoAndStop(1);
                     break;
                  case 1:
                     this.m_nodeTree["node_" + _loc2_].gotoAndStop(2);
                     break;
                  case 2:
                     this.m_nodeTree["node_" + _loc2_].gotoAndStop(3);
                     break;
                  case 3:
                     this.m_nodeTree["node_" + _loc2_].gotoAndStop(4);
               }
               trace("b");
               if(this.The_cookie.data.stats[_loc2_] > 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < this.ln)
                  {
                     if(this.Adjacencies[_loc2_][_loc3_] == 1)
                     {
                        this.m_nodeTree.Golden_road.graphics.lineStyle(6,16763904,1);
                        this.m_nodeTree.Golden_road.graphics.moveTo(this.m_nodeTree.Golden_road["node_" + _loc2_].x,this.m_nodeTree.Golden_road["node_" + _loc2_].y);
                        this.m_nodeTree.Golden_road.graphics.lineTo(this.m_nodeTree.Golden_road["node_" + _loc3_].x,this.m_nodeTree.Golden_road["node_" + _loc3_].y);
                     }
                     _loc3_++;
                  }
               }
            }
            else
            {
               this.m_nodeTree["node_" + _loc2_].gotoAndStop(1);
               this.m_nodeTree["node_" + _loc2_].useHandCursor = false;
            }
            trace("c");
            this.m_nodeTree["node_" + _loc2_].Glower.visible = false;
            if(this.NewsArray[_loc2_] == true)
            {
               this.m_nodeTree["node_" + _loc2_].Now.visible = true;
            }
            else
            {
               this.m_nodeTree["node_" + _loc2_].Now.visible = false;
            }
            this.m_nodeTree["node_" + _loc2_].Time.text = this.The_cookie.data.timesString[_loc2_];
            this.m_nodeTree["node_" + _loc2_].Time.visible = false;
            _loc2_++;
         }
         setChildIndex(this.m_muter,numChildren - 1);
         setChildIndex(this.m_qualiter,numChildren - 1);
         this.m_qualiter.x = 26;
      }
      
      private function CreateTimes() : Sprite
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc1_:* = new Sprite();
         var _loc2_:* = 0;
         while(_loc2_ < this.ln)
         {
            trace("NODENAME " + ("node_" + _loc2_));
            trace("HERE? " + this.m_nodeTree.Golden_road["node_" + _loc2_]);
            _loc3_ = new TimeText();
            _loc4_ = String(Math.floor(this.TimeTable[_loc2_] / 60));
            _loc5_ = String(this.TimeTable[_loc2_] % 60);
            if(_loc4_.length == 1)
            {
               _loc4_ = "0" + _loc4_;
            }
            if(_loc5_.length == 1)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc3_.txt.text = _loc4_ + ":" + _loc5_;
            _loc3_.x = this.m_nodeTree.Golden_road["node_" + _loc2_].x;
            _loc3_.y = this.m_nodeTree.Golden_road["node_" + _loc2_].y;
            _loc1_.addChild(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function CreateNodeTree() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc6_:Object = null;
         var _loc7_:Class = null;
         var _loc8_:* = undefined;
         var _loc1_:* = new Array();
         this.m_nodeTree = new MovieClip();
         this.m_nodeTree.Golden_road = new NodeTree();
         this.m_nodeTree.camins1 = new NodeTree();
         this.m_nodeTree.camins2 = new NodeTree();
         trace("A");
         this.m_nodeTree.Golden_road.filters = [new BevelFilter(5,45,16776960,1,16750848,1,5,5,1,1,"inner",false),new GlowFilter(0,1,2,2,200,1,false,false)];
         this.m_nodeTree.camins1.filters = [new GlowFilter(0,1,3,3,5.62,1,true,false)];
         this.m_nodeTree.camins2.filters = [new GlowFilter(3355443,1,16,16,3,1,false,false),new BlurFilter(5,5,1)];
         this.m_nodeTree.addChild(this.m_nodeTree.camins2);
         this.m_nodeTree.addChild(this.m_nodeTree.camins1);
         this.m_nodeTree.addChild(this.m_nodeTree.Golden_road);
         trace("B-count:");
         var _loc4_:* = 0;
         while(_loc4_ < this.ln)
         {
            trace("count " + _loc4_);
            if(this.SharedLevelsArray[_loc4_ - 1])
            {
               _loc6_ = com.adobe.serialization.json.JSON.decode(this.SharedLevelsArray[_loc4_ - 1]);
            }
            else
            {
               _loc6_ = null;
            }
            if(Boolean(_loc6_) && Boolean(_loc6_.LevelType))
            {
               trace("type of " + _loc4_ + " = " + _loc6_.LevelType);
               switch(_loc6_.LevelType)
               {
                  case "a":
                     _loc2_ = new DiamondAdventure();
                     _loc7_ = DiamondAdventureFlat;
                     break;
                  case "p":
                     _loc2_ = new DiamondPuzzle();
                     _loc7_ = DiamondPuzzleFlat;
                     break;
                  case "s":
                     _loc2_ = new DiamondSpeed();
                     _loc7_ = DiamondSpeedFlat;
                     break;
                  default:
                     _loc2_ = new DiamondAdventure();
                     _loc7_ = DiamondAdventureFlat;
               }
            }
            else
            {
               trace("NO TYPE");
               _loc2_ = new DiamondAdventure();
               _loc7_ = DiamondAdventureFlat;
            }
            _loc3_ = new _loc7_();
            _loc3_.gotoAndStop(1);
            this.m_nodeTree.Golden_road["node_" + _loc4_].addChild(_loc3_);
            _loc3_ = new _loc7_();
            _loc3_.gotoAndStop(2);
            this.m_nodeTree.camins1["node_" + _loc4_].addChild(_loc3_);
            _loc3_ = new _loc7_();
            _loc3_.gotoAndStop(2);
            this.m_nodeTree.camins2["node_" + _loc4_].addChild(_loc3_);
            _loc2_.mouseChildren = false;
            _loc2_.x = this.m_nodeTree.Golden_road["node_" + _loc4_].x;
            _loc2_.y = this.m_nodeTree.Golden_road["node_" + _loc4_].y;
            _loc2_.name = "node_" + _loc4_;
            this.m_nodeTree.addChild(_loc2_);
            this.m_nodeTree["node_" + _loc4_] = _loc2_;
            _loc4_++;
         }
         trace("C");
         trace("d");
         var _loc5_:* = 0;
         while(_loc5_ < this.ln)
         {
            trace("i " + _loc5_);
            this.m_nodeTree.Golden_road["node_" + _loc5_].visible = false;
            _loc8_ = 0;
            while(_loc8_ < this.ln)
            {
               if(this.Adjacencies[_loc5_][_loc8_] == 1)
               {
                  trace("I + J " + _loc5_ + " " + _loc8_);
                  this.m_nodeTree.camins1.graphics.lineStyle(8,4473924,1);
                  this.m_nodeTree.camins1.graphics.moveTo(this.m_nodeTree.Golden_road["node_" + _loc5_].x,this.m_nodeTree.Golden_road["node_" + _loc5_].y);
                  this.m_nodeTree.camins1.graphics.lineTo(this.m_nodeTree.Golden_road["node_" + _loc8_].x,this.m_nodeTree.Golden_road["node_" + _loc8_].y);
                  this.m_nodeTree.camins2.graphics.lineStyle(11,3355443,0.36);
                  this.m_nodeTree.camins2.graphics.moveTo(this.m_nodeTree.Golden_road["node_" + _loc5_].x,this.m_nodeTree.Golden_road["node_" + _loc5_].y);
                  this.m_nodeTree.camins2.graphics.lineTo(this.m_nodeTree.Golden_road["node_" + _loc8_].x,this.m_nodeTree.Golden_road["node_" + _loc8_].y);
               }
               _loc8_++;
            }
            trace("a");
            _loc5_++;
         }
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
         param1.target.Glower.visible = true;
         param1.target.Time.visible = true;
      }
      
      internal function Glowout(param1:MouseEvent) : *
      {
         param1.target.Glower.visible = false;
         param1.target.Time.visible = false;
      }
      
      public function Recuent() : *
      {
         var w:*;
         var i:*;
         var Points:Number = NaN;
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
         this.RecuentBoard.Rboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.RecuentBoard.Rboard.sponsorLogoHolder.addEventListener(MouseEvent.MOUSE_DOWN,this.MoreGames);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.ToMenuPress);
         trace("B");
         if(this.cur_type == 2)
         {
            this.RecuentBoard.Rboard.RDcounter.visible = true;
            this.RecuentBoard.Rboard.BDcounter.visible = true;
            this.RecuentBoard.Rboard.GDcounter.visible = true;
            this.RecuentBoard.Rboard.BDcounter.bd.text = this.m_level.myContactListener.BlueCount;
            this.RecuentBoard.Rboard.RDcounter.rd.text = this.m_level.myContactListener.RedCount;
            trace("GREENCOUNT " + this.m_level.myContactListener.GreenCount);
            if(this.m_level.myContactListener.GreenCount != 1)
            {
               this.RecuentBoard.Rboard.GDcounter.gotoAndStop(2);
            }
            else
            {
               this.RecuentBoard.Rboard.GDcounter.gotoAndStop(1);
            }
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
            Points = 0;
            if(parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text) <= this.TimeTable[this.cur_node])
            {
               Points += 1;
            }
            if(this.m_level.myContactListener.BlueCount == this.m_level.BDcount && this.m_level.myContactListener.RedCount == this.m_level.RDcount)
            {
               Points += 1;
            }
            if(this.m_level.myContactListener.GreenCount != 1)
            {
               Points = -1;
            }
            if(this.The_cookie.data.stats[this.cur_node] <= 1 + Points)
            {
               if(this.The_cookie.data.stats[this.cur_node] < 1 + Points || this.The_cookie.data.times[this.cur_node] > parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text))
               {
                  this.The_cookie.data.times[this.cur_node] = parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text);
                  this.The_cookie.data.timesString[this.cur_node] = this.m_timer.mins.text + ":" + this.m_timer.secs.text;
               }
               this.The_cookie.data.stats[this.cur_node] = 1 + Points;
            }
            switch(Points)
            {
               case -1:
                  this.RecuentBoard.Rboard.Result.F.visible = true;
                  break;
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
            Points = 0;
            if(parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text) <= this.TimeTable[this.cur_node])
            {
               Points += 1;
            }
            if(this.m_level.myContactListener.BlueCount == this.m_level.BDcount && this.m_level.myContactListener.RedCount == this.m_level.RDcount)
            {
               Points += 1;
            }
            if(this.The_cookie.data.stats[this.cur_node] <= 1 + Points)
            {
               if(this.The_cookie.data.stats[this.cur_node] < 1 + Points || this.The_cookie.data.times[this.cur_node] > parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text))
               {
                  this.The_cookie.data.times[this.cur_node] = parseInt(this.m_timer.mins.text) * 60 + parseInt(this.m_timer.secs.text);
                  this.The_cookie.data.timesString[this.cur_node] = this.m_timer.mins.text + ":" + this.m_timer.secs.text;
               }
               this.The_cookie.data.stats[this.cur_node] = 1 + Points;
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
            trace("1  " + this.The_cookie.data.stats[i]);
            trace("2  " + this.NewsArray[i]);
            trace("2  " + this.Adjacencies[this.cur_node][i]);
            if(this.Adjacencies[this.cur_node][i] == 1 && this.The_cookie.data.stats[i] == -1)
            {
               this.NewsArray[i] = true;
               this.The_cookie.data.stats[i] = 0;
            }
            i++;
         }
         trace("E");
         this.SendScore();
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
         this.GameOverBoard.GOboard.WalkBtn.addEventListener(MouseEvent.CLICK,this.WalkThroughLink);
         this.GameOverBoard.GOboard.MoreBtn.addEventListener(MouseEvent.CLICK,this.MoreGames);
         this.GameOverBoard.GOboard.sponsorLogoHolder.addEventListener(MouseEvent.CLICK,this.MoreGames);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.RetryPress);
         this.GameOverBoard.GOboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.GameOverBoard.GOboard.WalkBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.MoreBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.WalkBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.GameOverBoard.GOboard.MoreBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
         this.GameOverBoard.GOboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.GameOverBoard.GOboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.LoadHiscore);
         this.GameOverBoard.GOboard.SubmitBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.ClickSounder);
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
                  this.m_level.r_isPressed = true;
                  break;
               case Keyboard.LEFT:
                  this.m_level.l_isPressed = true;
                  break;
               case 65:
                  this.m_level.l_isPressed2 = true;
                  break;
               case 68:
                  this.m_level.r_isPressed2 = true;
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
               this.m_level.r_isPressed = false;
               break;
            case Keyboard.LEFT:
               this.m_level.l_isPressed = false;
               break;
            case 65:
               this.m_level.l_isPressed2 = false;
               break;
            case 68:
               this.m_level.r_isPressed2 = false;
               break;
            case 87:
               this.m_level.u_pressed2 = false;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
