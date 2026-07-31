{
  inputs,
  self,
  ...
}:
{
  perSystem =
    {
      system,
      pkgs,
      ...
    }:
    let
      # Pick the correct VM nixosConfiguration based on build host arch
      vmConfig =
        if pkgs.stdenv.hostPlatform.isAarch64 then
          self.nixosConfigurations.gnome-vm-aarch64
        else
          self.nixosConfigurations.gnome-vm-x86_64;

      vmImage = vmConfig.config.system.build.qcow-efi;

      qemuFw = "${pkgs.qemu}/share/qemu";
    in
    {
      packages = {
        gnome-vm-image = vmImage;

        gnome-vm = pkgs.writeShellApplication {
          name = "gnome-vm";
          runtimeInputs = [ pkgs.qemu pkgs.coreutils ];
          text = ''
            STATE_DIR="''${XDG_STATE_HOME:-$HOME/.local/state}/gnome-vm"
            mkdir -p "$STATE_DIR"
            DISK="$STATE_DIR/disk.qcow2"

            BASE=$(find "${vmImage}" -name "*.qcow2" | head -1)
            if [ -z "$BASE" ]; then
              echo "error: could not find qcow2 image in ${vmImage}" >&2
              exit 1
            fi

            if [ ! -f "$DISK" ]; then
              echo "Initialising persistent disk at $DISK ..."
              cp --reflink=auto "$BASE" "$DISK" 2>/dev/null || cp "$BASE" "$DISK"
              chmod +w "$DISK"
            fi

            DOTS_PATH="''${DOTS_PATH:-${toString inputs.self}}"

            HOST="$(uname -sm)"
            case "$HOST" in
              "Darwin arm64")
                QEMU=qemu-system-aarch64
                ACCEL="-accel hvf -cpu host -machine virt,highmem=on"
                FW="${qemuFw}/edk2-aarch64-code.fd"
                ;;
              "Linux aarch64")
                QEMU=qemu-system-aarch64
                ACCEL="-accel kvm -cpu host -machine virt"
                FW="${qemuFw}/edk2-aarch64-code.fd"
                ;;
              "Linux x86_64")
                QEMU=qemu-system-x86_64
                ACCEL="-accel kvm -cpu host -machine q35"
                FW="${qemuFw}/edk2-x86_64-code.fd"
                ;;
              *)
                echo "error: unsupported host: $HOST" >&2
                exit 1
                ;;
            esac

            exec "$QEMU" $ACCEL \
              -m 8192 -smp 4 \
              -bios "$FW" \
              -device virtio-gpu-gl-pci \
              -display default,gl=on \
              -device virtio-net-pci,netdev=n0 \
              -netdev user,id=n0,hostfwd=tcp::2222-:22 \
              -virtfs local,path="$DOTS_PATH",mount_tag=dots,security_model=mapped-xattr,id=dots \
              -drive file="$DISK",if=virtio,format=qcow2
          '';
        };
      };
    };
}
