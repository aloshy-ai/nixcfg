{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        github.vscode-github-actions
        github.copilot
        github.copilot-chat
        github.codespaces
        github.github-vscode-theme
        github.vscode-pull-request-github
        esbenp.prettier-vscode
      ];
      userSettings = {
        "RainbowBrackets.colorMode" = "Consecutive";
        "RainbowBrackets.depreciation-notice" = false;
        "breadcrumbs.enabled" = false;
        "cursor.aipreview.enabled" = true;
        "cursor.cmdk.useThemedDiffBackground" = true;
        "cursor.cpp.enablePartialAccepts" = true;
        "editor.action.moveLinesDownAction" = "shift+cmd+down";
        "editor.action.moveLinesUpAction" = "shift+cmd+up";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.folding" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font'";
        "editor.formatOnSave" = true;
        "editor.semanticHighlighting.enabled" = true;
        "files.autoSave" = "afterDelay";
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.smartCommitChanges" = "all";
        "githubLocalActions.dockerDesktopPath" = "/Applications/Docker.app";
        "programs.vscode.mutableExtensionsDir" = true;
        "security.workspace.trust.banner" = "always";
        "workbench.activityBar.orientation" = "vertical";
        "workbench.sideBar.location" = "left";
        "workbench.tree.enableStickyScroll" = false;
        "workbench.tree.indent" = 16;
        "workbench.tree.renderIndentGuides" = "always";
        "workbench.colorTheme" = "GitHub Dark";
      };
    };
  };
}
