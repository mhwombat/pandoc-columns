{
  description = "Pandoc Markdown filter that provides a Markdown extension for columns.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          pandoc-columns = pkgs.haskellPackages.developPackage {
            name = "pandoc-columns";
            root = ./.;
          };
          default = pandoc-columns;
        };
        apps = rec {
          pandoc-columns = flake-utils.lib.mkApp { drv = self.packages.${system}.pandoc-columns; };
          default = pandoc-columns;
        };
      }
    );
}
