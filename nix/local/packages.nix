with inputs.nixpkgs; let
  arch =
    if system == "x86_64-linux"
    then "amd64"
    else "arm64";

  cosmovisor_1_5_0 = stdenv.mkDerivation rec {
    pname = "cosmovisor";
    version = "1.5.0";
    src = fetchurl {
      url = "https://github.com/cosmos/cosmos-sdk/releases/download/cosmovisor%2Fv${version}/cosmovisor-v${version}-linux-${arch}.tar.gz";
      sha256 =
        if arch == "amd64"
        then "sha256-f0vr+xihcL/xxyXxPdoybgFYEy3u+fA3qwwqSHJ8MHc="
        else "sha256-4V8mJbHSCKwv7VG8hK51Z4AJiIZIrCGG/Q7Vq2F33BQ=";
    };
    sourceRoot = ".";
    dontUnpack = false;
    dontBuild = true;
    dontConfigure = true;
    dontInstall = true;
    dontPatch = true;
    dontPatchELF = true;
    postFixup = ''
      mkdir -p $out/bin
      cp cosmovisor $out/bin
    '';
  };
in {
  inherit cosmovisor_1_5_0;
}
