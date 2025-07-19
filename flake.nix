{
  description = "Flake with various software I've packaged for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs {
          inherit system; #overlays;
          config.allowUnfree = true;
        };
        inherit system;
      });

      # overlays = import ./overlays;

    in {
      packages = forAllSystems ({ pkgs, ... }: {
          nightbot-now-playing = pkgs.callPackage ./packages/nightbot-now-playing {};
        }
      );

      # overlays.default = import ./overlays;
    };
}