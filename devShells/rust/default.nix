{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    clippy
    rustc
    cargo
    rustfmt
    rust-analyzer
    lldb
  ];

  RUST_BACKTRACE = 1;
}
