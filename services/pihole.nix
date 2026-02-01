{ pkgs, lib, ... }:
{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    openFirewallWebserver = true;

    # Settings documented at <https://docs.pi-hole.net/ftldns/configfile/>
    settings = {
        dns.upstreams = [ "1.1.1.1" ];   # To use Cloudflare's DNS Servers
    };

    lists = [
        {
            url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt";
            type = "block";
            enabled = true;
            description = "Default blocklist by hagezi";
        }
    ];
  };
}