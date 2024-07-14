self: super: {
  systemd = super.systemd.override {
    withLibBPF = false;
  };
}
