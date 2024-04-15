
{
   return GameManagerEvent;
}

package com.miniclip
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.blackbox.Module;
   import com.miniclip.blackbox.ModuleConfigurator;
   import com.miniclip.events.AlertboxEvent;
   import com.miniclip.events.AuthenticationEvent;
   import com.miniclip.events.AvatarEvent;
   import com.miniclip.events.AwardsEvent;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.events.DataEvent;
   import com.miniclip.events.GameChatEvent;
   import com.miniclip.events.GameManagerEvent;
   import com.miniclip.events.HighscoreEvent;
   import com.miniclip.events.LobbyDataEvent;
   import com.miniclip.events.LobbyEvent;
   import com.miniclip.events.LoginBoxEvent;
   import com.miniclip.events.MiniclipMediaEvent;
   import com.miniclip.events.StorageErrorEvent;
   import com.miniclip.events.StorageEvent;
   import com.miniclip.events.YoMeEditorEvent;
   import com.miniclip.gamemanager.API;
   import com.miniclip.gamemanager.GameAvatar;
   import com.miniclip.gamemanager.GameAvatars;
   import com.miniclip.gamemanager.GameChat;
   import com.miniclip.gamemanager.GameCredits;
   import com.miniclip.gamemanager.GameInfo;
   import com.miniclip.gamemanager.GameLobby;
   import com.miniclip.gamemanager.GameManager;
   import com.miniclip.gamemanager.GamePlayer;
   import com.miniclip.gamemanager.GameServices;
   import com.miniclip.gamemanager.GameStorage;
   import com.miniclip.gamemanager.GameTracking;
   import com.miniclip.gamemanager.IMiniclipMediaPlayer;
   import com.miniclip.gamemanager.LoginBoxScreen;
   import com.miniclip.gamemanager.MiniclipAvatars;
   import com.miniclip.gamemanager.MiniclipLobby;
   import com.miniclip.gamemanager.MiniclipPlayer;
   import com.miniclip.gamemanager.MiniclipServices;
   import com.miniclip.gamemanager.YoMe;
   import com.miniclip.gamemanager.YoMeBitmap;
   import com.miniclip.gamemanager.YoMeEditorScreen;
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import com.miniclip.gamemanager.avatars.AvatarParts;
   import com.miniclip.gamemanager.avatars.AvatarRegistration;
   import com.miniclip.gamemanager.lobby.MultiplayerClient;
   import com.miniclip.gamemanager.lobby.SmartFox;
   import com.miniclip.gamemanager.lobby.SmartFoxBasic;
   import com.miniclip.gamemanager.lobby.SmartFoxPro;
   import com.miniclip.gamemanager.player.LoginScreens;
   import com.miniclip.gamemanager.ui.CreditsIcon;
   import com.miniclip.loggers.EmptyLogger;
   import com.miniclip.loggers.LogDispatcher;
   import com.miniclip.loggers.Loggable;
   import com.miniclip.loggers.Logger;
   import com.miniclip.loggers.LoggingLevel;
   import core.version;
   import flash.display.MovieClip;
   
   public class GameManagerLibrary extends MovieClip
   {
      
      public static var version:core.version = API.version;
       
      
      private var _MiniclipGameManager:GameManager;
      
      private var _blackboxEvent:Class;
      
      private var _alertboxEvent:Class;
      
      private var _authenticationEvent:Class;
      
      private var _awardsEvent:Class;
      
      private var _highscoreEvent:Class;
      
      private var _avatarEvent:Class;
      
      private var _GMEvent:Class;
      
      private var _GCEvent:Class;
      
      private var _MLEvent:Class;
      
      private var _MLDEvent:Class;
      
      private var _DEvent:Class;
      
      private var _storageEvent:Class;
      
      private var _storageEEvent:Class;
      
      private var _loginboxEvent:Class;
      
      private var _yomeedtiorEvent:Class;
      
      private var _miniclipMediaEvent:Class;
      
      private var _BB:BlackBox;
      
      private var _M:Module;
      
      private var _MC:ModuleConfigurator;
      
      private var _API:API;
      
      private var _GM:GameManager;
      
      private var _GS:GameServices;
      
      private var _MS:MiniclipServices;
      
      private var _GA:GameAvatar;
      
      private var _GAs:GameAvatars;
      
      private var _GC:GameChat;
      
      private var _GCRD:GameCredits;
      
      private var _GL:GameLobby;
      
      private var _GSO:GameStorage;
      
      private var _GP:GamePlayer;
      
      private var _GT:GameTracking;
      
      private var _GI:GameInfo;
      
      private var _YoMe:YoMe;
      
      private var _YoMeBmp:YoMeBitmap;
      
      private var _LBS:LoginBoxScreen;
      
      private var _YES:YoMeEditorScreen;
      
      private var _LS:LoginScreens;
      
      private var _MAs:MiniclipAvatars;
      
      private var _AP:AvatarParts;
      
      private var _AR:AvatarRegistration;
      
      private var _ABT:AvatarBitmapType;
      
      private var _ML:MiniclipLobby;
      
      private var _MP:MiniclipPlayer;
      
      private var _SF:SmartFox;
      
      private var _SFB:SmartFoxBasic;
      
      private var _SFP:SmartFoxPro;
      
      private var _MPClient:MultiplayerClient;
      
      private var _mediaPlayerAPI:IMiniclipMediaPlayer;
      
      private var _Logger:Logger;
      
      private var _Loggable:Loggable;
      
      private var _LoggingLevel:LoggingLevel;
      
      private var _empty:EmptyLogger;
      
      private var _dispatcher:LogDispatcher;
      
      private var _CrdIcon:CreditsIcon;
      
      public function GameManagerLibrary()
      {
         _MiniclipGameManager = MiniclipGameManager;
         _blackboxEvent = BlackBoxEvent;
         _alertboxEvent = AlertboxEvent;
         _authenticationEvent = AuthenticationEvent;
         _awardsEvent = AwardsEvent;
         _highscoreEvent = HighscoreEvent;
         _avatarEvent = AvatarEvent;
         _GMEvent = GameManagerEvent;
         _GCEvent = GameChatEvent;
         _MLEvent = LobbyEvent;
         _MLDEvent = LobbyDataEvent;
         _DEvent = DataEvent;
         _storageEvent = StorageEvent;
         _storageEEvent = StorageErrorEvent;
         _loginboxEvent = LoginBoxEvent;
         _yomeedtiorEvent = YoMeEditorEvent;
         _miniclipMediaEvent = MiniclipMediaEvent;
         super();
      }
   }
}
