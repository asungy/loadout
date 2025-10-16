{ pkgs, ... } :
{
  # Update dynamic DNS service.
  systemd.services.duckdns =
  let
    # FIXME: Move this to SOPS. This is not pure.
    #
    # Example JSON at /etc/nixos/duckdns.json:
    # {
    #  "domain": "<domain>",
    #  "token": "<token>"
    # }
    duckdnsSecrets = builtins.fromJSON (builtins.readFile /etc/nixos/duckdns.json);
  in
  {
    description = "Update DuckDNS";
    path = [
      pkgs.curl
    ];
    script = ''
      curl "https://www.duckdns.org/update?domains=${duckdnsSecrets.domain}&token=${duckdnsSecrets.token}&ip="
    '';
    startAt = "hourly";
  };
  systemd.timers.duckdns.timerConfig.RandomizedDelaySec = "15m";
}
