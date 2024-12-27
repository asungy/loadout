{ username, ... } :
{
  networking.wg-quick.interfaces = {
    protonvpn-default = {
      address = ["10.2.0.2/32"];
      dns = ["10.2.0.1"];
      privateKeyFile = "/home/${username}/.secrets/protonvpn-default-private-key";
      listenPort = 51820;

      peers = [
        {
          publicKey = "umCaW98SBPbNjApBKCo0ReYhT2AJ0QfV/ZlyWnWmVUk=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "149.102.226.225:51820";
        }
      ];
    };
  };
}
