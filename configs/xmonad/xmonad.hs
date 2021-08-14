import           Prelude
import           XMonad
import qualified XMonad.Hooks.DynamicLog       as DLog
import           XMonad.Hooks.ManageDocks       ( ToggleStruts(..)
                                                , avoidStruts
                                                , docks
                                                )
import qualified XMonad.StackSet               as W
import           XMonad.Util.EZConfig           ( additionalKeysP )
import           XMonad.Util.Run                ( hPutStrLn
                                                , spawnPipe
                                                )

-- import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
-- import XMonad.Util.SpawnOnce
main = do
  xmobarProc <- spawnPipe "xmobar ~/.xmobarrc"
  -- xmobarProc <- spawnPipe "xmobar ~/xmobar/xmobar.hs"
  xmonad
    $                 docks def
                        { borderWidth        = 2
                        , clickJustFocuses   = True
                        , focusedBorderColor = "#005577"
                        , focusFollowsMouse  = False
                        , layoutHook         = myLayout
                        , logHook = DLog.dynamicLogWithPP $ myLogHook xmobarProc
                        , manageHook         = myManageHook
                        , modMask            = mod4Mask
                        , normalBorderColor  = "#222222"
                        , terminal           = "st"
                        , workspaces = ["General", "Web", "3", "4", "Login", "6", "7", "Media"]
                        }
    `additionalKeysP` myKeys

windowCount :: X (Maybe String)
windowCount =
  gets
    $ Just
    . show
    . length
    . W.integrate'
    . W.stack
    . W.workspace
    . W.current
    . windowset


myKeys = [("M-b", sendMessage ToggleStruts)]

myLayout = avoidStruts (Full ||| Tall 1 (3 / 100) (1 / 2))

myLogHook h = DLog.xmobarPP
  { DLog.ppOutput          = hPutStrLn h
  , DLog.ppCurrent         = DLog.xmobarColor "#00bbdd" ""
  , DLog.ppTitle           = DLog.xmobarColor "#00bbdd" "" . DLog.shorten 60
  , DLog.ppHidden          = DLog.xmobarColor "#ffa500" ""
  , DLog.ppHiddenNoWindows = DLog.xmobarColor "grey" ""
  , DLog.ppExtras          = [windowCount]
  , DLog.ppSep             = "<fc=#82aaff> | </fc>"
  , DLog.ppOrder           = \(ws : l : t : ex) -> ws : concat ex : [t]
  }

myManageHook = composeAll
  [ className =? "Chromium" --> doShift "Web"
  , className =? "Chromium-browser" --> doShift "Web"
  , className =? "Firefox Developer Edition" --> doShift "Web"
  , className =? "Tor Browser" --> doShift "Web"
  , className =? "qutebrowser" --> doShift "Web"
  , className =? "Firefox" --> doShift "Login"
  , className =? "Icecat" --> doShift "Login"
  , className =? "TelegramDesktop" --> doShift "Login"
  , className =? "Blender" --> doShift "7"
  , className =? "Gimp" --> doShift "7"
  , className =? "Inkscape" --> doShift "7"
  , className =? "kdenlive" --> doShift "7"
  , className =? "FreeFileSync" --> doShift "Media"
  , className =? "supertux2" --> doShift "Media"
  , className =? "vlc" --> doShift "Media"
  ]
