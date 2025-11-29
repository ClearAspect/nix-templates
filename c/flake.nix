{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
  in {
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      isDarwin = pkgs.stdenv.isDarwin;
    in {
      default =
        (pkgs.mkShell.override {
          stdenv = pkgs.clangStdenv;
        }) {
          packages = with pkgs; [
            clang-tools
            cmake
            gnumake
            valgrind
            gdb
          ];
        };
    });
  };
}
