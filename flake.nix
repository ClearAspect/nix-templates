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
      zig = {
        path = ./zig;
        description = "Zig with zls";
      };
      lua = {
        path = ./lua;
        description = "Lua with LSP and formatter";
      };
      javascript = {
        path = ./javascript;
        description = "JavaScript/TypeScript with Node and tooling";
      };
      go = {
        path = ./go;
        description = "Go with gopls";
      };
    };

    # defaultTemplate = self.templates.python;
  };
}
