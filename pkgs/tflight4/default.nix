{ stdenv, fetchFromGitHub, lib, makeWrapper, kernel ? null, kernelModuleMakeFlags ? null }:

let
  pname = "tflight4";
  version = "1.0";
in
stdenv.mkDerivation rec {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "walterschell";
    repo = "tflight4";
    rev = "03726d871d237cd691e6d4350f0f9fd8d04c518e";
    sha256 = "17qylkkzyx89ahqhf7qijk8x9j30hsj4fjn186qi1srchc03rmr4";
  };

  nativeBuildInputs = [ makeWrapper ] ++ lib.optional (kernel != null) kernel.moduleBuildDependencies;

  # Use the kernel's make flags and point the build to the kernel dev tree.
  makeFlags = lib.optional (kernel != null) (kernel.makeFlags) ++ (lib.optional (kernel != null) [
    "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ]);

  prePatch = ''
    substituteInPlace ./Makefile --replace '/lib/modules/$(shell uname -r)/build' "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${if kernel == null then "$(uname -r)" else kernel.modDirVersion}/kernel/drivers/hid
    # Prefer the built object in the working directory, or the installed path created
    # by 'make INSTALL_MOD_PATH=$(out)' as $out/lib/modules/..../kernel/drivers/hid/hid-tflight4.ko
    if [ -f hid-tflight4.ko ]; then
      cp hid-tflight4.ko $out/lib/modules/${if kernel == null then "$(uname -r)" else kernel.modDirVersion}/kernel/drivers/hid/
    elif [ -f out/hid-tflight4.ko ]; then
      cp out/hid-tflight4.ko $out/lib/modules/${if kernel == null then "$(uname -r)" else kernel.modDirVersion}/kernel/drivers/hid/
    fi
  '';

  meta = with lib; {
    description = "Linux kernel HID module for Thrustmaster T.Flight HOTAS 4";
    license = licenses.bsd3;
    homepage = https://github.com/walterschell/tflight4;
    maintainers = with maintainers; [];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
