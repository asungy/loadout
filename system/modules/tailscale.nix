{
  services.tailscale.enable = true;

  networking.firewall = {
    # Tailscale's source-based routing fails the kernel's strict reverse-path
    # filter check. "loose" is the standard workaround.
    checkReversePath = "loose";

    # Trust all traffic arriving on the Tailscale interface. This is what
    # allows SSH (and any other service) to be reachable over Tailscale
    # without opening the port globally on physical interfaces.
    trustedInterfaces = [ "tailscale0" ];
  };
}
