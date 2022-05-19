{ pkgs, ... }:

let
in
{
  list = with pkgs; [
    xclip
    xsel
    xbrightness
    xmobar
    xmonad-with-packages
  ];
}
