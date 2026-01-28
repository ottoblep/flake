/*
  Virtualization related options
*/
{ pkgs, ... }:
{
  virtualisation.podman = {
      enable = true;
      # enableOnBoot = true;
      # package = pkgs.docker_25;
      # Nvidia Docker (deprecated)
      #enableNvidia = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    wireshark
  ];

  # Emulate ESP32: nix run github:SFrijters/nix-qemu-espressif#qemu-esp32

  # Impure Single container example 
  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers."gnbsim" = {
  #     image = "rohankharade/gnbsim:latest";
  #     hostname = "gnbsim";
  #     environment = {
  #       USE_FQDN = "false";
  #     };
  #   };
  # };

  # Impure Docker compose example
  # systemd.services.example-docker-compose = 
  # let
  #   repo = pkgs.fetchFromGitLab {
  #       domain = "gitlab.eurecom.fr";
  #       owner = "oai";
  #       repo = "openairinterface5g";
  #       rev = "develop";
  #       hash = "sha256-tCaryumCl7/7DXDMBeFpP3VHhvsaSPFvCq9tDTk2vsE=";
  #     };
  # in
  # {
  #     script = ''
  #       ${pkgs.docker}/bin/docker compose -f ${repo}/ci-scripts/yaml_files/5g_rfsimulator/docker-compose.yaml up -d mysql oai-amf oai-smf oai-upf oai-ext-dn
  #       sleep 5 
  #       ${pkgs.docker}/bin/docker compose ps -a
  #     '';
  #     wantedBy = ["multi-user.target"];
  #     # If you use podman
  #     # after = ["podman.service" "podman.socket"];
  #     # If you use docker
  #     after = ["docker.service" "docker.socket"];
  # };
}

