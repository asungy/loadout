{ pkgs, username, ... } :
{
  # Install Plover (stenography software).
  environment.systemPackages = [ pkgs.plover_5 ];

  # Register Plover's bundled udev rules so the steno keyboard is accessible.
  services.udev.packages = [ pkgs.plover_5 ];

  # The `input` group grants read access to /dev/input/* devices, which Plover
  # needs to grab keyboard events directly (machine emulation and keyboard
  # passthrough both require this).
  # The `dialout` group grants access to serial ports (/dev/ttyUSB*, /dev/serial/*),
  # which Plover needs to communicate with steno keyboards over USB serial.
  users.users.${username}.extraGroups = [ "input" "dialout" ];
}
