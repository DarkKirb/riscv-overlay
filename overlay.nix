let
  inherit (builtins) length elemAt;
  # Copied from nixpkgs
  /*
  *
  “right fold” a binary function `op` between successive elements of
  `list` with `nul` as the starting value, i.e.,
  `foldr op nul [x_1 x_2 ... x_n] == op x_1 (op x_2 ... (op x_n nul))`.


  # Inputs

  `op`

  : 1\. Function argument

  `nul`

  : 2\. Function argument

  `list`

  : 3\. Function argument

  # Type

  ```
  foldr :: (a -> b -> b) -> b -> [a] -> b
  ```

  # Examples
  :::{.example}
  ## `lib.lists.foldr` usage example

  ```nix
  concat = foldr (a: b: a + b) "z"
  concat [ "a" "b" "c" ]
  => "abcz"
  # different types
  strange = foldr (int: str: toString (int + 1) + str) "a"
  strange [ 1 2 3 4 ]
  => "2345a"
  ```

  :::
  */
  foldr = op: nul: list: let
    len = length list;
    fold' = n:
      if n == len
      then nul
      else op (elemAt list n) (fold' (n + 1));
  in
    fold' 0;
  /*
  *
    Compose two extending functions of the type expected by 'extends'
    into one where changes made in the first are available in the
    'super' of the second


    # Inputs

    `f`

    : 1\. Function argument

    `g`

    : 2\. Function argument

    `final`

    : 3\. Function argument

    `prev`

    : 4\. Function argument
  */
  composeExtensions = f: g: final: prev: let
    fApplied = f final prev;
    prev' = prev // fApplied;
  in
    fApplied // g final prev';

  /*
  *
  Compose several extending functions of the type expected by 'extends' into
  one where changes made in preceding functions are made available to
  subsequent ones.

  ```
  composeManyExtensions : [packageSet -> packageSet -> packageSet] -> packageSet -> packageSet -> packageSet
                            ^final        ^prev         ^overrides     ^final        ^prev         ^overrides
  ```
  */
  composeManyExtensions =
    foldr (x: y: composeExtensions x y) (final: prev: {});
in
  composeManyExtensions [
    (import ./overlays/ghc.nix)
    (import ./overlays/require-native-build.nix)
    (import ./overlays/test-timeouts.nix)
  ]
