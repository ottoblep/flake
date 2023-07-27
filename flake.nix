{
  description = "Ottoblep Personal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      overlays.default = final: prev: { };

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
              ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
              home-manager.nixosModules.home-manager
              ({ config, ... }:
              { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; })
              traits.overlay
              traits.base
              services.openssh
            ];
          };
          x86_64Base = {
            system = "x86_64-linux";
            modules = with self.nixosModules; [
              ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
              ({ config, ... }:
              { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; })
              home-manager.nixosModules.home-manager
              traits.overlay
              traits.base
              services.openssh
            ];
          };
        in
        with self.nixosModules; {
          tomnuc = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.tomnuc
              traits.machine
              traits.workstation
              traits.gnome
              users.sevi
            ];
          };
          sevdesk = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.sevdesk
              traits.machine
              traits.workstation
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
              traits.workstation
              traits.gnome
              users.sevi
            ];
          };
          sevtp2 = nixpkgs.lib.nixosSystem {
            inherit (x86_64Base) system;
            modules = x86_64Base.modules ++ [
              platforms.sevtp2
              traits.overlay
              traits.machine
              traits.workstation
              traits.gnome
              users.sevi
            ];
          };
        };

      nixosModules = {
        platforms.sevdesk = ./platforms/sevdesk.nix;
        platforms.sevtp = ./platforms/sevtp.nix;
        platforms.sevtp2 = ./platforms/sevtp2.nix;
        platforms.tomnuc = ./platforms/tomnuc.nix;
        traits.overlay = { nixpkgs.overlays = [ self.overlays.default ]; };
        traits.base = ./traits/base.nix;
        traits.machine = ./traits/machine.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.workstation = ./traits/workstation.nix;
        traits.gnome = ./traits/gnome.nix;
        services.openssh = ./services/openssh.nix;
        users.sevi = ./users/sevi;
      };
    };
}
