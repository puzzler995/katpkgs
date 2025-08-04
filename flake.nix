{
  description = "Flake with various software I've packaged for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    v6data = {
      url = "path:/home/kat/.local/share/Steam/steamapps/common/vvvvvv/data.zip";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, v6data }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs {
          inherit system; #overlays;
          config.allowUnfree = true;
        };
        inherit system;
      });

    in {
      overlays = {
        sm64ex = import ./overlays/sm64ex.nix {inherit self;};
        vvvvvv = import ./overlays/vvvvvv.nix {
          inherit self;
          inputs = self.inputs;
        };
      };

      packages = forAllSystems ({ pkgs, ... }: {
          APCpp = pkgs.callPackage ./packages/apcpp {};
          autopelago = pkgs.callPackage ./packages/autopelago {};
          nightbot-now-playing = pkgs.callPackage ./packages/nightbot-now-playing {};
          touch-portal = pkgs.callPackage ./packages/touch-portal {};
          snekstudio = pkgs.callPackage ./packages/snekstudio {};
        }
      );
    };
}