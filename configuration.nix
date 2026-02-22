{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "copper";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";
  
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50; 
  zramSwap.algorithm = "zstd";
  zramSwap.priority = 100;
  
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  
  services = {
  displayManager.cosmic-greeter.enable = true;
  desktopManager.cosmic.enable = true;
  desktopManager.cosmic.xwayland.enable = true;
  system76-scheduler.enable = true;
};

  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

  users.users.nano = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;

  
  environment.systemPackages = with pkgs; [
    vim
    wget
    btop
    tree
    git
    nix-ld
    wayland-utils
    cloudflare-warp
  ];

  programs.nix-ld.enable = true;
  services.openssh.enable = true;
  services.cloudflare-warp.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}
