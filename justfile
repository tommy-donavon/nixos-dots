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
fetch-sha owner repo *args:
    @nix-prefetch-github {{ owner }} {{ repo }} {{ args }}

[private]
verify *args:
    @nix-store --verify {{ args }}

# repair the nix store
[group('dev')]
repair: (verify "--check-contents --repair")

alias fix := repair

os := if os() == "macos" { "darwin" } else { "os" }

# switch to new system configuration
[group('rebuild')]
switch *args:
    @nh {{ os }} switch . --ask {{ args }}

# check home-manager logs
[group('rebuild')]
[linux]
hm-log:
    @journalctl -u home-manager-$(echo $USER).service

# launch the graphical GNOME NixOS VM
[group('vm')]
vm:
    nix run .#gnome-vm

# reset the VM disk (drops all persisted state)
[group('vm')]
vm-reset:
    rm -f "${XDG_STATE_HOME:-$HOME/.local/state}/gnome-vm/disk.qcow2"
