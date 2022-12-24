{
  programs.helix.enable = true;
  programs.helix.settings = {
    editor = {
      mouse = false;
      rulers = [ 100 ];
      whitespace = {
        render = { space = "all"; tab = "all"; };
        characters = { space = "·"; tab = "→"; };
      };
    };
  };
}
