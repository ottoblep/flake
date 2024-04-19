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
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, nixos-wsl, vscode-server, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ]; # Only used for package definitions 
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      # This overlay will be applied to all systems
      # Define custom packages here
      overlays.default = final: prev: {
        lrz-sync-share = prev.callPackage ./pkgs/lrz-sync-share { };
        sleek = prev.callPackage ./pkgs/sleek { };
        stable-diffusion-cpp-cuda = prev.callPackage ./pkgs/stable-diffusion-cpp { cudaSupport = true; };
        noita-together = prev.callPackage ./pkgs/noita-together { };
      };

      nixosConfigurations =
        let
          system-dependent-overlays = { system }: {
            # An overlay containing the entirety of unstable nixpkgs
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
              {
                nixpkgs.overlays = [
                  self.overlays.default
                  # We overlay our unstable into the stable pkgs that is passed to all systems (access via pkgs.unstable.<pkg>)
                  (system-dependent-overlays { system = system; }).overlay-unstable
                ];
              }
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
                  traits.virtualization
                  traits.tower
                  traits.graphical
                  traits.gnome
                  traits.game
                  traits.office
                  traits.media
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
                  traits.office
                  traits.gnome
                  traits.media
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
                  traits.media
                  users.sevi-minimal
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
                  traits.media
                  users.sevi-full
                ];
              };
          sevtp2 = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
                  platforms.sevtp2
                  traits.machine
                  traits.laptop
                  traits.graphical
                  traits.gnome
                  traits.media
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
                  users.sevi-headless
                ];
              };
        };

      # This presents the packages from the default overlay to the outside
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          lrz-sync-share = pkgs.lrz-sync-share;
          sleek = pkgs.sleek;
          noita-together = pkgs.noita-together;
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          py-optimize = import ./devShells/py-optimize { pkgs = pkgs; };
          py-api = import ./devShells/py-api { pkgs = pkgs; };
          py-scrape = import ./devShells/py-scrape { pkgs = pkgs; };
          rust = import ./devShells/rust { pkgs = pkgs; };
        });

      nixosModules = {
        platforms.stele = ./platforms/stele.nix;
        platforms.slab = ./platforms/slab.nix;
        platforms.sevtp = ./platforms/sevtp.nix;
        platforms.sevtp2 = ./platforms/sevtp2.nix;
        platforms.tomnuc = ./platforms/tomnuc.nix;
        platforms.wsl = ./platforms/wsl.nix;
        traits.base = ./traits/base.nix;
        traits.graphical = ./traits/graphical.nix;
        traits.media = ./traits/media.nix;
        traits.machine = ./traits/machine.nix;
        traits.virtualization = ./traits/virtualization.nix;
        traits.tower = ./traits/tower.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.nixos = ./traits/nixos.nix;
        traits.gnome = ./traits/gnome.nix;
        traits.office = ./traits/office.nix;
        traits.game = ./traits/game.nix;
        services.openssh = ./services/openssh.nix;

        users.sevi-headless = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
          ];
        });
        users.sevi-minimal = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
            ./users/sevi/graphical.nix
            ./users/sevi/gnome
          ];
        });
        users.sevi-full = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
            ./users/sevi/graphical.nix
            ./users/sevi/develop.nix
            ./users/sevi/gnome
          ];
        });
      };
    };
}
