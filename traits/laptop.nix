/*
  Laptop specific hardware options
*/
{ pkgs, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 60;
      STOP_CHARGE_THRESH_BAT1 = 80;
      RESTORE_THRESHOLDS_ON_BAT = 1;
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # TODO Add distinct dconf for small screens
}

