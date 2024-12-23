{ username, ... } :
{
  networking.wg-quick.interfaces = {
    protonvpn-ny = {
      address = ["10.2.0.2/32"];
      dns = ["10.2.0.1"];
      privateKeyFile = "/home/${username}/.secrets/protonvpn-ny-private-key";
      listenPort = 51820;

      peers = [
        {
          publicKey = "LMkFEUVVqWl1di39x+CloLdXXH/X9P/vKXeVXohvqlc=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "146.70.72.162:51820";
        }
      ];
    };
  };
}
