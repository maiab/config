# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "gometalinter-${version}";
  version = "20160712-${stdenv.lib.strings.substring 0 7 rev}";
  rev = "d4d8db65586d39c91beebac66fccb0e616fc8c13";

  goPackagePath = "github.com/alecthomas/gometalinter";
  subPackages = [ "." ];

  src = fetchgit {
    inherit rev;
    url = "https://github.com/alecthomas/gometalinter";
    sha256 = "0hz0sg1bi47y19l9mpcig7340r8fjaaiwc56rbnrnwnx6c2qk761";
  };

  goDeps = ./deps.json;
}
