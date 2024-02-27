{
  description = "Ottoblep Personal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, nix-lrz-sync-share, nixos-wsl, vscode-server, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      # These overlays will be applied to all systems
      # Define custom packages here
      overlays.default = nix-lrz-sync-share.overlays.default;

      # Home-Manager has separate pkgs definitions
      homeConfigurations = forAllSystems
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            };
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
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
          # We overlay unstable into the stable pkgs to be passed to all modules (accessible via pkgs.unstable.<pkg>)
          overlay-packages = { system }: {
            overlay-unstable = final: prev: {
              unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            };
          };
          # Shared base config
          base = { system }: {
            system = system;
            modules = with self.nixosModules; [
              { nixpkgs.overlays = [ self.overlays.default (overlay-packages { system = system; }).overlay-unstable ]; }
              home-manager.nixosModules.home-manager
              traits.nixos
              traits.base
            ];
          };
        in
        # Machine specific configs
        with self.nixosModules; {
          stele = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.stele
                  traits.machine
                  traits.tower
                  traits.graphical
                  traits.gnome
                  traits.game
                  traits.office
                  users.sevi-full
                ];
              };
          tomnuc = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.tomnuc
                  traits.machine
                  traits.tower
                  traits.graphical
                  traits.gnome
                  users.sevi-full
                ];
              };
          slab = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.slab
                  traits.tower
                  traits.machine
                  traits.gnome
                  users.sevi-full
                ];
              };
          sevtp = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  nixos-hardware.nixosModules.lenovo-thinkpad-x250
                  platforms.sevtp
                  traits.machine
                  traits.laptop
                  traits.graphical
                  traits.gnome
                  users.sevi-full
                ];
              };
          sevtp2 = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.sevtp2
                  traits.machine
                  traits.laptop
                  traits.graphical
                  traits.gnome
                  users.sevi-full
                ];
              };
          wsl = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.wsl
                  nixos-wsl.nixosModules.default
                  vscode-server.nixosModules.default
                  users.sevi-basic
                ];
              };
        };

      nixosModules = {
        platforms.stele = ./platforms/stele.nix;
        platforms.slab = ./platforms/slab.nix;
        platforms.sevtp = ./platforms/sevtp.nix;
        platforms.sevtp2 = ./platforms/sevtp2.nix;
        platforms.tomnuc = ./platforms/tomnuc.nix;
        platforms.wsl = ./platforms/wsl.nix;
        traits.base = ./traits/base.nix;
        traits.graphical = ./traits/graphical.nix;
        traits.machine = ./traits/machine.nix;
        traits.tower = ./traits/tower.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.nixos = ./traits/nixos.nix;
        traits.gnome = ./traits/gnome.nix;
        traits.office = ./traits/office.nix;
        traits.game = ./traits/game.nix;
        traits.hyprland = ./traits/hyprland.nix;
        services.openssh = ./services/openssh.nix;
        users.sevi-basic = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
          ];
        });
        users.sevi-full = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
            ./users/sevi/graphical.nix
            ./users/sevi/gnome
          ];
        });
      };
    };
}
