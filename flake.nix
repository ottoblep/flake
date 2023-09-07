{
  description = "Ottoblep Personal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-lrz-sync-share = {
      url = "github:ottoblep/nix-lrz-sync-share";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nix-lrz-sync-share, nixos-wsl, vscode-server, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      overlays.default = nix-lrz-sync-share.overlays.default;

      homeConfigurations = forAllSystems
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            };
          in
          {
            sevi = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./users/sevi/home.nix
              ];
            };
          }
        );

      nixosConfigurations =
        let
          # Shared config between both the liveimage and real system
          aarch64Base = {
            system = "aarch64-linux";
            modules = with self.nixosModules; [
              traits.overlay
              home-manager.nixosModules.home-manager
              traits.nixos
              traits.base
            ];
          };
          x86_64Base = {
            system = "x86_64-linux";
            modules = with self.nixosModules; [
              traits.overlay
              home-manager.nixosModules.home-manager
              traits.nixos
              traits.base
            ];
          };
        in
        with self.nixosModules; {
          tomnuc = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.tomnuc
              traits.machine
              traits.hyprland
              users.sevi
            ];
          };
          sevdesk = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.sevdesk
              traits.machine
              traits.gnome
              users.sevi
            ];
          };
          sevtp = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              nixos-hardware.nixosModules.lenovo-thinkpad-x250
              platforms.sevtp
              traits.machine
              traits.gnome
              users.sevi
            ];
          };
          sevtp2 = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.sevtp2
              traits.machine
              traits.gnome
              users.sevi
            ];
          };
          wsl = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              nixos-wsl.nixosModules.default
              vscode-server.nixosModules.default
              platforms.wsl
            ];
          };
        };

      nixosModules = {
        platforms.sevdesk = ./platforms/sevdesk.nix;
        platforms.sevtp = ./platforms/sevtp.nix;
        platforms.sevtp2 = ./platforms/sevtp2.nix;
        platforms.tomnuc = ./platforms/tomnuc.nix;
        platforms.wsl = ./platforms/wsl.nix;
        traits.overlay = { nixpkgs.overlays = [ self.overlays.default ]; };
        traits.base = ./traits/base.nix;
        traits.machine = ./traits/machine.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.nixos = ./traits/nixos.nix;
        traits.gnome = ./traits/gnome.nix;
        traits.hyprland = ./traits/hyprland.nix;
        services.openssh = ./services/openssh.nix;
        users.sevi = ./users/sevi;
      };
    };
}
