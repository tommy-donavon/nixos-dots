{
  config,
  lib,
  self,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (self.lib.module) mkBoolOpt;
  inherit (self.lib.system) systemTernary;

  cfg = config.nest.programs.graphical.firefox;
in
{
  options.nest.programs.graphical.firefox = {
    enable = mkEnableOption "firefox";
    workEnable = mkBoolOpt false "Whether or not to enable work configuration";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      package = systemTernary pkgs pkgs.firefox null;

      profiles.${config.home.username} = {
        isDefault = true;
        bookmarks = [
          {
            name = "nix";
            bookmarks =
              let
                tags = [ "nix" ];
              in
              [
                {
                  name = "nix book";
                  inherit tags;
                  url = "https://nixos-and-flakes.thiscute.world/";
                }
                {
                  name = "wiki";
                  inherit tags;
                  url = "https://wiki.nixos.org/";
                }
                {
                  name = "nix package search";
                  inherit tags;
                  url = "https://search.nixos.org/packages?channel=24.11";
                }
                {
                  name = "home manager option search";
                  inherit tags;
                  url = "https://home-manager-options.extranix.com";
                }
              ];
          }
        ];
        containers = {
          personal = {
            id = 0;
            name = "personal";
            icon = "tree";
            color = "turquoise";
          };
          research = {
            id = 1;
            name = "research";
            icon = "fruit";
            color = "red";
          };
          work = mkIf cfg.workEnable {
            id = 2;
            name = "work";
            icon = "briefcase";
            color = "yellow";
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
          sidebery
          theme-nord-polar-night
          vimium
        ];

        settings = {
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.suggest.pocket" = false;
          "extensions.autoDisableScopes" = 0;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.showHome" = false;
          "sidebar.verticalTabs" = true;
        };

        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@hm" ];
            };

            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g";
            "DuckDuckGo".metaData.alias = "@d";
          };
        };

      };

    };

  };
}
