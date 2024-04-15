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
   
   public class Game extends MovieClip
   {
       
      
      private var devKey:String = "58ed9291d1ecd75f3f9fd080499bd970";
      
      internal var The_cookie:SharedObject;
      
      internal var m_fps:FPSCounter;
      
      internal var AdvSound:Adv_Sound;
      
      internal var m_mainMenu:MainMenu;
      
      internal var m_transition:Trans;
      
      internal var h:*;
      
      internal var Teaser:*;
      
      internal var OverSound:Over_Sound;
      
      internal var Translation:Array;
      
      internal var m_introMenu:IntroMenu;
      
      public var AssetHolder:MovieClip;
      
      internal var cur_node:Number;
      
      internal var PlayingMusic:Boolean;
      
      internal var score:* = 0;
      
      internal var MenuSound:Menu_Sound;
      
      internal var NavisChannel:SoundChannel;
      
      internal var TimeTable:Array;
      
      internal var instr:Instructions;
      
      internal var m_timer:Watch;
      
      internal var currentsize:b2Vec2;
      
      internal var agi:*;
      
      private var gameKey:String = "forest-temple";
      
      internal var hisc:*;
      
      internal var m_pauseMenu:PauseMenu;
      
      internal var NewsArray:Array;
      
      internal var m_muter:Muter;
      
      internal var SpeedSound:Speed_Sound;
      
      internal var m_level:level;
      
      internal var MusicChannel:SoundChannel;
      
      internal var vzoom:* = 0;
      
      internal var Muted:Boolean;
      
      internal var FinishSound1:Finish1;
      
      internal var FinishSound2:Finish2;
      
      internal var cur_lev:Number;
      
      internal var NavisSound:Navis_Sound;
      
      internal var zoom:* = 1;
      
      internal var crd:Credits;
      
      internal var cur_type:Number;
      
      internal var Adjacencies:Array;
      
      internal var window:b2Vec2;
      
      internal var nameAG:*;
      
      public function Game()
      {
         var _loc1_:ContextMenu = null;
         devKey = "58ed9291d1ecd75f3f9fd080499bd970";
         gameKey = "forest-temple";
         zoom = 1;
         vzoom = 0;
         score = 0;
         super();
         addFrameScript(0,frame1);
         _loc1_ = new ContextMenu();
         _loc1_.hideBuiltInItems();
         contextMenu = _loc1_;
         CreatePreloader();
      }
      
      public function CreateMainMenu() : *
      {
         var _loc1_:* = undefined;
         if(PlayingMusic != true)
         {
            PlayingMusic = true;
            MusicChannel = MenuSound.play(0,999);
         }
         m_mainMenu = new MainMenu();
         addChild(m_mainMenu);
         m_mainMenu.nextpos = new Array(310,452);
         m_mainMenu.oldpos = new Array(310,452);
         m_mainMenu.flies.vx = 0;
         m_mainMenu.flies.vy = 0;
         m_mainMenu.flies.addEventListener(Event.ENTER_FRAME,FliesMove);
         m_mainMenu.BackToIntro.addEventListener(MouseEvent.CLICK,BackToIntro);
         m_mainMenu.BackToIntro.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         _loc1_ = 0;
         while(_loc1_ < 32)
         {
            trace(The_cookie.data.stats);
            if(The_cookie.data.stats[_loc1_] < 0)
            {
               m_mainMenu["node_" + (_loc1_ + 1)].gotoAndStop(1);
               m_mainMenu.Golden_road["Gold_" + (_loc1_ + 1)].visible = false;
               m_mainMenu["b_" + Translation[_loc1_]].enabled = false;
               continue;
            }
            m_mainMenu["b_" + Translation[_loc1_]].addEventListener(MouseEvent.CLICK,StartGameBtn);
            m_mainMenu["b_" + Translation[_loc1_]].addEventListener(MouseEvent.ROLL_OVER,Glowin);
            m_mainMenu["b_" + Translation[_loc1_]].addEventListener(MouseEvent.ROLL_OUT,Glowout);
            switch(The_cookie.data.stats[_loc1_])
            {
               case 0:
                  m_mainMenu["node_" + (_loc1_ + 1)].gotoAndStop(1);
                  break;
               case 1:
                  m_mainMenu["node_" + (_loc1_ + 1)].gotoAndStop(2);
                  break;
               case 2:
                  m_mainMenu["node_" + (_loc1_ + 1)].gotoAndStop(3);
                  break;
               case 3:
                  m_mainMenu["node_" + (_loc1_ + 1)].gotoAndStop(4);
                  break;
            }
            m_mainMenu["node_" + (_loc1_ + 1)].Glower.visible = false;
            if(NewsArray[_loc1_] == true)
            {
               m_mainMenu["node_" + (_loc1_ + 1)].Now.visible = true;
            }
            else
            {
               m_mainMenu["node_" + (_loc1_ + 1)].Now.visible = false;
            }
            m_mainMenu["node_" + (_loc1_ + 1)].Time.text = The_cookie.data.timesString[_loc1_];
            m_mainMenu["node_" + (_loc1_ + 1)].Time.visible = false;
            _loc1_++;
         }
      }
      
      public function GameOver() : *
      {
         var GameOverBoard:* = undefined;
         var w:* = undefined;
         PlayingMusic = false;
         MusicChannel.stop();
         GameOverBoard = new GameOvero();
         w = 0;
         while(w < m_level.windChannels.length)
         {
            m_level.windChannels[w].stop();
            w++;
         }
         addChild(GameOverBoard);
         GameOverBoard.GOboard.ToMenuBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            EndGame();
            removeChild(GameOverBoard);
         });
         GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            RetryGame();
            removeChild(GameOverBoard);
         });
         GameOverBoard.GOboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         GameOverBoard.GOboard.RetryBtn.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
      }
      
      internal function closeHandler() : void
      {
         The_cookie.data.submited = true;
         removeChild(h);
      }
      
      public function CreateIntroMenu() : *
      {
         if(PlayingMusic != true)
         {
            MusicChannel = MenuSound.play(0,999);
            PlayingMusic = true;
         }
         trace("GOOD");
         m_introMenu = new IntroMenu();
         addChild(m_introMenu);
         m_introMenu.Buttons.Starter.addEventListener(MouseEvent.CLICK,LoadMenu);
         m_introMenu.Buttons.Starter.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         m_introMenu.Buttons.Instructer.addEventListener(MouseEvent.CLICK,LoadInstructions);
         m_introMenu.Buttons.Submiter.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         m_introMenu.Buttons.Submiter.addEventListener(MouseEvent.CLICK,LoadHiscore);
         m_introMenu.Buttons.Morer.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         m_introMenu.Buttons.Morer.addEventListener(MouseEvent.CLICK,MoreGames);
         m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         m_introMenu.Buttons.Crediter.addEventListener(MouseEvent.CLICK,LoadCredits);
         m_introMenu.ArmorLogo.addEventListener(MouseEvent.CLICK,MoreGames);
         m_introMenu.ArmorLogo.buttonMode = true;
         m_introMenu.ArmorLogo.useHandCursor = true;
      }
      
      public function loadComplete(param1:Event) : void
      {
         trace("DADAAAA");
         agi = param1.currentTarget.content;
         this.addChild(agi);
      }
      
      public function LoadHiscore(param1:MouseEvent) : *
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:Loader = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = "http://agi.armorgames.com/assets/agi/AGI.swf";
         Security.allowDomain(_loc2_);
         Security.allowInsecureDomain(_loc2_);
         _loc3_ = new URLRequest(_loc2_);
         (_loc4_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
         _loc4_.load(_loc3_);
         _loc5_ = 0;
         score = 0;
         _loc6_ = 0;
         while(_loc6_ < 32)
         {
            score += Math.max(The_cookie.data.stats[_loc6_] * 360,0);
            if(The_cookie.data.times[_loc6_] != 0)
            {
               score += Math.max((TimeTable[_loc6_] - The_cookie.data.times[_loc6_]) * 12,0);
            }
            trace(score);
            _loc6_++;
         }
         _loc5_ = score;
         trace(_loc5_);
         h = new Hiscore();
         h.ViewHS.addEventListener(MouseEvent.MOUSE_DOWN,ViewHiscores);
         h.points_txt.text = _loc5_;
         _loc7_ = true;
         _loc6_ = 0;
         while(_loc6_ < 32)
         {
            if(The_cookie.data.stats[_loc6_] <= 0)
            {
               _loc7_ = false;
            }
            _loc6_++;
         }
         if(_loc7_ && The_cookie.data.submited == false)
         {
            h.NoHS.visible = false;
            h.Reset.visible = false;
            hisc = h.HS;
            stage.focus = hisc.name_txt;
            hisc.name_txt_2.mouseEnabled = false;
            hisc.name_txt.setSelection(0,hisc.name_txt.text.length);
            hisc.name_txt.addEventListener(Event.CHANGE,InputChanged);
            hisc.SubmitBTN.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
            hisc.SubmitBTN.addEventListener(MouseEvent.CLICK,SendHiscore);
         }
         else if(_loc7_)
         {
            h.NoHS.visible = false;
            h.HS.visible = false;
            h.Reset.ResetBtn.addEventListener(MouseEvent.MOUSE_DOWN,ClearData);
         }
         else
         {
            h.HS.visible = false;
            h.Reset.visible = false;
         }
         h.BackBTN.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         h.BackBTN.addEventListener(MouseEvent.MOUSE_DOWN,BackHiscore);
         addChild(h);
      }
      
      internal function closeHandler2() : void
      {
      }
      
      public function MoreGames(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.armorgames.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function ViewHiscores(param1:MouseEvent) : *
      {
         if(agi != null)
         {
            agi.init(devKey,gameKey);
            agi.initAGUI({"onClose":closeHandler2});
            agi.showScoreboardList();
         }
      }
      
      public function UnLoadCredits(param1:MouseEvent) : *
      {
         removeChild(crd);
      }
      
      public function MuteSound(param1:MouseEvent) : *
      {
         if(Muted == false)
         {
            Muted = true;
            SoundMixer.soundTransform = new SoundTransform(0);
            m_muter.muteLines.visible = false;
         }
         else
         {
            Muted = false;
            SoundMixer.soundTransform = new SoundTransform(1);
            m_muter.muteLines.visible = true;
         }
      }
      
      internal function TimerUpdate(param1:Event) : *
      {
         if(m_level.pause == false)
         {
            m_timer.currentTime = getTimer() - m_timer.startTime;
         }
         else
         {
            m_timer.startTime = getTimer() - m_timer.currentTime;
         }
         m_timer.m = Math.floor(m_timer.currentTime / 60000);
         m_timer.s = Math.floor((m_timer.currentTime - m_timer.m * 60000) / 1000);
         m_timer.ms = Math.floor((m_timer.currentTime - m_timer.m * 60000 - m_timer.s * 1000) / 100);
         if(m_timer.m <= 9)
         {
            m_timer.mins.text = "0" + String(m_timer.m);
         }
         else
         {
            m_timer.mins.text = String(m_timer.m);
         }
         if(m_timer.s <= 9)
         {
            m_timer.secs.text = "0" + String(m_timer.s);
         }
         else
         {
            m_timer.secs.text = String(m_timer.s);
         }
         m_timer.cents.text = String(m_timer.ms);
      }
      
      internal function StartGameBtn(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Number = NaN;
         PlayingMusic = false;
         MusicChannel.stop();
         new Pusher_Sound().play(0,1);
         _loc2_ = param1.target.name.charAt(2);
         if(param1.target.name.length == 5)
         {
            _loc3_ = Number(param1.target.name.charAt(4));
         }
         else
         {
            _loc3_ = parseInt(param1.target.name.charAt(4) + param1.target.name.charAt(5));
         }
         trace(_loc2_ + " " + _loc3_);
         switch(_loc2_ + "_" + _loc3_)
         {
            case "1_1":
               cur_node = 1;
               break;
            case "1_2":
               cur_node = 2;
               break;
            case "3_1":
               cur_node = 3;
               break;
            case "1_3":
               cur_node = 4;
               break;
            case "1_4":
               cur_node = 5;
               break;
            case "3_2":
               cur_node = 6;
               break;
            case "2_1":
               cur_node = 7;
               break;
            case "1_5":
               cur_node = 8;
               break;
            case "1_6":
               cur_node = 9;
               break;
            case "1_7":
               cur_node = 10;
               break;
            case "2_2":
               cur_node = 11;
               break;
            case "3_3":
               cur_node = 12;
               break;
            case "2_3":
               cur_node = 13;
               break;
            case "3_5":
               cur_node = 14;
               break;
            case "1_13":
               cur_node = 15;
               break;
            case "3_6":
               cur_node = 16;
               break;
            case "2_4":
               cur_node = 17;
               break;
            case "1_14":
               cur_node = 18;
               break;
            case "1_16":
               cur_node = 19;
               break;
            case "2_5":
               cur_node = 20;
               break;
            case "1_15":
               cur_node = 21;
               break;
            case "1_17":
               cur_node = 22;
               break;
            case "2_6":
               cur_node = 23;
               break;
            case "1_10":
               cur_node = 24;
               break;
            case "1_11":
               cur_node = 25;
               break;
            case "3_4":
               cur_node = 26;
               break;
            case "2_7":
               cur_node = 27;
               break;
            case "1_12":
               cur_node = 28;
               break;
            case "2_8":
               cur_node = 29;
               break;
            case "1_8":
               cur_node = 30;
               break;
            case "1_9":
               cur_node = 31;
               break;
            case "2_9":
               cur_node = 32;
         }
         cur_type = _loc2_;
         cur_lev = _loc3_;
         NewsArray[cur_node - 1] = false;
         m_mainMenu.StartBtn.removeEventListener(MouseEvent.MOUSE_DOWN,StartGame);
         m_transition = new Trans();
         m_transition.alpha = 0;
         addChild(m_transition);
         m_transition.addEventListener(Event.ENTER_FRAME,Transit);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      public function OverSounder(param1:MouseEvent) : *
      {
         OverSound.play(0,1);
      }
      
      public function UnLoadInstructions(param1:MouseEvent) : *
      {
         removeChild(instr);
      }
      
      public function CreateTeaser() : *
      {
         Teaser = new ag_intro_mc();
         Teaser.LinkBtn.addEventListener(MouseEvent.MOUSE_DOWN,TeaserClick);
         Teaser.x = 320;
         Teaser.y = 240;
         this.addChild(Teaser);
      }
      
      internal function Glowout(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < 32)
         {
            if("b_" + Translation[_loc2_] == param1.target.name)
            {
               m_mainMenu["node_" + (_loc2_ + 1)].Time.visible = false;
               m_mainMenu["node_" + (_loc2_ + 1)].Glower.visible = false;
            }
            _loc2_++;
         }
      }
      
      public function RetryGame() : *
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < m_level.windChannels.length)
         {
            m_level.windChannels[_loc1_].stop();
            _loc1_++;
         }
         removeChild(m_fps);
         m_level.removeEventListener(Event.ENTER_FRAME,m_level.Update);
         m_pauseMenu.removeEventListener(Event.ENTER_FRAME,m_pauseMenu.Update);
         m_timer.removeEventListener(Event.ENTER_FRAME,TimerUpdate);
         removeChild(m_level);
         removeChild(m_timer);
         removeChild(m_pauseMenu);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
         stage.removeEventListener(KeyboardEvent.KEY_UP,keyReleased);
         StartGame(cur_type,cur_lev);
      }
      
      public function GameReady() : *
      {
         var _loc1_:String = null;
         var _loc2_:ContextMenu = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         this.gotoAndStop(3);
         _loc1_ = this.loaderInfo.loaderURL;
         if(_loc1_.indexOf("kongregate.com") >= 0 && _loc1_.indexOf("newgrounds.com") >= 0)
         {
         }
         Muted = false;
         Translation = new Array("1_1","1_2","3_1","1_3","1_4","3_2","2_1","1_5","1_6","1_7","2_2","3_3","2_3","3_5","1_13","3_6","2_4","1_14","1_16","2_5","1_15","1_17","2_6","1_10","1_11","3_4","2_7","1_12","2_8","1_8","1_9","2_9");
         TimeTable = new Array(80,60,28,50,50,20,70,70,47,60,60,40,80,33,145,60,85,75,90,120,50,100,90,80,70,21,55,48,85,55,60,90);
         NewsArray = new Array(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false);
         _loc2_ = new ContextMenu();
         _loc2_.hideBuiltInItems();
         NavisSound = new Navis_Sound();
         OverSound = new Over_Sound();
         The_cookie = SharedObject.getLocal("FBCookie");
         MenuSound = new Menu_Sound();
         AdvSound = new Adv_Sound();
         SpeedSound = new Speed_Sound();
         if(The_cookie.data.stats == undefined)
         {
            The_cookie.data.submited = false;
            The_cookie.data.stats = new Array(32);
            The_cookie.data.times = new Array(32);
            The_cookie.data.timesString = new Array(32);
            _loc4_ = 0;
            while(_loc4_ < 32)
            {
               The_cookie.data.stats[_loc4_] = -1;
               The_cookie.data.times[_loc4_] = 0;
               The_cookie.data.timesString[_loc4_] = "";
               _loc4_++;
            }
            The_cookie.data.stats[0] = 0;
         }
         Adjacencies = new Array(32);
         _loc3_ = 0;
         while(_loc3_ < 32)
         {
            Adjacencies[_loc3_] = new Array(32);
            _loc5_ = 0;
            while(_loc5_ < 32)
            {
               Adjacencies[_loc3_][_loc5_] = 0;
               _loc5_++;
            }
            _loc3_++;
         }
         Adjacencies[0][1] = 1;
         Adjacencies[1][2] = 1;
         Adjacencies[2][3] = 1;
         Adjacencies[3][4] = 1;
         Adjacencies[3][7] = 1;
         Adjacencies[3][13] = 1;
         Adjacencies[3][23] = 1;
         Adjacencies[3][29] = 1;
         Adjacencies[4][5] = 1;
         Adjacencies[5][6] = 1;
         Adjacencies[7][8] = 1;
         Adjacencies[8][9] = 1;
         Adjacencies[8][11] = 1;
         Adjacencies[9][10] = 1;
         Adjacencies[11][12] = 1;
         Adjacencies[13][14] = 1;
         Adjacencies[13][17] = 1;
         Adjacencies[13][20] = 1;
         Adjacencies[14][15] = 1;
         Adjacencies[15][16] = 1;
         Adjacencies[17][18] = 1;
         Adjacencies[18][19] = 1;
         Adjacencies[20][21] = 1;
         Adjacencies[21][22] = 1;
         Adjacencies[23][24] = 1;
         Adjacencies[24][25] = 1;
         Adjacencies[24][27] = 1;
         Adjacencies[25][26] = 1;
         Adjacencies[27][28] = 1;
         Adjacencies[29][30] = 1;
         Adjacencies[30][31] = 1;
         _loc3_ = 0;
         while(_loc3_ < 32)
         {
            _loc5_ = 0;
            while(_loc5_ < 32)
            {
               if(Adjacencies[_loc3_][_loc5_] == 1)
               {
                  Adjacencies[_loc5_][_loc3_] = 1;
               }
               _loc5_++;
            }
            _loc3_++;
         }
         CreateIntroMenu();
      }
      
      public function CreatePreloader() : *
      {
         var _loc1_:* = undefined;
         _loc1_ = new PreLoader(this);
         this.addChild(_loc1_);
      }
      
      public function LoadCredits(param1:MouseEvent) : *
      {
         crd = new Credits();
         addChild(crd);
         crd.OKO.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         crd.OKO.addEventListener(MouseEvent.CLICK,UnLoadCredits);
      }
      
      public function TeaserOut() : *
      {
         Teaser.LinkBtn.removeEventListener(MouseEvent.MOUSE_DOWN,TeaserClick);
         this.removeChild(Teaser);
         GameReady();
      }
      
      private function keyPressed(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 80)
         {
            if(m_level.ended == false)
            {
               m_pauseMenu.Show_Hide(param1 as MouseEvent);
            }
         }
         if(m_level.pause == false)
         {
            switch(param1.keyCode)
            {
               case Keyboard.UP:
                  m_level.u_pressed = true;
                  break;
               case Keyboard.RIGHT:
                  m_level.r_pressed = true;
                  break;
               case Keyboard.LEFT:
                  m_level.l_pressed = true;
                  break;
               case 65:
                  m_level.l_pressed2 = true;
                  break;
               case 68:
                  m_level.r_pressed2 = true;
                  break;
               case 87:
                  m_level.u_pressed2 = true;
            }
         }
         else
         {
            m_level.u_pressed = false;
            m_level.r_pressed = false;
            m_level.l_pressed = false;
            m_level.l_pressed2 = false;
            m_level.r_pressed2 = false;
            m_level.u_pressed2 = false;
         }
      }
      
      public function Recuent() : *
      {
         var w:* = undefined;
         var RecuentBoard:* = undefined;
         var i:* = undefined;
         var Points:* = undefined;
         PlayingMusic = false;
         MusicChannel.stop();
         FinishSound1 = new Finish1();
         FinishSound2 = new Finish2();
         if(cur_type == 3)
         {
            FinishSound2.play(0,1);
         }
         else
         {
            FinishSound1.play(0,1);
         }
         w = 0;
         while(w < m_level.windChannels.length)
         {
            m_level.windChannels[w].stop();
            w++;
         }
         RecuentBoard = new Recuento();
         addChild(RecuentBoard);
         RecuentBoard.Rboard.ToMenuBtn.addEventListener(MouseEvent.CLICK,function():*
         {
            EndGame();
            removeChild(RecuentBoard);
         });
         RecuentBoard.Rboard.ToMenuBtn.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         if(cur_type == 2)
         {
            RecuentBoard.Rboard.RDcounter.visible = false;
            RecuentBoard.Rboard.BDcounter.visible = false;
            RecuentBoard.Rboard.GDcounter.visible = true;
            RecuentBoard.Rboard.GDcounter.gd.text = m_level.myContactListener.GreenCount;
         }
         else
         {
            RecuentBoard.Rboard.RDcounter.visible = true;
            RecuentBoard.Rboard.BDcounter.visible = true;
            RecuentBoard.Rboard.GDcounter.visible = false;
            RecuentBoard.Rboard.BDcounter.bd.text = m_level.myContactListener.BlueCount;
            RecuentBoard.Rboard.RDcounter.rd.text = m_level.myContactListener.RedCount;
         }
         RecuentBoard.Rboard.Result.A.visible = false;
         RecuentBoard.Rboard.Result.B.visible = false;
         RecuentBoard.Rboard.Result.C.visible = false;
         RecuentBoard.Rboard.Result.F.visible = false;
         RecuentBoard.Rboard.time.text = m_timer.mins.text + " : " + m_timer.secs.text;
         if(cur_type == 2)
         {
            if(m_level.myContactListener.GreenCount == 1)
            {
               RecuentBoard.Rboard.Result.A.visible = true;
               if(The_cookie.data.stats[cur_node - 1] < 3 || The_cookie.data.times[cur_node - 1] > parseInt(m_timer.mins.text) * 60 + parseInt(m_timer.secs.text))
               {
                  trace("CAAAAAAAAAAAAAAAAAAAAAAAALAMAR");
                  The_cookie.data.times[cur_node - 1] = parseInt(m_timer.mins.text) * 60 + parseInt(m_timer.secs.text);
                  The_cookie.data.timesString[cur_node - 1] = m_timer.mins.text + ":" + m_timer.secs.text;
               }
               The_cookie.data.stats[cur_node - 1] = 3;
            }
            else
            {
               RecuentBoard.Rboard.Result.F.visible = true;
            }
         }
         else
         {
            Points = 0;
            if(parseInt(m_timer.mins.text) * 60 + parseInt(m_timer.secs.text) <= TimeTable[cur_node - 1])
            {
               Points += 1;
            }
            if(m_level.myContactListener.BlueCount == m_level.BDcount && m_level.myContactListener.RedCount == m_level.RDcount)
            {
               Points += 1;
            }
            if(The_cookie.data.stats[cur_node - 1] <= 1 + Points)
            {
               if(The_cookie.data.stats[cur_node - 1] < 1 + Points || The_cookie.data.times[cur_node - 1] > parseInt(m_timer.mins.text) * 60 + parseInt(m_timer.secs.text))
               {
                  trace("CAAAAAAAAAAAAAAAAAAAAAAAALAMAR");
                  The_cookie.data.times[cur_node - 1] = parseInt(m_timer.mins.text) * 60 + parseInt(m_timer.secs.text);
                  The_cookie.data.timesString[cur_node - 1] = m_timer.mins.text + ":" + m_timer.secs.text;
               }
               The_cookie.data.stats[cur_node - 1] = 1 + Points;
            }
            switch(Points)
            {
               case 0:
                  RecuentBoard.Rboard.Result.C.visible = true;
                  break;
               case 1:
                  RecuentBoard.Rboard.Result.B.visible = true;
                  break;
               case 2:
                  RecuentBoard.Rboard.Result.A.visible = true;
            }
         }
         i = 0;
         while(i < 32)
         {
            if(Adjacencies[cur_node - 1][i] == 1 && The_cookie.data.stats[i] == -1)
            {
               NewsArray[i] = true;
               The_cookie.data.stats[i] = 0;
            }
            i++;
         }
         trace("WAXXAA" + TimeTable[cur_node - 1]);
      }
      
      private function keyReleased(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.UP:
               m_level.u_pressed = false;
               break;
            case Keyboard.RIGHT:
               m_level.r_pressed = false;
               break;
            case Keyboard.LEFT:
               m_level.l_pressed = false;
               break;
            case 65:
               m_level.l_pressed2 = false;
               break;
            case 68:
               m_level.r_pressed2 = false;
               break;
            case 87:
               m_level.u_pressed2 = false;
         }
      }
      
      public function Transit2(param1:Event) : *
      {
         m_transition.alpha += 0.1;
         if(m_transition.alpha > 1)
         {
            removeChild(m_introMenu);
            CreateMainMenu();
            m_transition.removeEventListener(Event.ENTER_FRAME,Transit2);
            removeChild(m_transition);
         }
      }
      
      public function Transit3(param1:Event) : *
      {
         m_transition.alpha += 0.1;
         if(m_transition.alpha > 1)
         {
            removeChild(m_mainMenu);
            CreateIntroMenu();
            m_transition.removeEventListener(Event.ENTER_FRAME,Transit3);
            removeChild(m_transition);
         }
      }
      
      public function TeaserClick(param1:MouseEvent) : *
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.armorgames.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function BackHiscore(param1:MouseEvent) : *
      {
         removeChild(h);
      }
      
      public function EndGame() : *
      {
         var _loc1_:* = undefined;
         PlayingMusic = false;
         MusicChannel.stop();
         _loc1_ = 0;
         while(_loc1_ < m_level.windChannels.length)
         {
            m_level.windChannels[_loc1_].stop();
            _loc1_++;
         }
         removeChild(m_fps);
         m_level.removeEventListener(Event.ENTER_FRAME,m_level.Update);
         m_pauseMenu.removeEventListener(Event.ENTER_FRAME,m_pauseMenu.Update);
         m_timer.removeEventListener(Event.ENTER_FRAME,TimerUpdate);
         removeChild(m_level);
         removeChild(m_timer);
         removeChild(m_pauseMenu);
         removeChild(m_muter);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
         stage.removeEventListener(KeyboardEvent.KEY_UP,keyReleased);
         CreateMainMenu();
      }
      
      public function StartGame(param1:Number, param2:Number) : *
      {
         var _loc3_:String = null;
         if(PlayingMusic != true)
         {
            PlayingMusic = true;
            MusicChannel.stop();
            if(param1 == 1 || param1 == 2)
            {
               MusicChannel = AdvSound.play(0,999);
            }
            else
            {
               MusicChannel = SpeedSound.play(0,999);
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
         m_level = new level(_loc3_,param2);
         trace("COOL");
         m_level.name = "m_level";
         addChild(m_level);
         m_level.scaleX = 0.8;
         m_level.scaleY = 0.8;
         m_level.x += 16;
         m_level.y += 16;
         m_timer = new Watch();
         m_timer.name = "m_timer";
         addChild(m_timer);
         m_timer.x = 320;
         m_timer.y = 20;
         m_timer.startTime = getTimer();
         m_timer.addEventListener(Event.ENTER_FRAME,TimerUpdate,false,0,true);
         m_fps = new FPSCounter();
         addChild(m_fps);
         m_pauseMenu = new PauseMenu();
         addChild(m_pauseMenu);
         m_pauseMenu.name = "m_pauseMenu";
         m_pauseMenu.x = 320;
         m_pauseMenu.y = 480;
         m_muter = new Muter();
         m_muter.x = 620;
         m_muter.y = 20;
         addChild(m_muter);
         m_muter.muteBtn.addEventListener(MouseEvent.CLICK,MuteSound);
         m_muter.muteLines.visible = !Muted;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
         stage.addEventListener(KeyboardEvent.KEY_UP,keyReleased);
         stage.focus = this;
      }
      
      public function SendHiscore(param1:MouseEvent) : *
      {
         if(agi != null)
         {
            agi.init(devKey,gameKey);
            agi.initAGUI({"onClose":closeHandler});
            agi.showScoreboardSubmit(score,hisc.name_txt.text);
         }
      }
      
      public function ClearData(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         The_cookie.data.submited = false;
         The_cookie.data.stats = new Array(32);
         The_cookie.data.times = new Array(32);
         The_cookie.data.timesString = new Array(32);
         _loc2_ = 0;
         while(_loc2_ < 32)
         {
            The_cookie.data.stats[_loc2_] = -1;
            The_cookie.data.times[_loc2_] = 0;
            The_cookie.data.timesString[_loc2_] = "";
            _loc2_++;
         }
         The_cookie.data.stats[0] = 0;
         removeChild(h);
      }
      
      public function LoadMenu(param1:MouseEvent) : *
      {
         m_transition = new Trans();
         m_transition.alpha = 0;
         addChild(m_transition);
         m_transition.addEventListener(Event.ENTER_FRAME,Transit2);
      }
      
      internal function Glowin(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         if(m_mainMenu.nextpos != [param1.target.x,param1.target.y])
         {
            if(NavisChannel != null)
            {
               NavisChannel.stop();
            }
            NavisChannel = NavisSound.play(0,1);
         }
         m_mainMenu.nextpos = [param1.target.x,param1.target.y];
         _loc2_ = 0;
         while(_loc2_ < 32)
         {
            if("b_" + Translation[_loc2_] == param1.target.name)
            {
               m_mainMenu["node_" + (_loc2_ + 1)].Glower.visible = true;
               m_mainMenu["node_" + (_loc2_ + 1)].Time.visible = true;
            }
            _loc2_++;
         }
      }
      
      internal function FliesMove(param1:Event) : *
      {
         m_mainMenu.flies.vx += (m_mainMenu.nextpos[0] - m_mainMenu.flies.x) / 5;
         m_mainMenu.flies.vy += (m_mainMenu.nextpos[1] - m_mainMenu.flies.y) / 5;
         m_mainMenu.flies.vx *= 0.7;
         m_mainMenu.flies.vy *= 0.7;
         m_mainMenu.flies.x += m_mainMenu.flies.vx;
         m_mainMenu.flies.y += m_mainMenu.flies.vy;
      }
      
      public function InputChanged(param1:Event) : *
      {
         hisc.name_txt_2.text = hisc.name_txt.text;
         hisc.name_txt_2.autoSize = TextFieldAutoSize.LEFT;
         hisc.name_txt.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function Transit(param1:Event) : *
      {
         m_transition.alpha += 0.2;
         if(m_transition.alpha > 1)
         {
            removeChild(m_mainMenu);
            StartGame(cur_type,cur_lev);
            m_transition.removeEventListener(Event.ENTER_FRAME,Transit);
            removeChild(m_transition);
         }
      }
      
      public function BackToIntro(param1:MouseEvent) : *
      {
         m_transition = new Trans();
         m_transition.alpha = 0;
         addChild(m_transition);
         m_transition.addEventListener(Event.ENTER_FRAME,Transit3);
      }
      
      public function LoadInstructions(param1:MouseEvent) : *
      {
         instr = new Instructions();
         addChild(instr);
         instr.OKO.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         instr.OKO.addEventListener(MouseEvent.CLICK,UnLoadInstructions);
      }
   }
}
