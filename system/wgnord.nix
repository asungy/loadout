{ pkgs, ... } :
{
  # HACK: Create file/directories for wgnord (NordVPN)
  system.activationScripts.wgnordTemplateConfig =
  let
    wgnordTemplateConfig = pkgs.writeTextFile {
      name = "template.conf";
      text = ''
        [Interface]
        PrivateKey = PRIVKEY
        Address = 10.5.0.2/32
        MTU = 1350
        DNS = 103.86.96.100 103.86.99.100

        [Peer]
        PublicKey = SERVER_PUBKEY
        AllowedIPs = 0.0.0.0/0, ::/0
        Endpoint = SERVER_IP:51820
        PersistentKeepalive = 25
      '';
    };
    wgnordConfigDir = "/var/lib/wgnord";
    wireguardEtcDir = "/etc/wireguard";
  in
  ''
    mkdir -p ${wireguardEtcDir}
    chown root:root ${wireguardEtcDir}
    chmod 0700 ${wireguardEtcDir}

    mkdir -p ${wgnordConfigDir}
    chown root:root ${wgnordConfigDir}
    chmod 0700 ${wgnordConfigDir}

    cp ${wgnordTemplateConfig} ${wgnordConfigDir}/template.conf
    chown root:root ${wgnordConfigDir}/template.conf
    chmod 0700 ${wgnordConfigDir}/template.conf
  '';

}
