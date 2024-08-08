{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "csv-tui";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "nathangavin";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-IRXLwZ2FHcCDmDVJ0xnV/4q+X2AFXPX/+Ph4Xxo3DyM=";
  };

  cargoHash = "sha256-wgeVcX0zSXffAuvKw2eKXC846WlC8F9UGMoxP3IXoLE=";

  meta = {
    description = "A terminal based csv editor which is designed to be not a ram hog like standard csv editors, but more useful than other text editors";
    homepage = "https://github.com/nathangavin/csv-tui";
    license = lib.licenses.unfree;
    maintainers = [ ];
  };
}
