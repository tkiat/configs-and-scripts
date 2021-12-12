import Control.Monad (forM_, join)
import Data.Function (on)
import Data.List (sortBy)
import XMonad
import qualified XMonad.Hooks.DynamicLog as DLog
import XMonad.Hooks.ManageDocks
  ( ToggleStruts (..),
    avoidStruts,
    docks,
    manageDocks,
  )
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run
  ( hPutStrLn,
    spawnPipe,
  )
import XMonad.Util.SpawnOnce
import Prelude

-- import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
main = do
  barProc <- spawnPipe "xmobar ~/.config/xmobar/.xmobarrc"
  --   spawnPipe "polybar xmonad --config-file=~/.config/polybar/config.ini"
  xmonad $
    docks
      (myConf {logHook = myXmobarLogHook barProc})
      `additionalKeysP` (myKeys myConf)
  where
    myKeys myConf =
      [ ("M-b", sendMessage ToggleStruts),
        ("M-d", spawn "dmenu_run"),
        ("M-S-a", spawn (terminal myConf)),
        ("M-S-l", spawn "slock"),
        ("M-p", spawn "passmenu"),
        ("M-s", spawn "scrot --select")
      ]

    myXmobarLogHook h =
      DLog.dynamicLogWithPP $
        DLog.xmobarPP
          { DLog.ppOutput = hPutStrLn h,
            DLog.ppCurrent = DLog.xmobarColor "#00bbdd" "",
            DLog.ppTitle = DLog.xmobarColor "#00bbdd" "" . DLog.shorten 60,
            DLog.ppHidden = DLog.xmobarColor "#ffa500" "",
            DLog.ppHiddenNoWindows = DLog.xmobarColor "grey" "",
            DLog.ppExtras = [windowCount],
            DLog.ppSep = "<fc=#82aaff> | </fc>",
            DLog.ppOrder = \(ws : l : t : ex) -> ws : concat ex : [t]
          }
      where
        windowCount :: X (Maybe String)
        windowCount =
          gets $
            Just
              . show
              . length
              . W.integrate'
              . W.stack
              . W.workspace
              . W.current
              . windowset

myConf =
  def
    { borderWidth = 2,
      clickJustFocuses = True,
      focusedBorderColor = "#005577",
      focusFollowsMouse = False,
      layoutHook = myLayout,
      -- , logHook = myPolybarLogHook
      manageHook = myManageHook,
      modMask = mod4Mask,
      normalBorderColor = "#222222",
      terminal = "st",
      workspaces = ["General", "Web", "3", "4", "Login", "6", "7", "Media", "9"],
      startupHook = myStartupHook
    }
  where
    myLayout = avoidStruts (Full ||| Tall 1 (3 / 100) (1 / 2))

    myManageHook =
      composeAll
        [ className =? "Chromium" --> doShift "Web",
          className =? "Chromium-browser" --> doShift "Web",
          className =? "Firefox Developer Edition" --> doShift "Web",
          className =? "Tor Browser" --> doShift "Web",
          className =? "qutebrowser" --> doShift "Web",
          className =? "Firefox" --> doShift "Login",
          className =? "Icecat" --> doShift "Login",
          className =? "TelegramDesktop" --> doShift "Login",
          className =? "Blender" --> doShift "7",
          className =? "Gimp" --> doShift "7",
          className =? "Inkscape" --> doShift "7",
          className =? "kdenlive" --> doShift "7",
          className =? "FreeFileSync" --> doShift "Media",
          className =? "MuPDF" --> doShift "Media",
          className =? "supertux2" --> doShift "Media",
          className =? "vlc" --> doShift "Media"
        ]

    myStartupHook :: X ()
    myStartupHook = do
      pure ()

-- myPolybarLogHook = do
--   winset <- gets windowset
--   title <- maybe (return "") (fmap show . getName) . W.peek $ winset
--   let currWs = W.currentTag winset
--   let wss = map W.tag $ W.workspaces winset
--   let wsStr = join $ map (fmt currWs) $ sort' wss
--
--   io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
--   io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")
--   where
--     fmt currWs ws
--       | currWs == ws = "[" ++ ws ++ "]"
--       | otherwise = " " ++ ws ++ " "
--     sort' = sortBy (compare `on` (!! 0))
