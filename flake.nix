{
  description = "Pandoc Markdown filter that provides a Markdown extension for columns.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.haskell-flake.flakeModule ];

      perSystem = { self', pkgs, ... }: {
        haskellProjects.default = { };

        # haskell-flake doesn't set the default package, but you can do it here.
        packages.default = self'.packages.pandoc-logic-proof;
      };
    };
}
