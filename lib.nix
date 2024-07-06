# Helper for importing the nixpkgs library
let
  lockfile = builtins.fromJSON (builtins.readFile ./flake.lock);
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs";
    rev = lockfile.nodes.nixpkgs.locked.rev;
    narHash = lockfile.nodes.nixpkgs.locked.narHash;
  };
in
  import "${nixpkgs}/lib"
