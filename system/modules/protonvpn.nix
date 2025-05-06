{ username, ... } :
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = ["10.2.0.2/32"];
      dns = ["10.2.0.1"];
      privateKeyFile = "/home/${username}/.secrets/protonvpn-default-private-key";
      listenPort = 51820;

      peers = [
        {
          publicKey = "zAIZj//t14xuriUMSlWk4/J2jox6I/JMzHL1Y3D/WUE=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "185.156.46.33:51820";
        }
      ];
    };
  };
}
