{
  env = {
    "TERM" = "xterm-256color";
  };

  window = {
    padding.x = 10;
    padding.y = 10;
    dynamic_padding = false;
    decorations = "none";
    opacity = 0.95;
  };

  font = {
    size = 12.0;
    # normal.family = "FuraCode Nerd Font";
    # bold.family = "FuraCode Nerd Font";
    # italic.family = "FuraCode Nerd Font";
  };

  cursor.style = "Block";

  shell = {
    program = "zsh";
  };

  colors = {
    # Default colors
    primary = {
      background = "0x24273a";
      foreground = "0xcad3f5";
    };

    # Normal colors
    normal = {
      black = "0x181926";
      red = "0xed8796";
      green = "0xa6da95";
      yellow = "0xeed49f";
      blue = "0x8aadf4";
      magenta = "0xc6a0f6";
      cyan = "0x8bd5ca";
      white = "0xcad3f5";
    };
  };
}
