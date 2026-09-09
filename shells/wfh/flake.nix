{
  description = "Ambiente VS Code + Markdown + PDF";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
            };
          };

          vscode = pkgs.vscode-with-extensions.override {
            vscodeExtensions = with pkgs.vscode-extensions; [
	      yzane.markdown-pdf
              yzhang.markdown-all-in-one
            ];
          };

          python = pkgs.python3.withPackages (ps: [
            ps.weasyprint
          ]);

          fonts = [
            pkgs.noto-fonts
            pkgs.noto-fonts-cjk-sans
            pkgs.noto-fonts-color-emoji
          ];
        in
        {
          default = pkgs.mkShell {
            packages = [
              vscode
              pkgs.chromium
              pkgs.pandoc
              python
            ] ++ fonts;

            shellHook = ''
              export MARKDOWN_PDF_CHROMIUM="${pkgs.chromium}/bin/chromium"

              echo
              echo "Markdown PDF Environment"
              echo "────────────────────────"
              echo "VS Code:    $(code --version | head -n1)"
              echo "Chromium:   $(chromium --version)"
              echo "Pandoc:     $(pandoc --version | head -n1)"
              echo "WeasyPrint: $(weasyprint --version)"
              echo
            '';
          };
        });
    };
}
