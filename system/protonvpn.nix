{ pkgs, username, ... } :
{
  networking.wg-quick.interfaces = {
    # test: NL-FREE#162
    proton-nl = {
      address = ["10.2.0.2/32"];
      dns = ["10.2.0.1"];
      privateKeyFile = "/home/${username}/.secrets/protonvpn-nl-private-key";
      listenPort = 51820;

      peers = [
        {
          publicKey = "aQ8bxW84kPY54cmd75U9rIHzg/mlpV1mJluXdm/6hFI=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "185.107.56.130:51820";
        }
      ];
    };
  };
}
