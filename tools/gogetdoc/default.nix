# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "gogetdoc-${version}";
  version = "20160710-${stdenv.lib.strings.substring 0 7 rev}";
  rev = "2f2de98cbfb125bd27b382a2c0b75a64f8a81fb5";

  goPackagePath = "github.com/zmb3/gogetdoc";
  subPackages = [ "." ];

  src = fetchgit {
    inherit rev;
    url = "https://github.com/zmb3/gogetdoc";
    sha256 = "05w0g0331k55spp22ls2cymd31ifv0g3bidjh1nd5a62844vp6qg";
  };

  goDeps = ./deps.json;
}