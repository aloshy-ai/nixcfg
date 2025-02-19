{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # In order to configure macOS systems.
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # In order to build system images and artifacts supported by nixos-generators.
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System Deployment
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        # Configure Snowfall Lib, all of these settings are optional.
        snowfall = {
          # Tell Snowfall Lib to look in the `./nix/` directory for your
          # Nix files.
          root = ./nix;

          # Choose a namespace to use for your flake's packages, library,
          # and overlays.
          namespace = "my-namespace";

          # Add flake metadata that can be processed by tools like Snowfall Frost.
          meta = {
            # A slug to use in documentation when displaying things like file paths.
            name = "my-awesome-flake";

            # A title to show for your flake, typically the name.
            title = "My Awesome Flake";
          };
        };
      };
    in lib.mkFlake {
      deploy = lib.mkDeploy { inherit (inputs) self; };
      checks = builtins.mapAttrs (system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy) inputs.deploy-rs.lib;
      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    } // {
      self = inputs.self;
    };
}
