{ inputs, lib, config, ... }:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake = {
    nixosConfigurations = lib.mapAttrs
      (_: { module }: inputs.nixpkgs.lib.nixosSystem { modules = [ module ]; })
      config.configurations.nixos;

    checks =
      lib.mkMerge (lib.mapAttrsToList
        (name: nixos: {
          ${nixos.config.nixpkgs.hostPlatform.system}."configurations:nixos:${name}" =
            nixos.config.system.build.toplevel;
        })
        config.flake.nixosConfigurations);
  };
}
