[private]
default:
    @just --list --unsorted

# clean and optimize nix store
[group('dev')]
clean:
    nh clean all -K 3d
    nix store optimise

# check flake for errors
[group('dev')]
check:
    @nix flake check

# update lock file
[group('dev')]
update *input:
    @nix flake update {{ input }} --refresh

# upon repl shell with loaded flake
[group('dev')]
repl:
    nix repl -f flake.nix

# fetch sha256 for github ref
[group('dev')]
[positional-arguments]
fetch-sha *input:
    nix-shell -p nix-prefetch-git jq --run "nix hash convert sha256:\$(nix-prefetch-git --url ${1} --quiet --rev ${2} | jq -r '.sha256')"

[private]
verify *args:
    @nix-store --verify {{ args }}

# repair the nix store
[group('dev')]
repair: (verify "--check-contents --repair")

alias fix := repair

os := if os() == "macos" { "darwin" } else { "linux" }

# switch to new system configuration
[group('rebuild')]
switch *args:
    @nh {{ os }} switch . --ask {{ args }}

# check home-manager logs
[group('rebuild')]
[linux]
hm-log:
    @journalctl -u home-manager-$(echo $USER).service
