{
  description = "My project templates";

  outputs = {self}: {
    templates = {
      python = {
        path = ./python;
        description = "Python development environment";
      };
      rust = {
        path = ./rust;
        description = "Rust with cargo and rust-analyzer";
      };
      c = {
        path = ./c;
        description = "C/C++ with clang and clangd";
      };
    };
  };
}
