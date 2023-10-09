{
  description = "devshell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {  nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs; {
        devShell = mkShell {
          buildInputs = [
            asciidoctor-with-extensions
            hugo
          ];
        };
      });
}
