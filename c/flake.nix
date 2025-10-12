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
      default = pkgs.mkShell {
        packages = with pkgs;
          [
            cmake
            gnumake
          ]
          ++ lib.optionals (!isDarwin) [
            # Linux: full clang toolchain
            clang
            clang-tools
          ]
          ++ lib.optionals isDarwin [
            # macOS: just the tools, not the compiler
            clang-tools # gives you clangd, clang-format, etc.
          ];

        shellHook = lib.optionalString isDarwin ''
          # Prioritize Apple's compiler toolchain
          export PATH="/usr/bin:$PATH"

          # Help clangd find Apple's SDK headers
          export CPATH="$(xcrun --show-sdk-path)/usr/include"
        '';
      };
    });
  };
}
