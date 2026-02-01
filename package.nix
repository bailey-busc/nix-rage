{
  lib,
  craneLib,
  nix,
  pkg-config,
  boost,
  ...
}:
let
  commonArgs = {
    src = lib.cleanSourceWith {
      src = lib.cleanSource ./.;
      filter = name: type: (craneLib.filterCargoSources name type) || (lib.hasSuffix ".cpp" name);
    };
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [
      nix
      boost
    ];
    strictDeps = true;
  };
  cargoArtifacts = craneLib.buildDepsOnly commonArgs;
in
craneLib.buildPackage (
  commonArgs
  // {
    cargoArtifacts = cargoArtifacts;
    doCheck = false;
  }
)
