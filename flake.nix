{
  description = "Ottoblep Personal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-gnome48.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-gnome48, nixos-hardware, home-manager, vscode-server, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ]; # Only used for package definitions 
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    rec
    {
      # This overlay will be applied to all systems
      # Define custom packages here (access via pkgs.mypkgs.<pkg>)
      overlays.default = final: prev: {
        mypkgs = {
          noita-together = prev.callPackage ./pkgs/noita-together { };
        };
      };

      # This presents the packages from the overlay as flake outputs 
      packages = forAllSystems (system:
        (import nixpkgs { inherit system; overlays = [ self.overlays.default ]; config.allowUnfree = true; }).mypkgs //
        (nixpkgs.lib.optionalAttrs (system == "aarch64-linux") {
          pihole-image = nixosConfigurations.pihole.config.system.build.sdImage;
        })
      );

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          py-numeric = import ./devShells/py-numeric { pkgs = pkgs; };
          py-scrape = import ./devShells/py-scrape { pkgs = pkgs; };
          py-yolo = import ./devShells/py-yolo { pkgs = pkgs; };
          rust = import ./devShells/rust { pkgs = pkgs; };
        });

      nixosConfigurations =
        let
          system-dependent-overlays = { system }: {
            system-resolved-overlays = final: prev: {
              # An overlay containing the entirety of unstable nixpkgs
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
                  (system-dependent-overlays { system = system; }).system-resolved-overlays
                ];
              }
              home-manager.nixosModules.home-manager
              traits.nixos
              traits.base
            ];
          };
          mkHome = modules: {
            home-manager.users.sevi.imports = [ ./users/sevi/state-version.nix ] ++ modules;
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
                  traits.embedded
                  traits.tower
                  traits.virtualization
                  traits.gnome
                  traits.game
                  services.rdp
                  services.nix-serve
                  services.avahi
                  users.sevi
                  (mkHome (with self.homeModules; [
                    shell
                    git
                    gnome
                    gnome-extensions
                    desktop
                    graphical
                    office
                    comms
                    media
                    vsc
                    rclone
                  ]))
                ];
              };
          tomnuc = let system = "x86_64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.tomnuc
                  traits.machine
                  traits.embedded
                  traits.tower
                  traits.gnome
                  traits.music
                  services.avahi
                  users.sevi
                  (mkHome (with self.homeModules; [
                    shell
                    git
                    gnome
                    gnome-extensions
                    desktop
                    graphical
                    media
                    vsc
                    rclone
                  ]))
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
                  traits.embedded
                  traits.gnome
                  traits.kiosk
                  services.avahi
                  users.sevi
                  users.sevi-sudo
                  (mkHome (with self.homeModules; [
                    shell
                    git
                    gnome
                    gnome-extensions
                    desktop
                  ]))
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
                  traits.embedded
                  traits.laptop
                  traits.gnome
                  traits.music
                  services.rdp
                  services.avahi
                  users.sevi
                  (mkHome (with self.homeModules; [
                    shell
                    git
                    gnome
                    gnome-extensions
                    desktop
                    graphical
                    media
                    vsc
                    rclone
                  ]))
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
                  traits.embedded
                  traits.laptop
                  traits.virtualization
                  traits.gnome
                  traits.game
                  traits.music
                  services.rdp
                  services.avahi
                  users.sevi
                  (mkHome (with self.homeModules; [
                    shell
                    git
                    gnome
                    gnome-extensions
                    desktop
                    graphical
                    office
                    comms
                    media
                    vsc
                    rclone
                  ]))
                ];
              };
          pihole = let system = "aarch64-linux"; in
            nixpkgs.lib.nixosSystem
              {
                system = system;
                modules = (base { system = system; }).modules ++ [
                  platforms.pihole
                  services.avahi
                  services.auto-upgrade
                  services.openssh
                  services.pihole
                  users.sevi
                  users.sevi-sudo
                  (mkHome (with self.homeModules; [
                    shell
                    git
                  ]))
                  traits.embedded
                  {
                    boot.zfs.forceImportRoot = false;
                  }
                ];
              };
        };

      nixosModules = {
        platforms.stele = ./platforms/stele.nix;
        platforms.slab = ./platforms/slab.nix;
        platforms.sevtp = ./platforms/sevtp.nix;
        platforms.sevtp2 = ./platforms/sevtp2.nix;
        platforms.tomnuc = ./platforms/tomnuc.nix;
        platforms.pihole = ./platforms/pihole.nix;

        traits.base = ./traits/base.nix;
        traits.music = ./traits/music.nix;
        traits.machine = ./traits/machine.nix;
        traits.virtualization = ./traits/virtualization.nix;
        traits.tower = ./traits/tower.nix;
        traits.laptop = ./traits/laptop.nix;
        traits.nixos = ./traits/nixos.nix;
        traits.gnome = ./traits/gnome.nix;
        traits.game = ./traits/game.nix;
        traits.kiosk = ./traits/kiosk.nix;
        traits.embedded = ./traits/embedded.nix;

        services.rdp = ./services/rdp.nix;
        services.openssh = ./services/openssh.nix;
        services.nix-serve = ./services/nix-serve.nix;
        services.auto-upgrade = ./services/auto-upgrade.nix;
        services.avahi = ./services/avahi.nix;
        services.pihole = ./services/pihole.nix;
        services.probe-rs = ./services/probe-rs.nix;

        users.sevi = ./users/sevi/default.nix;
        users.sevi-sudo = ./users/sevi/sudo.nix;
      };

      homeModules = {
        shell = ./users/sevi/shell.nix;
        git = ./users/sevi/git.nix;
        gnome = ./users/sevi/gnome;
        gnome-extensions = ./users/sevi/gnome/extensions.nix;
        desktop = ./users/sevi/desktop.nix;
        graphical = ./users/sevi/graphical.nix;
        office = ./users/sevi/office.nix;
        media = ./users/sevi/media.nix;
        comms = ./users/sevi/comms.nix;
        vsc = ./users/sevi/vsc.nix;
        rclone = ./users/sevi/rclone.nix;
      };

      homeConfigurations =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
              # Expose unstable nixpkgs as pkgs.unstable, matching the NixOS setup
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
              # Override extensions to gnome 48 to match debian version
              (final: prev: {
                gnomeExtensions = (import nixpkgs-gnome48 {
                  inherit system;
                  config.allowUnfree = true;
                }).gnomeExtensions;
              })
            ];
            config.allowUnfree = true;
            config.allowBroken = true;
          };
          mkStandaloneHome = modules: home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./users/sevi/state-version.nix
              { targets.genericLinux.enable = true; }
            ] ++ modules;
          };
        in
        {
          debian13 = mkStandaloneHome (with self.homeModules; [
            shell
            git
            gnome
            gnome-extensions
            desktop
            graphical
            office
            media
            comms
            vsc
            rclone
          ]);
        };
    };
}
