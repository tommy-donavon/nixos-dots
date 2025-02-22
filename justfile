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

[private]
verify *args:
    @nix-store --verify {{ args }}

# repair the nix store
[group('dev')]
repair: (verify "--check-contents --repair")
alias fix := repair

# switch to new system configuration
[group('rebuild')]
switch:
    @flake switch

# switch to new system configuration with more logging
[group('rebuild')]
debug:
    @flake switch --debug --show-trace
