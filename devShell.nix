{
  gcc,
  gdb,
  mkShell,
  nixd,
  pkg-config,
  rust-bin,
}:
mkShell {
  name = "default";
  packages = [
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rust-analyzer" ];
      targets = ["wasm32-unknown-unknown"];
    })
    gcc
    gdb
    nixd
    pkg-config
  ];
  RUST_BACKTRACE = 1;
  RUST_LOG = "debug";
}
