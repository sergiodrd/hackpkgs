{ buildPythonPackage, fetchPypi }:
buildPythonPackage rec {
  pname = "argparse";
  version = "1.4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "62b089a55be1d8949cd2bc7e0df0bddb9e028faefc8c32038cc84862aefdd6e4";
  };
}
