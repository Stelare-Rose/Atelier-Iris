{ lib, ... }:
  let
  dir = ./.;
  entries = builtins.readDir dir;

  isModule = name: type:
    (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
    || (type == "directory" && builtins.pathExists (dir + "/${name}/default.nix"));

  moduleNames = builtins.attrNames (lib.filterAttrs isModule entries);
in
{
  imports = map (name: dir + "/${name}") moduleNames;
}
