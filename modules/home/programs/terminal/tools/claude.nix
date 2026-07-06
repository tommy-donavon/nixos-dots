{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (inputs) claude-agents;
  cfg = config.nest.programs.terminal.tools.claude;

  makeAgentPath = name: category: {
    inherit name;
    value = builtins.readFile "${claude-agents}/categories/${category}/${name}.md";
  };

in
{
  options.nest.programs.terminal.tools.claude = {
    enable = mkEnableOption "claude";
  };

  config = mkIf cfg.enable {
    programs.claude-code = {
      enable = true;

      agents =
        builtins.map (agent: makeAgentPath agent "01-core-development") [
          "fullstack-developer"
        ]
        ++ builtins.map (agent: makeAgentPath agent "02-language-specialists") [
          "golang-pro"
          "node-specialist"
          "typescript-pro"
        ]
        ++ builtins.map (agent: makeAgentPath agent "03-infrastructure") [
          "devops-engineer"
          "platform-engineer"
          "terraform-engineer"
        ]
        ++ builtins.map (agent: makeAgentPath agent "04-quality-security") [
          "code-reviewer"
          "security-auditor"
        ]
        |> builtins.listToAttrs;

      settings = {
        skipAllowlistPrompt = true;
        skipAutoPermissionPrompt = true;
        cleanupPeriodDays = 20;
        includeCoAuthoredBy = false;
        model = "opus";
        theme = "dark";
        verbose = false;

        enabledPlugins = {
          "claude-code-setup@claude-plugins-official" = true;
          "claude-md-management@claude-plugins-official" = true;
          "code-simplifier@claude-plugins-official" = true;
          "commit-commands@claude-plugins-official" = true;
          "frontend-design@claude-plugins-official" = true;
          "github@claude-plugins-official" = true;
          "playwright@claude-plugins-official" = true;
          "plugin-dev@claude-plugins-official" = false;
          "pr-review-toolkit@claude-plugins-official" = true;
          "superpowers@claude-plugins-official" = true;
          "security-guidance@claude-plugins-official" = true;
          "gopls-lsp@claude-plugins-official" = true;
          "rust-analyzer-lsp@claude-plugins-official" = true;
          "php-lsp@claude-plugins-official" = true;
          "jdtls-lsp@claude-plugins-official" = true;
          "clangd-lsp@claude-plugins-official" = true;
          "kotlin-lsp@claude-plugins-official" = true;
          "lua-lsp@claude-plugins-official" = true;
          "ruby-lsp@claude-plugins-official" = true;
          "typescript-lsp@claude-plugins-official" = true;
          "skill-creator@claude-plugins-official" = false;
        };
      };
    };
  };
}
