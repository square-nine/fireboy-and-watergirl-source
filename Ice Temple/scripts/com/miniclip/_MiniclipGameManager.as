package com.miniclip
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.blackbox.Module;
   import com.miniclip.blackbox.ModuleConfigurator;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.events.GameLoaderEvent;
   import com.miniclip.events.GameManagerEvent;
   import com.miniclip.gamemanager.API;
   import com.miniclip.gamemanager.GameAvatars;
   import com.miniclip.gamemanager.GameChat;
   import com.miniclip.gamemanager.GameCredits;
   import com.miniclip.gamemanager.GameInfo;
   import com.miniclip.gamemanager.GameLobby;
   import com.miniclip.gamemanager.GameManager;
   import com.miniclip.gamemanager.GameMidroll;
   import com.miniclip.gamemanager.GamePlayer;
   import com.miniclip.gamemanager.GameServices;
   import com.miniclip.gamemanager.GameSponsorship;
   import com.miniclip.gamemanager.GameStorage;
   import com.miniclip.gamemanager.GameTracking;
   import com.miniclip.gamemanager.IMiniclipSponsorship;
   import com.miniclip.gamemanager.MiniclipAvatars;
   import com.miniclip.gamemanager.MiniclipChat;
   import com.miniclip.gamemanager.MiniclipCredits;
   import com.miniclip.gamemanager.MiniclipLobby;
   import com.miniclip.gamemanager.MiniclipPlayer;
   import com.miniclip.gamemanager.MiniclipServices;
   import com.miniclip.gamemanager.MiniclipStorage;
   import com.miniclip.gamemanager.MiniclipTracking;
   import com.miniclip.gamemanager.config;
   import com.miniclip.gamemanager.strings;
   import com.miniclip.loggers.Logger;
   import com.miniclip.loggers.LoggingLevel;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.Timer;
   import system.Strings;
   import system.eden;
   
   use namespace hack;
   
   public class _MiniclipGameManager extends Sprite implements GameManager
   {
       
      
      private var cfg:*;
      
      private var _ready:Boolean;
      
      private var _blackbox:BlackBox;
      
      private var _gameblackbox:BlackBox;
      
      private var _lcid:String;
      
      private var _timer:Timer;
      
      private var _game:GameInfo;
      
      private var _parameters:Object = null;
      
      private var _services:GameServices;
      
      private var _avatars:GameAvatars;
      
      private var _lobby:GameLobby;
      
      private var _storage:GameStorage;
      
      private var _player:GamePlayer;
      
      private var _tracking:GameTracking;
      
      private var _credits:GameCredits;
      
      private var _chat:GameChat;
      
      private const MAX_TIMEOUT:uint = 10000;
      
      private var _GML:Class;
      
      public function _MiniclipGameManager()
      {
         cfg = config;
         _GML = GameManagerLibrary;
         super();
         _lcid = _generateLCID();
         _timer = new Timer(MAX_TIMEOUT,1);
         _timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
         logger.level = LoggingLevel.errors;
         if(Capabilities.playerType != "Desktop")
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         if(!stage)
         {
            addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
            _timer.start();
         }
         else
         {
            onAddedToStage();
         }
      }
      
      private function _dumpBlackBoxInfos(param1:BlackBox) : void
      {
         eden.prettyPrinting = true;
         trace("[BlackBox " + param1.name + "]");
         trace("----------------------------------------------------------------------");
         trace(param1.module.description);
         trace("             url: " + param1.url);
         trace("       moduleURL: " + param1.moduleURL);
         trace("       variables: " + param1.variables.toString());
         trace("         isOwner: " + param1.isOwner());
         trace("          isRoot: " + param1.isRoot());
         trace("         isLocal: " + param1.isLocal());
         trace("       isLibrary: " + param1.isLibrary());
         trace("          isFlex: " + param1.isFlex());
         trace("----------------------------------------------------------------------");
         trace("module.config: " + eden.serialize(param1.module.config));
         trace("----------------------------------------------------------------------");
         trace("module.localconfig: " + eden.serialize(param1.module.localconfig));
         trace("----------------------------------------------------------------------");
         if(param1.isRoot())
         {
            trace("childs:");
            _dumpBlackBoxChilds();
         }
      }
      
      private function _dumpBlackBoxChilds() : void
      {
         var _loc1_:String = null;
         if(BlackBox.current.hasChilds())
         {
            trace("[BlackBox root]");
            trace("----------------------------------------------------------------------");
            trace(Strings.format("{0,-12} : {1}","gamemanager",BlackBox.current.module.toString()));
            trace("----------------------------------------------------------------------");
            trace("[BlackBox childs]");
            for(_loc1_ in BlackBox.current.childs)
            {
               trace(Strings.format("{0,-12} : {1}",_loc1_,BlackBox.current.childs[_loc1_].module.toString()));
            }
            trace("----------------------------------------------------------------------");
         }
         else
         {
            trace("BlackBox has no childs");
         }
      }
      
      private function _dumpWhenReady(param1:BlackBoxEvent) : void
      {
         _dumpBlackBoxInfos(param1.target as BlackBox);
      }
      
      private function _saveAndDumpLater(... rest) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            _loc2_ = rest[_loc3_];
            if(_loc2_ is BlackBox)
            {
               if(_loc2_.ready)
               {
                  _dumpBlackBoxInfos(_loc2_);
               }
               else
               {
                  _loc2_.addEventListener(BlackBoxEvent.READY,_dumpWhenReady);
               }
            }
            _loc3_++;
         }
      }
      
      private function _generateLCID() : String
      {
         return String(Math.floor(Math.random() * 10000000));
      }
      
      private function _buildContextMenu(param1:Boolean) : void
      {
         var myContextMenu:ContextMenu = null;
         var hasGameFilename:Boolean = param1;
         try
         {
            myContextMenu = new ContextMenu();
            myContextMenu.hideBuiltInItems();
            contextMenu = myContextMenu;
         }
         catch(e:Error)
         {
            trace("Can not create ContextMenu in this Security context");
         }
         _addToContextMenu(this.info + " v" + this.version);
         if(!hasGameFilename)
         {
            logger.error(strings.noFilename);
            _addToContextMenu(strings.noFilename);
         }
         logger.log("hasGameFilename: " + hasGameFilename);
      }
      
      private function _addToContextMenu(param1:String) : void
      {
         var myContextMenu:ContextMenu = null;
         var message:String = param1;
         try
         {
            myContextMenu = contextMenu;
            myContextMenu.customItems.push(new ContextMenuItem(message));
            contextMenu = myContextMenu;
         }
         catch(e:Error)
         {
            trace("Can not create ContextMenu in this Security context");
         }
      }
      
      private function _factory() : void
      {
         logger.log("current URL = " + stage.loaderInfo.url);
         var _loc1_:String = stage.loaderInfo.url;
         _game = new GameInfo(_gameblackbox);
         if(_blackbox.isLibrary())
         {
            _game.filename = _blackbox.moduleFile;
            logger.log("game filename from SWF: " + _game.filename);
         }
         var _loc2_:BlackBox = new BlackBox(new Module(new ModuleConfigurator(LibraryModules.avatarconfig)),_blackbox);
         var _loc3_:BlackBox = new BlackBox(new Module(new ModuleConfigurator(LibraryModules.lobbyconfig)),_blackbox);
         if(_blackbox.module.localconfig.debugmodules)
         {
            _dumpBlackBoxInfos(BlackBox.current);
            _saveAndDumpLater(_gameblackbox,_loc2_,_loc3_);
         }
         if(_parameters != null)
         {
            _blackbox.addVariables(_parameters);
         }
         _services = new MiniclipServices();
         _avatars = new MiniclipAvatars(_loc2_);
         _lobby = new MiniclipLobby();
         _storage = new MiniclipStorage();
         _player = new MiniclipPlayer(_storage);
         _tracking = new MiniclipTracking();
         _chat = new MiniclipChat();
         _credits = new MiniclipCredits();
         addEventListener(GameLoaderEvent.ENABLE_GAME,onEnableGame);
         addEventListener(GameLoaderEvent.DISABLE_GAME,onDisableGame);
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         logger.info("MiniclipGameManager.onAddedToStage()");
         removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
         _timer.stop();
         _timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         _blackbox = new BlackBox(new Module(new ModuleConfigurator(LibraryModules.componentconfig)),null,stage);
         if(_blackbox.ready)
         {
            onReady();
         }
         else
         {
            _blackbox.addEventListener(BlackBoxEvent.READY,onReady);
         }
      }
      
      private function onTimeOut(param1:TimerEvent) : void
      {
         _timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
         trace("After " + MAX_TIMEOUT / 1000 + "sec your game.swf did not call MiniclipGameManager.init()");
      }
      
      private function onReady(param1:BlackBoxEvent = null) : void
      {
         _blackbox.removeEventListener(BlackBoxEvent.READY,onReady);
         _gameblackbox = new BlackBox(new Module(new ModuleConfigurator(LibraryModules.gameconfig)),_blackbox);
         if(_gameblackbox.ready)
         {
            onGameReady();
         }
         else
         {
            _gameblackbox.addEventListener(BlackBoxEvent.READY,onGameReady);
         }
      }
      
      private function onGameReady(param1:BlackBoxEvent = null) : void
      {
         _gameblackbox.removeEventListener(BlackBoxEvent.READY,onGameReady);
         _run();
      }
      
      private function _run() : void
      {
         _factory();
         _buildContextMenu(_game.filename != "");
         dispatchEvent(new GameManagerEvent(GameManagerEvent.READY));
         _ready = true;
         logger.info("MiniclipGameManager is ready");
         if(_blackbox.module.localconfig.debugmodules)
         {
            _dumpBlackBoxChilds();
         }
         dispatchEvent(new GameManagerEvent(GameManagerEvent.GAME_READY));
      }
      
      private function onPlayButton(param1:Event) : void
      {
         logger.info("MiniclipGameManager.onPlayButton()");
      }
      
      private function onAddContextMenu(param1:GameManagerEvent) : void
      {
         _addToContextMenu(param1.message);
      }
      
      private function onEnableGame(param1:GameLoaderEvent) : void
      {
         logger.info("MiniclipGameManager.onEnableGame()");
      }
      
      private function onDisableGame(param1:GameLoaderEvent) : void
      {
         logger.info("MiniclipGameManager.onDisableGame()");
      }
      
      hack function setParameters(param1:Object = null) : void
      {
         logger.log("MiniclipGameManager.setParameters( " + param1 + " )");
         if(param1)
         {
            _parameters = param1;
         }
      }
      
      public function init(param1:DisplayObjectContainer) : void
      {
         logger.info(this.info + " v" + this.version);
         logger.log("MiniclipGameManager.init( " + param1 + " )");
         param1.addChild(Sprite(this));
      }
      
      public function get midRoll() : GameMidroll
      {
         return null;
      }
      
      public function get services() : GameServices
      {
         return _services;
      }
      
      public function get avatars() : GameAvatars
      {
         return _avatars;
      }
      
      public function get lobby() : GameLobby
      {
         return _lobby;
      }
      
      public function get player() : GamePlayer
      {
         return _player;
      }
      
      public function get tracking() : GameTracking
      {
         return _tracking;
      }
      
      public function get credits() : GameCredits
      {
         return _credits;
      }
      
      public function get logger() : Logger
      {
         return logger;
      }
      
      public function get chat() : GameChat
      {
         return _chat;
      }
      
      public function get version() : String
      {
         return API.version.toString(3);
      }
      
      public function get info() : String
      {
         return "Miniclip Game Manager (development)";
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function get sponsorship() : IMiniclipSponsorship
      {
         return new GameSponsorship();
      }
   }
}
