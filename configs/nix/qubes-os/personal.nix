{ lib, pkgs, specialArgs, ... }:

let
  my-config = "/home/${specialArgs.username}/configs-and-scripts/configs";
in
{
  programs = {
    firefox = {
      enable = true;
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   privacy-badger
      # ];
      profiles.default = {
        id = 0;
        bookmarks = {
          Facebook = {
            url = "https://www.facebook.com/pages/?category=liked&ref=bookmarks";
          };
          Github = {
            url = "https://github.com/tkiat?tab=repositories";
          };
          Gitlab = {
            url = "https://gitlab.com/";
          };
          Grammarly = {
            url = "https://app.grammarly.com/ddocs/880707227";
          };
          "Humble Bundle" = {
            url = "https://www.humblebundle.com/bundles?hmb_source=navbar";
          };
          Kaidee = {
            url = "https://www.kaidee.com/member/listing";
          };
          "LWN.net" = {
            url = "https://lwn.net/Archives/";
          };
          Outlook = {
            url = "https://outlook.live.com/mail/0/inbox";
          };
          Reddit = {
            url = "https://www.reddit.com/";
          };
          Shopee = {
            url = "https://shopee.co.th/";
          };
          "Stack Overflow" = {
            url = "https://stackoverflow.com/";
          };
          Thairath = {
            url = "https://www.thairath.co.th/newspaper";
          };
          Tutanota = {
            url = "https://mail.tutanota.com/";
          };
          "Utility - MEA" = {
            url = "https://eservice.mea.or.th/meaeservice/";
          };
          "Utility - MWA" = {
            url = "https://eservicesapp.mwa.co.th/ES/main.jsp";
          };
        };
        settings = {
          "browser.download.folderList" = 1; # 1 is ~/Downloads
          "browser.download.lastDir" = "/home/tkiat/downloads";
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # home screen content
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSearch" = false; # home screen content
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.isUS" = false;
          "browser.search.region" = "TH";
          "browser.search.selectedEngine" = "DuckDuckGo";
          "browser.search.suggest.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.page" = 3; # Open previous windows and tabs
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.uidensity" = 1; # compact
          "browser.urlbar.placeholderName" = "whatever you want"; # get overwritten
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "dom.webnotifications.enabled" = false;
          "network.protocol-handler.external.mailto" = false; # mailto warning
          "permissions.default.desktop-notification" = 2; # disable
          "signon.rememberSignons" = false; # never save logins and passwords
        };
      };
    };
  };

  home = {
    packages = with pkgs; [
      gdrive
#       gnome.cheese
      libreoffice
      tdesktop
      vlc
      weechat
    ];
  };
}
