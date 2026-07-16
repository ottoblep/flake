{ config, ... }:
{
  _module.args.wrapGL =
    pkg:
    if config.targets.genericLinux.enable then config.lib.nixGL.wrap pkg else pkg;
}
