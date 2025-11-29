{ stdenv, fetchFromGitHub, lib, makeWrapper, kernel, kernelModuleMakeFlags ? null }:

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

  nativeBuildInputs = kernel.moduleBuildDependencies;

  # The upstream Makefile calls into /lib/modules/$(uname -r)/build, which
  # must be replaced by the kernel dev path when building against a Nix
  # kernel. Instead of patching the Makefile we invoke make directly against
  # the kernel tree using -C and the M=$(PWD) mechanism.
  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD modules
  '';

  installPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD INSTALL_MOD_PATH=$out modules_install
  '';

  meta = with lib; {
    description = "Linux kernel HID module for Thrustmaster T.Flight HOTAS 4";
    license = licenses.bsd3;
    homepage = https://github.com/walterschell/tflight4;
    maintainers = with maintainers; [];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
