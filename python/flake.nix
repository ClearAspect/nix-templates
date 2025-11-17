{
  description = "Python development environment";

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
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          pyright
          black
          ruff
        ];

        shellHook = ''
          # Create venv if it doesn't exist
          if [ ! -d .venv ]; then
            echo "Creating virtual environment..."
            python -m venv .venv
          fi

          # Activate venv
          source .venv/bin/activate

          # Install requirements if requirements.txt exists and venv is fresh
          if [ -f requirements.txt ] && [ ! -f .venv/.installed ]; then
            echo "Installing requirements..."
            pip install -r requirements.txt
            touch .venv/.installed
          fi
        '';
      };
    });
  };
}
