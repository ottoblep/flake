{
  description = "Ottoblep Personal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
      # Define custom packages here (access via pkgs.mypkgs.<pkg>)
      overlays.default = final: prev: {
        mypkgs = {
          lrz-sync-share = prev.callPackage ./pkgs/lrz-sync-share { };
          stable-diffusion-cpp-cuda = prev.callPackage ./pkgs/stable-diffusion-cpp { cudaSupport = true; };
          noita-together = prev.callPackage ./pkgs/noita-together { };
        };
      };

      # This presents the packages from the overlay as flake outputs 
      packages = forAllSystems (system:
        (import nixpkgs { inherit system; overlays = [ self.overlays.default ]; config.allowUnfree = true; }).mypkgs
      );

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          py-optimize = import ./devShells/py-optimize { pkgs = pkgs; };
          py-numeric = import ./devShells/py-numeric { pkgs = pkgs; };
          py-api = import ./devShells/py-api { pkgs = pkgs; };
          py-scrape = import ./devShells/py-scrape { pkgs = pkgs; };
          py-yolo = import ./devShells/py-yolo { pkgs = pkgs; };
          rust = import ./devShells/rust { pkgs = pkgs; };
        });

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
                  # Overlay unstable into stable pkgs that is passed to all systems (access via pkgs.unstable.<pkg>)
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
                  traits.tower
                  traits.virtualization
                  traits.graphical
                  traits.gnome
                  traits.game
                  traits.comms
                  traits.office
                  traits.compute
                  traits.media
                  services.nix-serve
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
                  traits.media
                  traits.music
                  users.sevi-instruments
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
                  traits.comms
                  traits.office
                  traits.media
                  traits.virtualization
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
        traits.comms = ./traits/comms.nix;
        traits.music = ./traits/music.nix;
        traits.machine = ./traits/machine.nix;
        traits.compute = ./traits/compute.nix;
        traits.virtualization = ./traits/virtualization.nix;
        traits.tower = ./traits/tower.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.nixos = ./traits/nixos.nix;
        traits.gnome = ./traits/gnome.nix;
        traits.office = ./traits/office.nix;
        traits.game = ./traits/game.nix;
        services.openssh = ./services/openssh.nix;
        services.nix-serve = ./services/nix-serve.nix;

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
        users.sevi-instruments = ({ lib, ... }: {
          imports = [ ./users/sevi ];
          home-manager.users.sevi = lib.mkMerge [
            ./users/sevi/home.nix
            ./users/sevi/graphical.nix
            ./users/sevi/develop.nix
            ./users/sevi/music.nix
            ./users/sevi/gnome
          ];
        });
      };
    };
}
